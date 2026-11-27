import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/haptics.dart';

/// یک ستون از خلاصه‌ی کارتِ بسته: عنوان + مقدار (یا «—»).
class LogSummaryItem {
  final String label;
  final String? value;

  const LogSummaryItem(this.label, this.value);
}

/// کارت جمع‌شونده‌ی فرم: سربرگ (آیکن + عنوان + فلش)، و زیرش یا خلاصه‌ی
/// مقدارها (بسته) یا خود فیلدها (باز).
class LogCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool expanded;
  final VoidCallback onToggle;

  /// خلاصه‌ی سه‌ستونه‌ی حالت بسته. اگه `null` باشه، کارت بسته فقط سربرگ داره.
  final List<LogSummaryItem>? summary;
  final Widget body;

  const LogCard({
    super.key,
    required this.icon,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.body,
    this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    final items = summary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br26,
        border: Border.all(
          color: context.theme.dividerColor.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Haptics.tap();
              onToggle();
            },
            borderRadius: AppRadius.br26,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withValues(alpha: 0.10),
                    ),
                    child: Icon(icon, size: 22, color: primary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: context.text.titleSmall?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: context.scheme.onSurface,
                      ),
                    ),
                  ),
                  // بسته: فلش رو به پایین، باز: می‌چرخه و رو به بالا می‌شه
                  // (فلش بالا/پایین در RTL آینه نمی‌شه، پس همه‌جا یکسانه)
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 26,
                      color: context.subtitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 260),
            sizeCurve: Curves.easeOutCubic,
            firstCurve: Curves.easeOut,
            secondCurve: Curves.easeOut,
            alignment: AlignmentDirectional.topStart,
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: items == null
                ? const SizedBox(width: double.infinity)
                : _Summary(items: items),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  final List<LogSummaryItem> items;

  const _Summary({required this.items});

  @override
  Widget build(BuildContext context) {
    final divider = context.theme.dividerColor.withValues(alpha: 0.7);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Column(
        children: [
          Divider(height: 1, indent: 8, endIndent: 8, color: divider),
          const SizedBox(height: 14),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  if (i > 0) VerticalDivider(width: 1, color: divider),
                  Expanded(child: _SummaryCell(item: items[i])),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  final LogSummaryItem item;

  const _SummaryCell({required this.item});

  @override
  Widget build(BuildContext context) {
    final value = item.value;
    final empty = value == null || value.isEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.labelLarge?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            empty ? '—' : value,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.text.bodySmall?.copyWith(
              fontSize: 12,
              color: empty
                  ? context.subtitle.withValues(alpha: 0.5)
                  : context.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
