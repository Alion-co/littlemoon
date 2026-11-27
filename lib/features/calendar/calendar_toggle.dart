part of 'calendar_page.dart';

/// تاگل بین نمایش ماهانه و هفتگی
class _ViewModeToggle extends StatelessWidget {
  final CalendarViewMode mode;
  final ValueChanged<CalendarViewMode> onChanged;

  const _ViewModeToggle({required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br20,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButton(
              label: l10n.month,
              selected: mode == CalendarViewMode.month,
              onTap: () => onChanged(CalendarViewMode.month),
            ),
          ),
          Expanded(
            child: _ToggleButton(
              label: l10n.week,
              selected: mode == CalendarViewMode.week,
              onTap: () => onChanged(CalendarViewMode.week),
            ),
          ),
          Expanded(
            child: _ToggleButton(
              label: l10n.year,
              selected: mode == CalendarViewMode.year,
              onTap: () => onChanged(CalendarViewMode.year),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? context.scheme.primary : Colors.transparent,
          borderRadius: AppRadius.br16,
        ),
        child: Text(
          label,
          style: context.text.labelLarge?.copyWith(
            color: selected
                ? context.scheme.onPrimary
                : context.scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
