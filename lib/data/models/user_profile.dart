import '../../core/utils/math_utils.dart';

class UserProfile {
  final String name;

  /// طول معمول چرخه به روز — تا وقتی داده‌ی کافی ثبت نشده مبنای پیش‌بینیه.
  final int cycleLength;

  /// طول معمول پریود به روز.
  final int periodLength;

  /// طول فاز لوتئال (فاصله‌ی تخمک‌گذاری تا پریود بعدی). معمولاً ۱۴ روز.
  final int lutealLength;
  final int? birthYear;

  /// شناسه‌ی آواتار انتخابی (۰ = بدون آواتار).
  final int avatar;
  final bool onboardingDone;

  const UserProfile({
    this.name = '',
    this.cycleLength = 28,
    this.periodLength = 5,
    this.lutealLength = 14,
    this.birthYear,
    this.avatar = 0,
    this.onboardingDone = false,
  });

  static const minCycleLength = 15;
  static const maxCycleLength = 60;
  static const minPeriodLength = 1;
  static const maxPeriodLength = 10;
  static const minLutealLength = 9;
  static const maxLutealLength = 18;

  UserProfile copyWith({
    String? name,
    int? cycleLength,
    int? periodLength,
    int? lutealLength,
    int? avatar,
    bool? onboardingDone,
  }) {
    return UserProfile(
      name: name ?? this.name,
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      lutealLength: lutealLength ?? this.lutealLength,
      birthYear: birthYear,
      avatar: avatar ?? this.avatar,
      onboardingDone: onboardingDone ?? this.onboardingDone,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'cycleLength': cycleLength,
        'periodLength': periodLength,
        'lutealLength': lutealLength,
        if (birthYear != null) 'birthYear': birthYear,
        'avatar': avatar,
        'onboardingDone': onboardingDone,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    int readInt(String key, int fallback, int min, int max) {
      final value = json[key];
      if (value is num) return clampInt(value.toInt(), min, max);
      return fallback;
    }

    final name = json['name'];
    final birthYear = json['birthYear'];
    return UserProfile(
      name: name is String ? name : '',
      cycleLength:
          readInt('cycleLength', 28, minCycleLength, maxCycleLength),
      periodLength:
          readInt('periodLength', 5, minPeriodLength, maxPeriodLength),
      lutealLength:
          readInt('lutealLength', 14, minLutealLength, maxLutealLength),
      birthYear: birthYear is num ? birthYear.toInt() : null,
      avatar: readInt('avatar', 0, 0, 99),
      onboardingDone: json['onboardingDone'] == true,
    );
  }
}
