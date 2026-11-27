import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import 'pin_pad.dart';

/// گرفتن رمز تازه: دو بار وارد می‌شه و باید یکی باشن.
/// اگه کاربر منصرف بشه `null` برمی‌گرده.
Future<String?> showPinSetupSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    builder: (_) => const _PinSetupSheet(),
  );
}

class _PinSetupSheet extends StatefulWidget {
  const _PinSetupSheet();

  @override
  State<_PinSetupSheet> createState() => _PinSetupSheetState();
}

class _PinSetupSheetState extends State<_PinSetupSheet> {
  String? _first;
  bool _mismatch = false;

  bool _onPin(String pin) {
    final first = _first;
    if (first == null) {
      setState(() {
        _first = pin;
        _mismatch = false;
      });
      return true;
    }
    if (first == pin) {
      Navigator.of(context).pop(pin);
      return true;
    }
    setState(() {
      _first = null;
      _mismatch = true;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: AppRadius.br4,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _first == null ? l10n.newPin : l10n.confirmPin,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 22,
            child: _mismatch
                ? Text(
                    l10n.pinMismatch,
                    style: context.text.bodySmall?.copyWith(
                      color: context.scheme.error,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          // کلید تازه تا بعد از مرحله‌ی اول نقطه‌ها خالی بشن
          PinPad(key: ValueKey(_first == null), onCompleted: _onPin),
        ],
      ),
    );
  }
}

/// گرفتن رمز فعلی برای کارهای حساس (خاموش کردن یا عوض کردن قفل).
Future<bool> confirmCurrentPin(BuildContext context, WidgetRef ref) async {
  final ok = await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      final l10n = AppLocalizations.of(sheetContext)!;
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.enterPin,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            PinPad(
              onCompleted: (pin) {
                final valid = ref.read(appLockProvider.notifier).verify(pin);
                if (valid) Navigator.of(sheetContext).pop(true);
                return valid;
              },
            ),
          ],
        ),
      );
    },
  );
  return ok ?? false;
}
