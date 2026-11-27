import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// قانون لایه‌ها (P3-3):
///
///   features → domain / shared / data / core
///   shared   → core / domain          (نه features)
///   domain   → data / core            (نه features و shared)
///   data     → core                   (نه domain، features و shared)
///   domain/engine → فقط core و data/models و خودش؛ بدون Flutter و Riverpod
///
/// `core/router` تنها جایی‌ه که اجازه داره صفحه‌های features رو وصل کنه.
void main() {
  final libUri = Directory('lib').absolute.uri;
  final imports = <String, List<String>>{};

  setUpAll(() {
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final path = _libPath(libUri, entity.absolute.uri);
      if (path.startsWith('l10n/generated/')) continue;
      imports[path] = _importsOf(libUri, entity);
    }
  });

  List<String> violations(
    bool Function(String file) applies,
    bool Function(String target) forbidden,
  ) {
    return [
      for (final entry in imports.entries)
        if (applies(entry.key))
          for (final target in entry.value)
            if (forbidden(target)) '${entry.key} → $target',
    ];
  }

  test('فایل‌ها پیدا شدن', () {
    expect(imports.length, greaterThan(50));
  });

  test('data به domain / features / shared وابسته نیست', () {
    expect(
      violations(
        (f) => f.startsWith('data/'),
        (t) => _inAny(t, ['domain/', 'features/', 'shared/']),
      ),
      isEmpty,
    );
  });

  test('domain به features و shared وابسته نیست', () {
    expect(
      violations(
        (f) => f.startsWith('domain/'),
        (t) => _inAny(t, ['features/', 'shared/']),
      ),
      isEmpty,
    );
  });

  test('shared به features وابسته نیست', () {
    expect(
      violations(
        (f) => f.startsWith('shared/'),
        (t) => t.startsWith('features/'),
      ),
      isEmpty,
    );
  });

  test('core به features وابسته نیست (به‌جز router)', () {
    expect(
      violations(
        (f) => f.startsWith('core/') && !f.startsWith('core/router/'),
        (t) => t.startsWith('features/'),
      ),
      isEmpty,
    );
  });

  test('domain/engine بدون Flutter و Riverpod و ذخیره‌سازی', () {
    expect(
      violations(
        (f) => f.startsWith('domain/engine/'),
        (t) =>
            t.startsWith('package:flutter') ||
            t.startsWith('package:go_router') ||
            t == 'dart:ui' ||
            t == 'dart:io' ||
            _inAny(t, [
              'features/',
              'shared/',
              'domain/services/',
              'data/repositories/',
              'data/database/',
            ]),
      ),
      isEmpty,
    );
  });

  test('data/models بدون Flutter و Riverpod', () {
    expect(
      violations(
        (f) => f.startsWith('data/models/'),
        (t) => t.startsWith('package:flutter') || t == 'dart:ui',
      ),
      isEmpty,
    );
  });
}

bool _inAny(String target, List<String> prefixes) =>
    prefixes.any(target.startsWith);

/// مسیر فایل نسبت به `lib/` با `/` (مثلاً `domain/engine/cycle_engine.dart`).
String _libPath(Uri libUri, Uri fileUri) {
  final base = libUri.path;
  final path = fileUri.path;
  return path.startsWith(base) ? path.substring(base.length) : path;
}

final _importPattern = RegExp(
  r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

/// هدف هر import: مسیر نسبت به `lib/` برای فایل‌های خود برنامه، یا همون
/// `package:...` / `dart:...` برای بقیه.
List<String> _importsOf(Uri libUri, File file) {
  final result = <String>[];
  for (final match in _importPattern.allMatches(file.readAsStringSync())) {
    final spec = match.group(1)!;
    if (spec.startsWith('package:little_moon/')) {
      result.add(spec.substring('package:little_moon/'.length));
    } else if (spec.startsWith('package:') || spec.startsWith('dart:')) {
      result.add(spec);
    } else {
      result.add(_libPath(libUri, file.absolute.uri.resolve(spec)));
    }
  }
  return result;
}
