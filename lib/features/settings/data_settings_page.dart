import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:little_moon/domain/services/backup_files.dart';
import 'package:little_moon/domain/services/backup_service.dart';
import 'package:little_moon/domain/services/data_registry.dart';
import 'package:little_moon/domain/services/data_reset.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';

import 'settings_widgets.dart';

/// داده‌ها و پشتیبان: فایل، متن و حذف همه‌چیز.
class DataSettingsPage extends ConsumerWidget {
  const DataSettingsPage({super.key});

  String _currentBackup(WidgetRef ref) =>
      BackupService.encode(ref.read(dataSlicesProvider));

  /// پشتیبان به‌صورت فایل `.json` که کاربر هر جا خواست ذخیره‌اش می‌کنه.
  Future<void> _saveFile(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final json = _currentBackup(ref);
    // پنجره‌ی انتخاب محل ذخیره برنامه رو موقتاً به پس‌زمینه می‌بره
    ref.read(appLockProvider.notifier).ignoreNextBackground();
    final saved = await BackupFiles.save(
      json,
      fileName: BackupService.fileName(DateTime.now()),
      dialogTitle: l10n.saveBackupFile,
    );
    if (!context.mounted) return;
    switch (saved) {
      case BackupFileResult.saved:
        showAppSnackBar(context, l10n.backupFileSaved);
      case BackupFileResult.cancelled:
        break;
      case BackupFileResult.failed:
        // اگه ذخیره‌ی فایل روی این دستگاه ممکن نبود، متن کپی می‌شه
        await Clipboard.setData(ClipboardData(text: json));
        if (context.mounted) showAppSnackBar(context, l10n.backupFileFailed);
    }
  }

  Future<void> _openFile(BuildContext context, WidgetRef ref) async {
    ref.read(appLockProvider.notifier).ignoreNextBackground();
    final raw = await BackupFiles.pick();
    if (raw == null || !context.mounted) return;
    await _restore(context, ref, raw);
  }

  /// پشتیبان به‌صورت متن در کلیپ‌بورد (برای انتقال دستی).
  Future<void> _copyText(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final json = _currentBackup(ref);
    await Clipboard.setData(ClipboardData(text: json));
    if (context.mounted) showAppSnackBar(context, l10n.backupCopied);
  }

  Future<void> _pasteText(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final raw = await showTextInputDialog(
      context: context,
      title: l10n.restoreBackup,
      hint: l10n.restoreHint,
      maxLength: 2000000,
      maxLines: 8,
      keyboardType: TextInputType.multiline,
    );
    if (raw == null || raw.trim().isEmpty || !context.mounted) return;
    await _restore(context, ref, raw);
  }

  /// متن پشتیبان رو بررسی می‌کنه، تأیید می‌گیره و جایگزین داده‌ها می‌کنه.
  Future<void> _restore(BuildContext context, WidgetRef ref, String raw) async {
    final l10n = AppLocalizations.of(context)!;
    final slices = ref.read(dataSlicesProvider);
    final sections = BackupService.decode(raw, slices);
    if (sections == null) {
      showAppSnackBar(context, l10n.restoreInvalid);
      return;
    }

    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.restoreBackup,
      message: l10n.restoreConfirm,
      confirmLabel: l10n.restore,
    );
    if (!confirmed) return;

    await BackupService.restore(slices, sections);
    if (context.mounted) showAppSnackBar(context, l10n.restoreDone);
  }

  Future<void> _deleteAll(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.deleteAllData,
      message: l10n.deleteAllConfirm,
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!confirmed) return;

    await resetAllAppData(ref);
    if (context.mounted) context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsScaffold(
      title: l10n.dataAndBackup,
      children: [
        const SizedBox(height: 4),
        _LocalOnlyBanner(text: l10n.dataLocalNote),
        SettingsCaption(l10n.backupFileCaption),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: Icons.save_alt_rounded,
              title: l10n.saveBackupFile,
              showChevron: true,
              onTap: () => _saveFile(context, ref),
            ),
            SettingsTile(
              icon: Icons.upload_file_rounded,
              title: l10n.restoreBackupFile,
              showChevron: true,
              onTap: () => _openFile(context, ref),
            ),
          ],
        ),
        SettingsFootnote(l10n.backupHint),

        SettingsCaption(l10n.backupTextCaption),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: Icons.content_copy_rounded,
              title: l10n.copyBackup,
              onTap: () => _copyText(context, ref),
            ),
            SettingsTile(
              icon: Icons.content_paste_rounded,
              title: l10n.restoreBackup,
              onTap: () => _pasteText(context, ref),
            ),
          ],
        ),

        const SizedBox(height: 24),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: Icons.delete_outline_rounded,
              title: l10n.deleteAllData,
              destructive: true,
              onTap: () => _deleteAll(context, ref),
            ),
          ],
        ),
      ],
    );
  }
}

/// یادآوری اینکه داده‌ها فقط روی همین گوشی هستن.
class _LocalOnlyBanner extends StatelessWidget {
  final String text;

  const _LocalOnlyBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.08),
        borderRadius: AppRadius.br18,
      ),
      child: Row(
        children: [
          Icon(Icons.phone_android_rounded, size: 22, color: primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: context.text.bodySmall?.copyWith(
                color: context.scheme.onSurface,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
