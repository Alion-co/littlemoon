import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:little_moon/features/lock/lock_screen.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';

import 'settings_widgets.dart';

/// حریم خصوصی: قفل برنامه، اثر انگشت، تغییر رمز و نوتیفیکیشن مخفی.
class PrivacySettingsPage extends ConsumerWidget {
  const PrivacySettingsPage({super.key});

  Future<void> _toggleLock(
    BuildContext context,
    WidgetRef ref,
    bool enable,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final lock = ref.read(appLockProvider.notifier);
    if (enable) {
      final pin = await showPinSetupSheet(context);
      if (pin == null) return;
      await lock.setPin(pin);
      if (context.mounted) showAppSnackBar(context, l10n.appLockOn);
    } else {
      if (!await confirmCurrentPin(context, ref)) return;
      await lock.disable();
    }
  }

  Future<void> _changePin(BuildContext context, WidgetRef ref) async {
    if (!await confirmCurrentPin(context, ref)) return;
    if (!context.mounted) return;
    final pin = await showPinSetupSheet(context);
    if (pin == null) return;
    await ref.read(appLockProvider.notifier).setPin(pin);
    if (context.mounted) {
      showAppSnackBar(context, AppLocalizations.of(context)!.pinChanged);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final lock = ref.watch(appLockProvider);
    final biometricReady =
        ref.watch(biometricAvailableProvider).valueOrNull ?? false;

    return SettingsScaffold(
      title: l10n.privacySection,
      children: [
        SettingsCaption(l10n.appLock),
        SettingsGroup(
          children: [
            SettingsSwitchTile(
              icon: Icons.lock_outline_rounded,
              title: l10n.appLock,
              subtitle: l10n.appLockHint,
              value: lock.enabled,
              onChanged: (v) => _toggleLock(context, ref, v),
            ),
            if (lock.enabled && biometricReady)
              SettingsSwitchTile(
                icon: Icons.fingerprint_rounded,
                title: l10n.useBiometric,
                value: lock.config.biometric,
                onChanged: (v) =>
                    ref.read(appLockProvider.notifier).setBiometric(v),
              ),
            if (lock.enabled)
              SettingsTile(
                icon: Icons.password_rounded,
                title: l10n.changePin,
                showChevron: true,
                onTap: () => _changePin(context, ref),
              ),
          ],
        ),

        SettingsCaption(l10n.notificationsCaption),
        SettingsGroup(
          children: [
            SettingsSwitchTile(
              icon: Icons.visibility_off_outlined,
              title: l10n.discreetNotifications,
              subtitle: l10n.discreetNotificationsHint,
              value: settings.discreetNotifications,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .save(settings.copyWith(discreetNotifications: v)),
            ),
          ],
        ),
      ],
    );
  }
}
