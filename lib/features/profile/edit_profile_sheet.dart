import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

/// ویرایش پروفایل: انتخاب آواتار و تغییر اسم.
Future<void> showEditProfileSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => const _EditProfileSheet(),
  );
}

class _EditProfileSheet extends ConsumerStatefulWidget {
  const _EditProfileSheet();

  @override
  ConsumerState<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<_EditProfileSheet> {
  final _nameController = TextEditingController();
  int _avatar = 0;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameController.text = profile.name;
    _avatar = profile.avatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final profile = ref.read(profileProvider);
    await ref.read(profileProvider.notifier).save(
          profile.copyWith(
            name: _nameController.text.trim(),
            avatar: _avatar,
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final primary = theme.colorScheme.primary;

    Widget sectionLabel(String text) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      );
    }

    return Padding(
      // فرم بالای کیبورد می‌مونه
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.editProfile,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),

            // ---------- پیش‌نمایش آواتار انتخابی ----------
            UserAvatar(avatarId: _avatar, radius: 44),
            const SizedBox(height: 20),

            // ---------- انتخاب آواتار ----------
            sectionLabel(l10n.chooseAvatar),
            const SizedBox(height: 12),
            Row(
              children: [
                // شناسه‌ی ۰ = بدون آواتار
                for (var id = 0; id <= avatarCount; id++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _avatar = id),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _avatar == id
                                  ? primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              // اندازه با عرض صفحه تنظیم می‌شه
                              final available = constraints.maxWidth;
                              final radius =
                                  available.isFinite && available < 48
                                      ? available / 2
                                      : 24.0;
                              return UserAvatar(avatarId: id, radius: radius);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 22),

            // ---------- اسم ----------
            sectionLabel(l10n.yourName),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              maxLength: 30,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              decoration: InputDecoration(
                hintText: l10n.nameHint,
                counterText: '',
                filled: true,
                fillColor: theme.scaffoldBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  l10n.save,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
