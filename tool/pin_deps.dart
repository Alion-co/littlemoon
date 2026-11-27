// ignore_for_file: avoid_print
// قفل کردن وابستگی‌های `any` روی نسخه‌ای که همین الان نصب شده.
//
//   dart tool/pin_deps.dart           ← فقط گزارش می‌ده (هیچ فایلی عوض نمی‌شه)
//   dart tool/pin_deps.dart --apply   ← pubspec.yaml رو عوض می‌کنه
//                                       (نسخه‌ی قبلی: pubspec.yaml.bak)
//
// از pubspec.lock می‌خونه، پس اول یک‌بار `flutter pub get` بزن و مطمئن شو
// برنامه با همین نسخه‌ها بیلد می‌شه.
import 'dart:io';

/// `intl` عمداً `any` می‌مونه: flutter_localizations خودش نسخه‌ی مناسب
/// intl رو مشخص می‌کنه و قفل کردنش بعد از آپدیت فلاتر خطای pub get می‌ده.
const _keepAny = {'intl'};

void main(List<String> args) {
  final apply = args.contains('--apply');
  final lockFile = File('pubspec.lock');
  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync() || !lockFile.existsSync()) {
    stderr.writeln(
      'pubspec.yaml یا pubspec.lock پیدا نشد. از ریشه‌ی پروژه '
      'اجرا کن و قبلش flutter pub get بزن.',
    );
    exitCode = 1;
    return;
  }

  final locked = _lockedVersions(lockFile.readAsLinesSync());
  final original = pubspecFile.readAsStringSync();
  final eol = original.contains('\r\n') ? '\r\n' : '\n';
  final anyLine = RegExp(r'^(\s+)([a-z0-9_]+):\s*any\s*(#.*)?$');

  final out = <String>[];
  var changed = 0;
  for (final line in original.split(RegExp(r'\r?\n'))) {
    final match = anyLine.firstMatch(line);
    if (match == null) {
      out.add(line);
      continue;
    }
    final name = match.group(2)!;
    if (_keepAny.contains(name)) {
      print('$name: any ← می‌مونه (عمداً)');
      out.add(line);
      continue;
    }
    final version = locked[name];
    if (version == null) {
      print(
        '$name: در pubspec.lock نیست ← flutter pub get بزن و دوباره اجرا کن',
      );
      out.add(line);
      continue;
    }
    final comment = match.group(3);
    out.add(
      '${match.group(1)}$name: ^$version'
      '${comment == null ? '' : ' $comment'}',
    );
    print('$name: any → ^$version');
    changed++;
  }

  if (!apply) {
    print('\nفقط گزارش بود. برای اعمال: dart tool/pin_deps.dart --apply');
    return;
  }
  if (changed == 0) {
    print('\nچیزی برای تغییر نبود.');
    return;
  }

  File('pubspec.yaml.bak').writeAsStringSync(original);
  pubspecFile.writeAsStringSync(out.join(eol));
  print('\n$changed وابستگی قفل شد. بعدش: flutter pub get');
}

/// نسخه‌ی هر بسته از روی pubspec.lock.
Map<String, String> _lockedVersions(List<String> lines) {
  final versions = <String, String>{};
  String? current;
  for (final line in lines) {
    final package = RegExp(r'^  ([a-z0-9_]+):\s*$').firstMatch(line);
    if (package != null) {
      current = package.group(1);
      continue;
    }
    final version = RegExp(r'^    version:\s*"?([^"\s]+)"?\s*$')
        .firstMatch(line);
    if (version != null && current != null) {
      versions[current] = version.group(1)!;
      current = null;
    }
  }
  return versions;
}
