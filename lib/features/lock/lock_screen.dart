import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_logo.dart';

import 'forgot_pin_panel.dart';
import 'pin_pad.dart';

export 'app_lock_gate.dart';
export 'pin_sheets.dart';

class LockScreen extends ConsumerStatefulWidget {
  final Future<void> Function() onResetApp;

  const LockScreen({super.key, required this.onResetApp});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String? _message;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // اگه اثر انگشت فعاله، همون اول پیشنهادش رو می‌دیم
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final blocked = ref.read(appLockProvider).blockedUntil;
      if (blocked != null && mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _tryBiometric() async {
    final lock = ref.read(appLockProvider);
    if (!mounted || !lock.locked || !lock.config.biometric) return;
    final l10n = AppLocalizations.of(context)!;
    await ref
        .read(appLockProvider.notifier)
        .unlockWithBiometric(l10n.unlockReason);
  }

  int _secondsBlocked(AppLockState lock) {
    final blocked = lock.blockedUntil;
    if (blocked == null) return 0;
    final left = blocked.difference(DateTime.now()).inSeconds + 1;
    return left > 0 ? left : 0;
  }

  bool _submit(String pin) {
    final l10n = AppLocalizations.of(context)!;
    final ok = ref.read(appLockProvider.notifier).unlockWithPin(pin);
    if (!ok) {
      final blocked = _secondsBlocked(ref.read(appLockProvider));
      setState(() {
        _message = blocked > 0 ? null : l10n.wrongPin;
      });
    }
    return ok;
  }

  /// صفحه‌ی قفل بالای Navigator هست و دیالوگ معمولی نمی‌تونه باز کنه؛
  /// برای همین تأیید پاک کردن همین‌جا داخل صفحه نشون داده می‌شه.
  bool _confirmingReset = false;
  bool _resetting = false;

  Future<void> _reset() async {
    setState(() => _resetting = true);
    await widget.onResetApp();
    if (mounted) setState(() => _resetting = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final lock = ref.watch(appLockProvider);
    final biometricReady =
        ref.watch(biometricAvailableProvider).valueOrNull ?? false;

    final blockedSeconds = _secondsBlocked(lock);

    final String? status = blockedSeconds > 0
        ? context.n(l10n.tooManyAttempts(blockedSeconds))
        : _message;

    final biometricKey = lock.config.biometric && biometricReady
        ? InkResponse(
            onTap: _tryBiometric,
            radius: 38,
            child: SizedBox(
              width: 72,
              height: 64,
              child: Icon(
                Icons.fingerprint_rounded,
                size: 32,
                color: context.scheme.primary,
              ),
            ),
          )
        : null;

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MoonLogo(size: 76, borderRadius: AppRadius.br22),
                  const SizedBox(height: 18),
                  Text(
                    l10n.enterPin,
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 22,
                    child: status == null
                        ? null
                        : Text(
                            status,
                            textAlign: TextAlign.center,
                            style: context.text.bodySmall?.copyWith(
                              color: context.scheme.error,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  PinPad(
                    enabled: blockedSeconds == 0,
                    onCompleted: _submit,
                    extraKey: biometricKey,
                  ),
                  const SizedBox(height: 12),
                  ForgotPinPanel(
                    confirming: _confirmingReset,
                    resetting: _resetting,
                    onAsk: () => setState(() => _confirmingReset = true),
                    onCancel: () => setState(() => _confirmingReset = false),
                    onReset: _reset,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
