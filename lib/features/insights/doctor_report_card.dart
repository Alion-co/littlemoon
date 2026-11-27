import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_assets.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/doctor_report.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:printing/printing.dart';

/// کارت «گزارش برای پزشک» در صفحه‌ی تحلیل: PDF رو می‌سازه و پنجره‌ی
/// اشتراک‌گذاری گوشی رو باز می‌کنه.
class DoctorReportCard extends ConsumerStatefulWidget {
  const DoctorReportCard({super.key});

  @override
  ConsumerState<DoctorReportCard> createState() => _DoctorReportCardState();
}

class _DoctorReportCardState extends ConsumerState<DoctorReportCard> {
  bool _busy = false;

  Future<void> _share() async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _busy = true);

    try {
      final bytes = await DoctorReport.build(
        l10n: l10n,
        calendar: ref.read(appCalendarProvider),
        cycle: ref.read(cycleProvider),
        logs: ref.read(logsProvider),
        profile: ref.read(profileProvider),
        today: ref.read(todayProvider),
        regularFont: await rootBundle.load(AppAssets.fontRegular),
        boldFont: await rootBundle.load(AppAssets.fontBold),
        patterns: ref.read(patternsProvider),
      );

      // برگشتن از پنجره‌ی اشتراک‌گذاری نباید برنامه رو قفل کنه
      ref.read(appLockProvider.notifier).ignoreNextBackground();
      await Printing.sharePdf(bytes: bytes, filename: 'little-moon-report.pdf');
    } catch (error) {
      debugPrint('Doctor report failed: $error');
      if (mounted) showAppSnackBar(context, l10n.reportFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MoonCard(
      onTap: _busy ? null : _share,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: context.scheme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: _busy
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.scheme.primary,
                    ),
                  )
                : Icon(
                    Icons.picture_as_pdf_outlined,
                    color: context.scheme.primary,
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.doctorReport,
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.doctorReportHint,
                  style: context.text.bodySmall?.copyWith(
                    color: context.subtitle,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.ios_share_rounded, size: 20, color: context.subtitle),
        ],
      ),
    );
  }
}
