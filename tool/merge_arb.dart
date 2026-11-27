// ignore_for_file: avoid_print
// اضافه کردن رشته‌های جدید به فایل‌های ARB (فقط کلیدهایی که هنوز نیستن).
//
// مسیرهای ثابت (P3-4):
//   additions : arb_additions/app_<lang>_additions.json   (ریشه‌ی پروژه)
//   ARBها     : مقدار `arb-dir` در l10n.yaml  (l10n/)
//
// اجرا از ریشه‌ی پروژه:   dart tool/merge_arb.dart
// بعدش:                    flutter gen-l10n
//
// کد خروجی ۱ یعنی چیزی درست نیست (فایل گم‌شده یا additions جای اشتباه).
import 'dart:convert';
import 'dart:io';

const _languages = ['en', 'fa', 'ar', 'tr', 'es'];
const _additionsDir = 'arb_additions';
// جای قدیمی؛ مشکل مسیری که قبلاً پیش اومد از همین بود
const _strayDir = 'lib/arb_additions';

void main() {
  var failed = false;

  if (Directory(_strayDir).existsSync()) {
    print('خطا: پوشه‌ی "$_strayDir" نباید وجود داشته باشه.');
    print(
      '      فایل‌های additions رو به "$_additionsDir/" (ریشه‌ی پروژه) ببر',
    );
    print('      و این پوشه رو پاک کن.');
    exit(1);
  }

  final arbDir = _arbDirFromYaml();
  print('additions: $_additionsDir');
  print('arb      : $arbDir');
  const encoder = JsonEncoder.withIndent('  ');

  for (final lang in _languages) {
    final additionsFile = File('$_additionsDir/app_${lang}_additions.json');
    final arbFile = File('$arbDir/app_$lang.arb');
    if (!arbFile.existsSync()) {
      print('[$lang] خطا: ${arbFile.path} پیدا نشد');
      failed = true;
      continue;
    }
    if (!additionsFile.existsSync()) {
      print('[$lang] additions نداره (${additionsFile.path}) — رد شد');
      continue;
    }

    final arb = jsonDecode(_read(arbFile)) as Map<String, dynamic>;
    final additions = jsonDecode(_read(additionsFile)) as Map<String, dynamic>;

    var added = 0;
    additions.forEach((key, value) {
      if (!arb.containsKey(key)) {
        arb[key] = value;
        added++;
      }
    });

    if (added > 0) arbFile.writeAsStringSync('${encoder.convert(arb)}\n');
    print('[$lang] $added کلید اضافه شد');
  }

  if (failed) exit(1);
}

String _arbDirFromYaml() {
  final yaml = File('l10n.yaml');
  if (!yaml.existsSync()) return 'l10n';
  for (final line in yaml.readAsLinesSync()) {
    final match = RegExp(r'^\s*arb-dir\s*:\s*(.+?)\s*$').firstMatch(line);
    if (match != null) {
      return match.group(1)!.replaceAll('"', '').replaceAll("'", '');
    }
  }
  return 'l10n';
}

String _read(File file) {
  final text = file.readAsStringSync();
  return text.startsWith('\uFEFF') ? text.substring(1) : text;
}
