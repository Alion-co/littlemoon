import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_strings.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem(this.icon, this.label, this.value);
}

/// درباره‌ی برنامه و سازنده. اطلاعات از [AppInfo] خونده می‌شه.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    // فقط موردهایی که پر شدن نشون داده می‌شن
    final items = <_InfoItem>[
      _InfoItem(
        Icons.mail_outline_rounded,
        l10n.email,
        AppInfo.developerEmail,
      ),
      _InfoItem(
        Icons.language_rounded,
        l10n.website,
        AppInfo.developerWebsite,
      ),
      _InfoItem(
        Icons.send_outlined,
        l10n.telegram,
        AppInfo.developerTelegram,
      ),
      _InfoItem(
        Icons.photo_camera_outlined,
        l10n.instagram,
        AppInfo.developerInstagram,
      ),
    ].where((item) => item.value.trim().isNotEmpty).toList();

    Future<void> copy(String value) async {
      await Clipboard.setData(ClipboardData(text: value));
      if (context.mounted) showAppSnackBar(context, l10n.copied);
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            PageHeader(
              title: l10n.aboutDeveloper,
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/profile');
                }
              },
            ),
            const SizedBox(height: 24),

            // ---------- لوگو و اسم برنامه ----------
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.asset(
                  'assets/images/logo/littlemoon_icon_full.png',
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                  // اگه فایل لوگو نبود، یک نشان ساده جاش می‌شینه
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 104,
                    height: 104,
                    color: moon?.heroStart ?? theme.colorScheme.surface,
                    child: Icon(
                      Icons.nightlight_round,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                AppInfo.appName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                context.n(l10n.appVersion(AppInfo.version)),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: subtitleColor,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ---------- توضیحات برنامه ----------
            MoonCard(
              padding: const EdgeInsets.all(18),
              child: Text(
                l10n.aboutAppBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  height: 1.7,
                ),
              ),
            ),

            // ---------- تقدیم ----------
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: l10n.dedication),
                  // ماه درست بعد از آخرین کلمه می‌شینه، حتی اگه متن بشکنه
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: Icon(
                        Icons.nightlight_round,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                height: 1.6,
              ),
            ),

            // ---------- سازنده ----------
            if (items.isNotEmpty) ...[
              const SizedBox(height: 28),
              MoonCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          color: theme.dividerColor.withValues(alpha: 0.6),
                        ),
                      InkWell(
                        onTap: () => copy(items[i].value),
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            children: [
                              Icon(
                                items[i].icon,
                                size: 20,
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.85),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                items[i].label,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: subtitleColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  items[i].value,
                                  textAlign: TextAlign.end,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],

            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_rounded,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  l10n.madeWithLove,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
