import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';
import 'cycle_ring.dart';

class CycleHeroCard extends StatelessWidget {
  final int currentDay;
  final String phaseKey;
  final int daysUntilPeriod;
  final double cycleProgress;

  /// اگه داده بشه به‌جای «X روز تا پریود بعدی» نمایش داده می‌شه
  /// (مثلاً وقتی پریود عقب افتاده یا امروز شروع می‌شه).
  final String? statusText;

  /// جمله‌ی پایین کارت درباره‌ی وضعیت چرخه.
  final String? note;
  final VoidCallback? onInfoTap;

  const CycleHeroCard({
    super.key,
    required this.currentDay,
    required this.phaseKey,
    required this.daysUntilPeriod,
    this.cycleProgress = 0.5,
    this.statusText,
    this.note,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final phaseText = switch (phaseKey) {
      'follicularPhase' => l10n.follicularPhase,
      'lutealPhase' => l10n.lutealPhase,
      'menstrualPhase' => l10n.menstrualPhase,
      'ovulationPhase' => l10n.ovulationPhase,
      _ => phaseKey,
    };
    final status =
        statusText ?? context.n(l10n.daysUntilPeriod(daysUntilPeriod));

    if (isNightTheme(context)) {
      return _buildNight(context, l10n, phaseText, status);
    }
    return _buildDay(context, l10n, phaseText, status);
  }

  // ---------- تم روشن ----------
  Widget _buildDay(
    BuildContext context,
    AppLocalizations l10n,
    String phaseText,
    String status,
  ) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>()!;
    final noteText = note;

    // حلقه روی گوشی‌های باریک کوچک‌تر می‌شه تا جای متن تنگ نشه
    final screenWidth = MediaQuery.sizeOf(context).width;
    final ringWidth = screenWidth * 0.36 < 142.0 ? screenWidth * 0.36 : 142.0;
    final ringHeight = ringWidth * 124 / 142;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 14, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            moon.heroStart,
            moon.heroEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        context.n(l10n.dayOfCycle(currentDay)),
                        maxLines: 1,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.ofYourCycle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: moon.phaseBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        phaseText,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: moon.phaseText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: onInfoTap,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              status,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.info_outline_rounded,
                            size: 15,
                            color: moon.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: ringWidth,
                height: ringHeight,
                child: CustomPaint(
                  painter: OrbitRingPainter(
                    progress: cycleProgress,
                    primaryColor: theme.colorScheme.primary,
                    secondaryColor: theme.colorScheme.secondary,
                    backgroundColor: moon.ringBackground,
                  ),
                  child: Center(
                    child: Text(
                      context.n(currentDay),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (noteText != null) ...[
            const SizedBox(height: 14),
            Divider(
              height: 1,
              indent: 24,
              endIndent: 24,
              color: theme.colorScheme.primary.withValues(alpha: 0.14),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timeline_rounded,
                  size: 18,
                  color: theme.colorScheme.secondary.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    noteText,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ---------- تم شب ----------
  Widget _buildNight(
    BuildContext context,
    AppLocalizations l10n,
    String phaseText,
    String status,
  ) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>()!;
    final noteText = note;
    final soft = Colors.white.withValues(alpha: 0.78);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: homeCardDecoration(context, radius: 28),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 224, maxHeight: 224),
            child: AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              painter: NightRingPainter(
                progress: cycleProgress,
                startColor: theme.colorScheme.secondary,
                endColor: theme.colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.n(l10n.dayOfCycle(currentDay)),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.ofYourCycle,
                      style: theme.textTheme.bodyMedium?.copyWith(color: soft),
                    ),
                    const SizedBox(height: 8),
                    Icon(Icons.auto_awesome, size: 14, color: soft),
                    const SizedBox(height: 8),
                    Text(
                      phaseText,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: onInfoTap,
                      behavior: HitTestBehavior.opaque,
                      child: Text(
                        status,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: soft,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          ),
          if (noteText != null) ...[
            const SizedBox(height: 10),
            Text(
              noteText,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: moon.subtitle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// کارت بالای صفحه وقتی هنوز هیچ پریودی ثبت نشده.
class CycleEmptyCard extends StatelessWidget {
  final VoidCallback onLogPeriod;

  const CycleEmptyCard({super.key, required this.onLogPeriod});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>()!;
    final l10n = AppLocalizations.of(context)!;
    final night = isNightTheme(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: night
          ? homeCardDecoration(context, radius: 28)
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [moon.heroStart, moon.heroEnd],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.noCycleDataTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              color: night ? Colors.white : theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.noCycleDataBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: moon.subtitle,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onLogPeriod,
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.logLastPeriod),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
