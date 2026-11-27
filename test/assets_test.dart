import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/constants/app_assets.dart';

/// نگهبان asset (P6): فهرست `pubspec.yaml`، `AppAssets` و فایل‌های روی دیسک
/// باید با هم یکی باشن، و فایل طراحی دوباره وارد APK نشه.
///
/// اگر شکست خورد و پیام از `prepare_assets` گفت، یک‌بار این رو اجرا کن:
///   powershell -ExecutionPolicy Bypass -File tool\prepare_assets.ps1
const _imageBudgetEach = 200 * 1024;
const _imageBudgetTotal = 500 * 1024;

// آواتارها به‌صورت یک پوشه توی pubspec.yaml لیست می‌شن و این‌جا چک نمی‌شن
const _avatarPrefix = 'assets/avatars/';

String _pubspec() => File('pubspec.yaml').readAsStringSync();

/// مسیرهای زیر `flutter: assets:`.
List<String> _listedAssets() {
  final lines = _pubspec().split('\n');
  final start = lines.indexWhere((l) => l.trim() == 'assets:');
  if (start < 0) {
    throw StateError('بخش assets: توی pubspec.yaml نیست');
  }
  final out = <String>[];
  for (final line in lines.skip(start + 1)) {
    final match = RegExp(r'^\s+-\s+(\S+)\s*$').firstMatch(line);
    if (match == null) break;
    out.add(match.group(1)!);
  }
  return out;
}

/// مسیرهای زیر `fonts:`.
List<String> _listedFonts() =>
    RegExp(r'-\s*asset:\s*(\S+)')
        .allMatches(_pubspec())
        .map((m) => m.group(1)!)
        .toList();

void main() {
  test('هر asset به‌صورت فایل لیست شده، نه پوشه، و روی دیسک هست', () {
    final images = _listedAssets();
    expect(images, isNotEmpty);
    for (final path in [...images, ..._listedFonts()]) {
      if (path == _avatarPrefix) continue;
      expect(
        path.endsWith('/'),
        isFalse,
        reason: '$path پوشه‌ست؛ فایل‌ها رو یکی‌یکی بنویس',
      );
      expect(File(path).existsSync(), isTrue, reason: '$path روی دیسک نیست');
    }
  });

  test('همه‌ی ثابت‌های AppAssets توی pubspec.yaml لیست شدن', () {
    const constants = [
      AppAssets.logo,
      AppAssets.alionBadge,
      AppAssets.fontRegular,
      AppAssets.fontMedium,
      AppAssets.fontSemiBold,
      AppAssets.fontBold,
    ];
    final listed = [..._listedAssets(), ..._listedFonts()];
    for (final path in constants) {
      expect(listed, contains(path), reason: '$path توی pubspec.yaml نیست');
    }
  });

  test('هیچ مسیر assets/… خام بیرون از AppAssets نیست', () {
    final pattern = RegExp(r"""['"]assets/[^'"]+['"]""");
    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final normalized = entity.path.replaceAll('\\', '/');
      if (normalized.endsWith('core/constants/app_assets.dart')) continue;
      if (pattern.hasMatch(entity.readAsStringSync())) {
        offenders.add(normalized);
      }
    }
    expect(offenders, isEmpty, reason: 'به‌جاش از AppAssets استفاده کن');
  });

  test('داخل assets/images فایلی غیر از فهرست pubspec نیست', () {
    final dir = Directory('assets/images');
    if (!dir.existsSync()) return;
    final onDisk = dir
        .listSync(recursive: true)
        .whereType<File>()
        .map((f) => f.path.replaceAll('\\', '/'))
        .toSet();
    final extra = onDisk.difference(_listedAssets().toSet());
    expect(
      extra,
      isEmpty,
      reason:
          'این فایل‌ها وارد APK نمی‌شن ولی هنوز توی پوشه‌ی assets هستن؛ '
          'فایل طراحی باید توی design/ باشه (tool/prepare_assets.ps1)',
    );
  });

  test('حجم تصویرهای زمان اجرا زیر سقفه', () {
    var total = 0;
    for (final path in _listedAssets().where(
      (p) => !p.startsWith(_avatarPrefix),
    )) {
      final size = File(path).lengthSync();
      total += size;
      expect(
        size,
        lessThanOrEqualTo(_imageBudgetEach),
        reason:
            '$path ${size ~/ 1024}KB است؛ '
            'tool/prepare_assets.ps1 رو اجرا کن',
      );
    }
    expect(total, lessThanOrEqualTo(_imageBudgetTotal));
  });

  test('فایل‌های آیکون launcher روی دیسک هستن', () {
    final paths = RegExp(
      r'(?:image_path|adaptive_icon_foreground):\s*"([^"]+)"',
    ).allMatches(_pubspec()).map((m) => m.group(1)!);
    expect(paths, isNotEmpty);
    for (final path in paths) {
      expect(File(path).existsSync(), isTrue, reason: '$path نیست (design/)');
    }
  });
}
