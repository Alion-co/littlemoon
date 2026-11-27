import 'package:flutter/painting.dart';
import 'package:little_moon/data/models/daily_log.dart';

/// رنگ نشانگر هر حال (دایره‌ی پاستلی و نقطه‌ی گوشه‌اش).
Color moodColor(Mood mood) => switch (mood) {
  Mood.happy => const Color(0xFFFF9F43),
  Mood.calm => const Color(0xFF4CAF7D),
  Mood.sensitive => const Color(0xFF5B8DEF),
  Mood.sad => const Color(0xFF8E7CF0),
  Mood.irritable => const Color(0xFFEF5B6B),
  Mood.anxious => const Color(0xFFD870B8),
};
