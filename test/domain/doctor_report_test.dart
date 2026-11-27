import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/constants/app_assets.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/models/user_profile.dart';
import 'package:little_moon/domain/services/doctor_report.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import '../helpers/cycle_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('گزارش PDF', () {
    Future<File> buildReport(String lang, CalendarType type) async {
      final regular = await rootBundle.load(AppAssets.fontRegular);
      final bold = await rootBundle.load(AppAssets.fontBold);
      final today = DateTime.utc(2026, 9, 5);
      final logs = <String, DailyLog>{
        '2026-08-25': DailyLog(
          date: DateTime.utc(2026, 8, 25),
          flow: FlowLevel.heavy,
          mood: Mood.sensitive,
          pain: 3,
          symptoms: const {'cramps', 'backPain'},
        ),
        '2026-08-26': DailyLog(
          date: DateTime.utc(2026, 8, 26),
          flow: FlowLevel.medium,
          mood: Mood.calm,
          pain: 2,
          symptoms: const {'cramps', 'fatigue'},
        ),
      };
      final bytes = await DoctorReport.build(
        l10n: lookupAppLocalizations(Locale(lang)),
        calendar: AppCalendar(type: type, lang: lang),
        cycle: sampleCycle(),
        logs: logs,
        profile: const UserProfile(name: 'مریم'),
        today: today,
        regularFont: regular,
        boldFont: bold,
      );
      final file = File('build/test_reports/report_$lang.pdf');
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);
      return file;
    }

    test('فارسی', () async {
      final file = await buildReport('fa', CalendarType.jalali);
      expect(await file.length(), greaterThan(1000));
    });

    test('انگلیسی', () async {
      final file = await buildReport('en', CalendarType.gregorian);
      expect(await file.length(), greaterThan(1000));
    });
  });
}
