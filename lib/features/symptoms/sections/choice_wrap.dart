import 'package:flutter/material.dart';

import 'soft_chip.dart';

/// گزینه‌های تک‌انتخابیِ هم‌عرض در یک ردیف (خونریزی، درد، انرژی).
/// لمس گزینه‌ی انتخاب‌شده، انتخاب رو پاک می‌کنه (`null`).
/// اگه گزینه‌ها زیاد باشن (بیشتر از ۳)، به چند ردیف می‌شکنن.
class ChoiceWrap<T> extends StatelessWidget {
  final List<T> values;
  final T? selected;
  final ValueChanged<T?> onChanged;
  final String Function(T value) labelOf;

  const ChoiceWrap({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.labelOf,
  });

  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    // ۴ گزینه‌ی کوتاه هم هنوز تو یک ردیف جا می‌شن (مثل درد: ۰ تا ۳)
    final perRow = values.length <= 4 ? values.length : 3;
    final rows = <List<T>>[
      for (var i = 0; i < values.length; i += perRow)
        values.sublist(i, i + perRow > values.length ? values.length : i + perRow),
    ];

    return Column(
      children: [
        for (var r = 0; r < rows.length; r++) ...[
          if (r > 0) const SizedBox(height: _gap),
          Row(
            children: [
              for (var c = 0; c < perRow; c++) ...[
                if (c > 0) const SizedBox(width: _gap),
                Expanded(
                  child: c < rows[r].length
                      ? SoftSegment(
                          label: labelOf(rows[r][c]),
                          selected: selected == rows[r][c],
                          onTap: () => onChanged(
                            selected == rows[r][c] ? null : rows[r][c],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

/// خلق‌وخو: کاشی‌های بلند، ۳ تا در هر ردیف.
class MoodGrid<T> extends StatelessWidget {
  final List<T> values;
  final T? selected;
  final ValueChanged<T?> onChanged;
  final String Function(T value) labelOf;
  final IconData Function(T value) iconOf;

  const MoodGrid({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.labelOf,
    required this.iconOf,
  });

  static const _gap = 8.0;
  static const _columns = 3;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - _gap * (_columns - 1)) / _columns;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final value in values)
              SizedBox(
                width: width,
                child: SoftTile(
                  label: labelOf(value),
                  icon: iconOf(value),
                  selected: selected == value,
                  onTap: () => onChanged(selected == value ? null : value),
                ),
              ),
          ],
        );
      },
    );
  }
}
