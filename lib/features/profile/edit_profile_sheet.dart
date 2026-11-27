import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/avatar_carousel.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

/// ویرایش پروفایل: انتخاب آواتار و تغییر اسم.
Future<void> showEditProfileSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
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
    await ref
        .read(profileProvider.notifier)
        .save(
          profile.copyWith(name: _nameController.text.trim(), avatar: _avatar),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final primary = context.scheme.primary;

    Widget sectionLabel(String text) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          text,
          style: context.text.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.scheme.onSurface,
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
                borderRadius: AppRadius.br4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.editProfile,
              style: context.text.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.scheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),

            // ---------- پیش‌نمایش آواتار انتخابی ----------
            UserAvatar(avatarId: _avatar, radius: 44),
            const SizedBox(height: 20),

            // ---------- انتخاب آواتار ----------
            sectionLabel(l10n.chooseAvatar),
            const SizedBox(height: 12),
            // قطاری و اسکرولی؛ شناسه‌ی ۰ = بدون آواتار
            AvatarCarousel(
              selected: _avatar,
              onChanged: (id) => setState(() => _avatar = id),
              radius: 28,
              selectedColor: primary,
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
                  borderRadius: AppRadius.br18,
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
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.br18),
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
