import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_logo.dart';

/// دکمه‌ی گرد کوچک کنار عنوان (بستن، حذف، تقویم).
class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String? tooltip;
  final VoidCallback? onPressed;

  const _RoundIconButton({
    required this.icon,
    this.color,
    this.tooltip,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: context.scheme.surface,
      shape: CircleBorder(
        side: BorderSide(
          color: context.theme.dividerColor.withValues(alpha: 0.6),
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 22, color: color ?? context.subtitle),
        ),
      ),
    );
    final text = tooltip;
    return text == null ? button : Tooltip(message: text, child: button);
  }
}

/// دستگیره + عنوان و تاریخ وسط + دکمه‌ی گرد در دو طرف
/// (حذف یا تقویم در ابتدا، بستن در انتها).
class LogSheetHeader extends StatelessWidget {
  final AppCalendar calendar;
  final DateTime date;
  final VoidCallback? onDelete;

  const LogSheetHeader({
    super.key,
    required this.calendar,
    required this.date,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final onDeleteTap = onDelete;
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: context.theme.dividerColor,
            borderRadius: AppRadius.br4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
          child: Row(
            children: [
              if (onDeleteTap != null)
                _RoundIconButton(
                  icon: Icons.delete_outline_rounded,
                  color: context.scheme.error,
                  tooltip: l10n.delete,
                  onPressed: onDeleteTap,
                )
              else
                _RoundIconButton(
                  icon: Icons.calendar_today_rounded,
                  color: context.scheme.primary,
                ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      l10n.dailyCheckIn,
                      textAlign: TextAlign.center,
                      style: context.text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      calendar.weekdayDayMonth(date),
                      textAlign: TextAlign.center,
                      style: context.text.bodySmall?.copyWith(
                        color: context.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              _RoundIconButton(
                icon: Icons.close_rounded,
                tooltip: l10n.cancel,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ماه و سلام بالای فرم؛ وقتی همه‌ی کارت‌ها بسته‌ن دیده می‌شه.
class LogHero extends StatelessWidget {
  const LogHero({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 18),
      child: Column(
        children: [
          const MoonEmblem(size: 132),
          const SizedBox(height: 6),
          Text(
            l10n.logHeroTitle,
            textAlign: TextAlign.center,
            style: context.text.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 14,
                color: context.scheme.primary.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              Text(
                l10n.logHeroSubtitle,
                style: context.text.bodySmall?.copyWith(
                  color: context.subtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// دکمه‌ی بزرگ «ذخیره» پایین فرم.
class LogSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.br26),
          ),
          child: Text(
            l10n.save,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
