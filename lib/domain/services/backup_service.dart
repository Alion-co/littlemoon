import 'dart:convert';

import '../../data/models/app_settings.dart';
import '../../data/models/daily_log.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/log_repository.dart';

class BackupData {
  final UserProfile profile;
  final AppSettings settings;
  final Map<String, DailyLog> logs;

  const BackupData({
    required this.profile,
    required this.settings,
    required this.logs,
  });
}

/// پشتیبان‌گیری آفلاین: کل داده‌ها به یک متن JSON تبدیل می‌شه که کاربر
/// می‌تونه خودش هر جا خواست نگه داره و بعداً برگردونه.
abstract final class BackupService {
  static const _app = 'little_moon';
  static const _version = 1;

  static String encode(BackupData data) {
    return const JsonEncoder.withIndent(' ').convert({
      'app': _app,
      'version': _version,
      'profile': data.profile.toJson(),
      'settings': data.settings.toJson(),
      'logs': LogRepository.encode(data.logs),
    });
  }

  /// اگه متن معتبر نباشه `null` برمی‌گردونه.
  static BackupData? decode(String raw) {
    try {
      final decoded = jsonDecode(raw.trim());
      if (decoded is! Map) return null;
      if (decoded['app'] != _app) return null;

      final profile = decoded['profile'];
      final settings = decoded['settings'];
      final logs = decoded['logs'];
      if (logs is! Map) return null;

      return BackupData(
        profile: profile is Map
            ? UserProfile.fromJson(Map<String, dynamic>.from(profile))
            : const UserProfile(onboardingDone: true),
        settings: settings is Map
            ? AppSettings.fromJson(Map<String, dynamic>.from(settings))
            : const AppSettings(),
        logs: LogRepository.decode(Map<String, dynamic>.from(logs)),
      );
    } catch (_) {
      return null;
    }
  }
}
