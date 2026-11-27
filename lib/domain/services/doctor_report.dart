import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/localization/labels.dart';
import '../../core/utils/app_calendar.dart';
import '../../data/models/daily_log.dart';
import '../../data/models/user_profile.dart';
import '../../l10n/generated/app_localizations.dart';
import '../engine/cycle_engine.dart';
import '../engine/pattern_finder.dart';
import 'doctor_report_kit.dart';
import 'doctor_report_sections.dart';
import 'doctor_report_stats.dart';

/// گزارش PDF خلاصه‌ی چرخه‌ها برای نشون دادن به پزشک.
///
/// کاملاً روی گوشی ساخته می‌شه؛ فقط وقتی کاربر خودش «اشتراک‌گذاری» رو
/// بزنه از برنامه بیرون می‌ره.
abstract final class DoctorReport {
  /// آمار علائم، خلق‌وخو و درد روی این تعداد روز اخیر حساب می‌شه.
  static const statsWindowDays = 90;

  /// حداکثر تعداد چرخه‌ها در جدول.
  static const maxCycleRows = 12;

  static Future<Uint8List> build({
    required AppLocalizations l10n,
    required AppCalendar calendar,
    required CycleSnapshot cycle,
    required Map<String, DailyLog> logs,
    required UserProfile profile,
    required DateTime today,
    required ByteData regularFont,
    required ByteData boldFont,
    List<PersonalPattern> patterns = const [],
  }) {
    final rtl = calendar.lang == 'fa' || calendar.lang == 'ar';
    final n = calendar.n;

    final regular = pw.Font.ttf(regularFont);
    final bold = pw.Font.ttf(boldFont);

    final kit = ReportKit(regular: regular, bold: bold);
    final text = kit.text;
    final section = kit.section;
    final keyValue = kit.keyValue;
    final table = kit.table;

    // ---------- آمار ۹۰ روز اخیر ----------
    final stats = ReportStats.from(logs, today, windowDays: statsWindowDays);

    // ---------- محتوا ----------
    final summary = ReportSections.summaryRows(
      kit: kit,
      l10n: l10n,
      calendar: calendar,
      cycle: cycle,
    );
    final cycleRows = ReportSections.cycleRows(
      l10n: l10n,
      calendar: calendar,
      cycle: cycle,
      maxRows: maxCycleRows,
    );

    final content = <pw.Widget>[
      // ---------- سربرگ ----------
      pw.Container(
        padding: const pw.EdgeInsets.all(14),
        decoration: pw.BoxDecoration(
          color: ReportKit.soft,
          borderRadius: pw.BorderRadius.circular(10),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            text(
              l10n.reportTitle,
              size: 18,
              isBold: true,
              color: ReportKit.accent,
            ),
            pw.SizedBox(height: 6),
            if (profile.name.trim().isNotEmpty)
              text('${l10n.yourName}: ${profile.name.trim()}'),
            text(l10n.reportGenerated(calendar.dayMonthYear(today))),
            text(
              n(l10n.reportWindow(statsWindowDays, stats.loggedDays)),
              color: ReportKit.muted,
              size: 9,
            ),
          ],
        ),
      ),

      section(l10n.reportSummary, summary),

      if (cycleRows.isNotEmpty)
        section(l10n.cycleHistory, [
          table([
            l10n.reportStart,
            l10n.cycleLength,
            l10n.periodLength,
          ], cycleRows),
          pw.SizedBox(height: 4),
          text(l10n.reportUnitsNote, size: 8.5, color: ReportKit.muted),
        ]),

      section(
        '${l10n.topSymptoms} (${l10n.last90Days})',
        stats.topSymptoms.isEmpty
            ? [text(l10n.noSymptomsLogged, color: ReportKit.muted)]
            : [
                for (final entry in stats.topSymptoms.take(8))
                  keyValue(
                    Labels.symptom(l10n, entry.key),
                    n(l10n.reportTimes(entry.value)),
                  ),
              ],
      ),

      section(
        '${l10n.moodSummary} (${l10n.last90Days})',
        stats.topMoods.isEmpty
            ? [text(l10n.noMoodLogged, color: ReportKit.muted)]
            : [
                for (final entry in stats.topMoods)
                  keyValue(
                    Labels.mood(l10n, entry.key),
                    n(l10n.reportTimes(entry.value)),
                  ),
              ],
      ),

      if (patterns.isNotEmpty)
        section(l10n.patternsTitle, [
          for (final pattern in patterns)
            keyValue(
              Labels.patternSubject(l10n, pattern),
              n(Labels.patternWhen(l10n, pattern)),
            ),
        ]),

      section(l10n.pain, [
        keyValue(l10n.reportPainDays, n(l10n.reportTimes(stats.painDays))),
      ]),

      pw.SizedBox(height: 22),
      text(l10n.medicalDisclaimer, size: 8.5, color: ReportKit.muted),
    ];

    final document = pw.Document(
      title: l10n.reportTitle,
      author: l10n.appTitle,
      creator: l10n.appTitle,
    );

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(36, 36, 36, 30),
        textDirection: rtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
        theme: pw.ThemeData.withFont(base: regular, bold: bold),
        footer: (context) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10),
          child: pw.Row(
            children: [
              pw.Expanded(
                child: text(l10n.reportFooter, size: 8, color: ReportKit.muted),
              ),
              text(
                n('${context.pageNumber} / ${context.pagesCount}'),
                size: 8,
                color: ReportKit.muted,
              ),
            ],
          ),
        ),
        build: (context) => content,
      ),
    );

    return document.save();
  }
}
