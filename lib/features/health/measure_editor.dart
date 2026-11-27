import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';

/// ویرایش وزن و دمای بدن با دیالوگ ورودی (اعتبارسنجی + ذخیره).
abstract final class MeasureEditor {
  /// عدد اعشاری رو از ورودی کاربر می‌خونه (رقم فارسی و ممیز هم قبوله).
  static double? parseNumber(String raw) {
    final normalized = toLatinDigits(raw).replaceAll(',', '.').trim();
    if (normalized.isEmpty) return null;
    return double.tryParse(normalized);
  }

  static Future<void> editWeight(
    BuildContext context,
    WidgetRef ref,
    DailyLog log,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final current = log.weightKg;
    final input = await showTextInputDialog(
      context: context,
      title: l10n.weight,
      initialValue: current == null ? '' : Labels.decimal(current),
      hint: l10n.weightHint,
      suffix: l10n.kg,
      maxLength: 6,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    if (input == null) return;

    final value = parseNumber(input);
    if (input.trim().isNotEmpty &&
        (value == null || value < 20 || value > 300)) {
      if (context.mounted) showAppSnackBar(context, l10n.invalidValue);
      return;
    }
    await ref.read(logsProvider.notifier).save(log.withWeight(value));
  }

  static Future<void> editTemperature(
    BuildContext context,
    WidgetRef ref,
    DailyLog log,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final current = log.temperatureC;
    final input = await showTextInputDialog(
      context: context,
      title: l10n.bodyTemperature,
      initialValue: current == null ? '' : Labels.decimal(current),
      hint: l10n.temperatureHint,
      suffix: '°C',
      maxLength: 5,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    if (input == null) return;

    final value = parseNumber(input);
    if (input.trim().isNotEmpty &&
        (value == null || value < 34 || value > 42)) {
      if (context.mounted) showAppSnackBar(context, l10n.invalidValue);
      return;
    }
    await ref.read(logsProvider.notifier).save(log.withTemperature(value));
  }
}
