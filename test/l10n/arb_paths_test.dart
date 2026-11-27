import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// مسیر ثابت ترجمه‌ها (P3-4):
///   additions → `arb_additions/` در ریشه‌ی پروژه (نه داخل lib)
///   ARBها     → `l10n/` (`arb-dir` در l10n.yaml)
const _languages = ['en', 'fa', 'ar', 'tr', 'es'];

Map<String, dynamic> _json(String path) {
  final text = File(path).readAsStringSync();
  return jsonDecode(text.startsWith('\uFEFF') ? text.substring(1) : text)
      as Map<String, dynamic>;
}

Set<String> _keys(Map<String, dynamic> arb) =>
    arb.keys.where((k) => !k.startsWith('@')).toSet();

void main() {
  test('l10n.yaml به پوشه‌ی l10n اشاره می‌کنه', () {
    final yaml = File('l10n.yaml').readAsStringSync();
    final pattern = RegExp(r'^\s*arb-dir\s*:\s*l10n\s*$', multiLine: true);
    expect(pattern.hasMatch(yaml), isTrue);
  });

  test('پوشه‌ی additions قدیمی داخل lib وجود نداره', () {
    expect(Directory('lib/arb_additions').existsSync(), isFalse);
  });

  for (final lang in _languages) {
    test('ARB زبان $lang هست و همه‌ی additions توش merge شده', () {
      final arbFile = File('l10n/app_$lang.arb');
      expect(arbFile.existsSync(), isTrue);

      final additionsFile = File('arb_additions/app_${lang}_additions.json');
      if (!additionsFile.existsSync()) return;
      final arbKeys = _json(arbFile.path).keys.toSet();
      final missing = _json(additionsFile.path).keys
          .where((k) => !arbKeys.contains(k))
          .toList();
      expect(
        missing,
        isEmpty,
        reason: 'اجرا کن: dart tool/merge_arb.dart && flutter gen-l10n',
      );
    });
  }

  test('همه‌ی زبان‌ها دقیقاً همون کلیدهای انگلیسی رو دارن', () {
    final en = _keys(_json('l10n/app_en.arb'));
    for (final lang in _languages.where((l) => l != 'en')) {
      final keys = _keys(_json('l10n/app_$lang.arb'));
      expect(en.difference(keys), isEmpty, reason: '$lang: کم دارد');
      expect(keys.difference(en), isEmpty, reason: '$lang: اضافه دارد');
    }
  });
}
