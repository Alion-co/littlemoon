import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/home_widget_sync.dart';
import 'package:little_moon/features/home/widgets/cycle_hero_day.dart';
import 'package:little_moon/features/home/widgets/cycle_ring.dart';
import 'package:little_moon/features/home/widgets/moon_art.dart';
import 'package:little_moon/features/home/widgets/phase_layout.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/glass.dart';

import 'settings_widgets.dart';

part 'widget_gallery_data.dart';
part 'widget_gallery_preview.dart';

/// گالری ویجت در «ظاهر و زبان»: پیش‌نمایش زنده‌ی ویجت ۲×۲ (هم‌شکل کارت
/// هیرو، با رنگ تم فعلی) و دکمه‌ی افزودن به صفحه‌ی اصلی.
class WidgetGallery extends ConsumerStatefulWidget {
  const WidgetGallery({super.key});

  @override
  ConsumerState<WidgetGallery> createState() => _WidgetGalleryState();
}

class _WidgetGalleryState extends ConsumerState<WidgetGallery> {
  bool _adding = false;

  Future<void> _add() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _adding = true);
    final ok = await HomeWidgetSync.pin();
    if (!mounted) return;
    setState(() => _adding = false);
    // فقط اگه خطا داد پیام می‌دیم
    if (!ok) showAppSnackBar(context, l10n.widgetPinFailed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final data = _buildWidgetData(context, ref);
    final canPin = ref.watch(canPinWidgetProvider).valueOrNull ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.56,
            child: AspectRatio(
              aspectRatio: 1,
              child: _SquarePreview(data: data),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (canPin)
          FilledButton.icon(
            onPressed: _adding ? null : _add,
            icon: const Icon(Icons.add_to_home_screen_rounded, size: 20),
            label: Text(l10n.addWidgetToHome(l10n.widgetSizeSquare)),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(46),
              shape: const StadiumBorder(),
            ),
          )
        else
          SettingsFootnote(l10n.widgetHint),
      ],
    );
  }
}
