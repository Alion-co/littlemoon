import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_info.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/designed_by.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/moon_logo.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:url_launcher/url_launcher.dart';

part 'about_widgets.dart';

/// رنگ طلایی برند ALION (همون رنگ شیر لوگو).
const _alionGold = Color(0xFFB08A4E);

/// «درباره‌ی ماه کوچولو»: مینیمال، هم‌سبک برنامه‌ی کهربا.
///
/// بالا: آیکون، اسم و معرفی کوتاه برنامه + امتیاز در فروشگاه‌ها.
/// پایین: نشان ALION و راه‌های تماس با سازنده.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  /// لینک رو در برنامه‌ی مناسب باز می‌کنه؛ اگه نشد، متنش کپی می‌شه.
  static Future<void> _open(
    BuildContext context,
    Uri uri, {
    required String fallbackText,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    var opened = false;
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }
    if (opened || !context.mounted) return;
    await Clipboard.setData(ClipboardData(text: fallbackText));
    if (context.mounted) showAppSnackBar(context, l10n.copied);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final muted = context.subtitle;
    final primary = context.scheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // دو کمان ظریف تزئینی در گوشه‌های صفحه
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _ArcsPainter(primary.withValues(alpha: 0.16)),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    child: Column(
                      children: [
                        PageHeader(
                          title: l10n.aboutDeveloper,
                          onBack: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/settings');
                            }
                          },
                        ),
                        const SizedBox(height: 28),

                        // ---------- برنامه ----------
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: AppRadius.br26,
                            boxShadow: [
                              BoxShadow(
                                color: primary.withValues(alpha: 0.18),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const MoonLogo(
                            size: 96,
                            borderRadius: AppRadius.br26,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          l10n.appTitle,
                          style: context.text.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.aboutTagline,
                          textAlign: TextAlign.center,
                          style: context.text.bodyLarge?.copyWith(color: muted),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.n(
                            '${l10n.appVersion(AppInfo.version)} · '
                            '${l10n.aboutMeta}',
                          ),
                          textAlign: TextAlign.center,
                          style: context.text.bodySmall?.copyWith(color: muted),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _PillButton(
                              label: l10n.rateOnMyket,
                              onTap: () => _open(
                                context,
                                Uri.parse(AppInfo.myketUrl),
                                fallbackText: AppInfo.myketUrl,
                              ),
                            ),
                            const SizedBox(width: 10),
                            _PillButton(
                              label: l10n.rateOnBazaar,
                              onTap: () => _open(
                                context,
                                Uri.parse(AppInfo.bazaarUrl),
                                fallbackText: AppInfo.bazaarUrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ---------- تقدیم ----------
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: l10n.dedication),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 6,
                                  ),
                                  child: Icon(
                                    Icons.nightlight_round,
                                    size: 15,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: context.text.bodySmall?.copyWith(
                            color: primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // فضای خالی تا بخش سازنده پایین صفحه بشینه
                        const Spacer(),
                        const SizedBox(height: 36),

                        // ---------- سازنده ----------
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: _alionGold.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const AlionBadge(size: 64),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          AppInfo.developerName,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 4,
                            color: _alionGold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.developerRole,
                          style: context.text.bodySmall?.copyWith(color: muted),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ContactButton(
                              icon: Icons.call_outlined,
                              label: l10n.contactCall,
                              onTap: () => _open(
                                context,
                                Uri(
                                  scheme: 'tel',
                                  path: AppInfo.developerPhone,
                                ),
                                fallbackText: AppInfo.developerPhone,
                              ),
                            ),
                            const SizedBox(width: 22),
                            _ContactButton(
                              icon: Icons.photo_camera_outlined,
                              label: l10n.instagram,
                              onTap: () => _open(
                                context,
                                Uri.parse(
                                  'https://instagram.com/'
                                  '${AppInfo.developerInstagram}',
                                ),
                                fallbackText: AppInfo.developerInstagram,
                              ),
                            ),
                            const SizedBox(width: 22),
                            _ContactButton(
                              icon: Icons.mail_outline_rounded,
                              label: l10n.email,
                              onTap: () => _open(
                                context,
                                Uri(
                                  scheme: 'mailto',
                                  path: AppInfo.developerEmail,
                                ),
                                fallbackText: AppInfo.developerEmail,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),

                        // ---------- امضا ----------
                        const DesignedBy(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
