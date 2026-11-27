import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/shared/widgets/floating_navbar.dart';
import 'package:little_moon/shared/widgets/page_header.dart';

/// قاب مشترک صفحه‌های تنظیمات: هدر با دکمه‌ی برگشت + لیست قابل اسکرول.
class SettingsScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;

  /// اگه نشه برگشت (مثلاً با لینک مستقیم باز شده)، به این مسیر می‌ره.
  final String fallbackRoute;

  /// چیزی که همیشه پایین صفحه می‌مونه (مثل امضای سازنده).
  final Widget? footer;

  /// شماره‌ی تب نوار پایین؛ فقط صفحه‌ی اصلی تنظیمات پرش می‌کنه.
  /// null یعنی نوار پایین نمایش داده نمی‌شه (زیرصفحه‌ها).
  final int? navIndex;

  const SettingsScaffold({
    super.key,
    required this.title,
    required this.children,
    this.fallbackRoute = '/settings',
    this.footer,
    this.navIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // صفحه‌ی اصلی تنظیمات با نوار پایین (context.go) باز می‌شه و چیزی زیرش
    // توی استک نیست؛ بدون این، دکمه‌ی برگشت اندروید از برنامه خارج می‌شد.
    final isTab = navIndex != null && !context.canPop();
    return PopScope(
      canPop: !isTab,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go(fallbackRoute);
      },
      child: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _list(context)),
            if (footer != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  navIndex == null ? 16 : 8,
                ),
                child: footer,
              ),
            if (navIndex != null) FloatingNavbar(currentIndex: navIndex!),
          ],
        ),
      ),
    ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        PageHeader(
          title: title,
          onBack: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(fallbackRoute);
            }
          },
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

/// عنوان کوچک بالای هر گروه.
class SettingsCaption extends StatelessWidget {
  final String text;

  const SettingsCaption(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(6, 18, 6, 8),
      child: Text(
        text,
        style: context.text.labelMedium?.copyWith(
          color: context.subtitle,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// توضیح کوچک زیر یک گروه.
class SettingsFootnote extends StatelessWidget {
  final String text;
  final IconData? icon;

  const SettingsFootnote(this.text, {super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    final color = context.subtitle;
    final iconData = icon;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(6, 8, 6, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconData != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(iconData, size: 14, color: color),
            ),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Text(
              text,
              style: context.text.bodySmall?.copyWith(
                color: color,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// یک گروه از ردیف‌ها داخل یک کارت، با جداکننده‌ی ظریف بینشون.
class SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const SettingsGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        rows.add(
          Divider(
            height: 1,
            indent: 60,
            color: theme.dividerColor.withValues(alpha: 0.5),
          ),
        );
      }
      rows.add(children[i]);
    }

    return Container(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br20,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: Column(children: rows),
      ),
    );
  }
}

/// یک ردیف تنظیمات: آیکون در مربع رنگی، عنوان، توضیح اختیاری و
/// یک بخش انتهایی (فلش، مقدار یا سوییچ).
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool destructive;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    this.showChevron = false,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final muted = context.subtitle;
    final accent = destructive ? context.scheme.error : context.scheme.primary;
    final subtitleText = subtitle;
    final valueText = value;
    final trailingWidget = trailing;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: AppRadius.br10,
              ),
              child: Icon(icon, size: 19, color: accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.text.bodyMedium?.copyWith(
                      color: destructive
                          ? context.scheme.error
                          : context.scheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitleText != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitleText,
                      style: context.text.bodySmall?.copyWith(
                        color: muted,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (valueText != null) ...[
              const SizedBox(width: 8),
              Text(
                valueText,
                style: context.text.bodySmall?.copyWith(
                  color: context.scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (trailingWidget != null) ...[
              const SizedBox(width: 8),
              trailingWidget,
            ],
            if (showChevron) ...[
              const SizedBox(width: 4),
              // این آیکون خودش در راست‌به‌چپ قرینه می‌شه
              Icon(Icons.chevron_right_rounded, size: 20, color: muted),
            ],
          ],
        ),
      ),
    );
  }
}

/// ردیف با سوییچ؛ لمس کل ردیف هم سوییچ رو عوض می‌کنه.
class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: () {
        Haptics.tap();
        onChanged(!value);
      },
      trailing: Transform.scale(
        scale: 0.85,
        child: Switch(
          value: value,
          onChanged: (v) {
            Haptics.tap();
            onChanged(v);
          },
        ),
      ),
    );
  }
}
