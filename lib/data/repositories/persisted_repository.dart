import 'dart:async';

import '../database/local_store.dart';

/// پایه‌ی همه‌ی repositoryهایی که یک تکه از داده‌ی برنامه رو ذخیره می‌کنن.
///
/// - `encode`/`decode` فرمت ذخیره روی دستگاه رو مشخص می‌کنن.
/// - `schemaVersion` نسخه‌ی ساختار داده‌ست؛ وقتی بالا بره، `migrate` داده‌ی
///   قدیمی رو قبل از `decode` به شکل جدید درمی‌آره. داده‌ی بدون برچسب نسخه
///   (قبل از این کلاس) نسخه‌ی ۱ حساب می‌شه، پس چیزی از دست نمی‌ره.
/// - `backupKey`/`toBackup`/`fromBackup` فرمت همین داده در فایل پشتیبان رو
///   مشخص می‌کنن (به‌طور پیش‌فرض همون فرمت ذخیره).
abstract class PersistedRepository<T> {
  PersistedRepository(this.store);

  final LocalStore store;

  /// کلید ذخیره در حافظه‌ی دستگاه (مثل `daily_logs_v1`).
  String get storageKey;

  /// کلید این داده در فایل پشتیبان (مثل `logs`).
  String get backupKey;

  /// نسخه‌ی فعلی ساختار داده.
  int get schemaVersion => 1;

  /// مقدار پیش‌فرض وقتی چیزی ذخیره نشده یا ذخیره‌شده خراب است.
  T get emptyValue;

  /// تبدیل مقدار به JSON برای ذخیره.
  Map<String, dynamic> encode(T value);

  /// ساخت مقدار از JSON ذخیره‌شده؛ برای ورودی خراب باید [emptyValue] بده.
  T decode(Object? raw);

  /// تبدیل داده‌ی نسخه‌ی [fromVersion] به ساختار فعلی.
  Map<String, dynamic> migrate(int fromVersion, Map<String, dynamic> json) =>
      json;

  Object? toBackup(T value) => encode(value);

  T fromBackup(Object? raw) => decode(raw);

  /// فاصله‌ی نوشتن روی دیسک بعد از آخرین `save`. صفر = همون لحظه.
  ///
  /// داده‌ای که زیاد و پشت‌سرهم عوض می‌شه (مثل ثبت‌های روزانه) چند ثانیه
  /// صبر می‌کنه تا چند تغییر پشت‌هم فقط یک‌بار نوشته بشن. state توی حافظه
  /// همیشه به‌روزه؛ فقط نوشتن روی دیسک عقب می‌افته، و با [flush] یا
  /// [flushAll] (رفتن برنامه به پس‌زمینه) فوراً انجام می‌شه.
  Duration get saveDelay => Duration.zero;

  String get _versionKey => '$storageKey.schema';

  bool _versionStamped = false;

  T? _pending;
  bool _hasPending = false;
  Timer? _timer;

  /// repositoryهایی که چیزی برای نوشتن دارن.
  static final Set<PersistedRepository<dynamic>> _dirty = {};

  /// همه‌ی نوشتن‌های عقب‌افتاده رو همین حالا انجام می‌ده.
  static Future<void> flushAll() async {
    for (final repository in List.of(_dirty)) {
      await repository.flush();
    }
  }

  T load() {
    var json = store.getJson(storageKey);
    if (json == null) return emptyValue;
    final stored = int.tryParse(store.getString(_versionKey) ?? '') ?? 1;
    if (stored < schemaVersion) json = migrate(stored, json);
    return decode(json);
  }

  /// مقدار رو ذخیره می‌کنه (اگه [saveDelay] صفر نباشه، با تأخیر و تجمیع).
  Future<void> save(T value) {
    if (saveDelay == Duration.zero) return _write(value);

    _pending = value;
    _hasPending = true;
    _dirty.add(this);
    _timer?.cancel();
    _timer = Timer(saveDelay, () => unawaited(flush()));
    return Future<void>.value();
  }

  /// آخرین مقدار منتظر نوشتن رو (اگه هست) همین حالا روی دیسک می‌نویسه.
  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    if (!_hasPending) return;
    final value = _pending as T;
    _pending = null;
    _hasPending = false;
    _dirty.remove(this);
    await _write(value);
  }

  Future<void> _write(T value) async {
    await store.setJson(storageKey, encode(value));
    if (!_versionStamped) {
      await store.setString(_versionKey, '$schemaVersion');
      _versionStamped = true;
    }
  }
}
