import 'package:flutter/material.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import 'number_stepper.dart';

/// انتخاب یک عدد با دکمه‌های کم/زیاد. اگه لغو بشه `null` برمی‌گرده.
Future<int?> showStepperDialog({
  required BuildContext context,
  required String title,
  required int value,
  required int min,
  required int max,
  String? unit,
  String? description,
}) {
  return showDialog<int>(
    context: context,
    builder: (dialogContext) {
      var current = value;
      final l10n = AppLocalizations.of(dialogContext)!;
      final theme = Theme.of(dialogContext);

      return StatefulBuilder(
        builder: (builderContext, setState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (description != null) ...[
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.6),
                ),
                const SizedBox(height: 16),
              ],
              NumberStepper(
                value: current,
                min: min,
                max: max,
                unit: unit,
                onChanged: (next) => setState(() => current = next),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(current),
              child: Text(l10n.save),
            ),
          ],
        ),
      );
    },
  );
}

/// گرفتن یک متن کوتاه. اگه لغو بشه `null` برمی‌گرده.
Future<String?> showTextInputDialog({
  required BuildContext context,
  required String title,
  String initialValue = '',
  String? hint,
  String? suffix,
  int maxLength = 30,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
}) {
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => _TextInputDialog(
      title: title,
      initialValue: initialValue,
      hint: hint,
      suffix: suffix,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
    ),
  );
}

class _TextInputDialog extends StatefulWidget {
  final String title;
  final String initialValue;
  final String? hint;
  final String? suffix;
  final int maxLength;
  final int maxLines;
  final TextInputType keyboardType;

  const _TextInputDialog({
    required this.title,
    required this.initialValue,
    required this.hint,
    required this.suffix,
    required this.maxLength,
    required this.maxLines,
    required this.keyboardType,
  });

  @override
  State<_TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<_TextInputDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: widget.maxLength,
        minLines: widget.maxLines > 1 ? 4 : 1,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixText: widget.suffix,
          counterText: '',
        ),
        onSubmitted: widget.maxLines > 1
            ? null
            : (value) => Navigator.of(context).pop(value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(l10n.save),
        ),
      ],
    );
  }
}

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext)!;
      final theme = Theme.of(dialogContext);

      return AlertDialog(
        title: Text(title),
        content: Text(message, style: const TextStyle(height: 1.6)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: destructive
                ? FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: Colors.white,
                  )
                : null,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
  return result ?? false;
}

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
}
