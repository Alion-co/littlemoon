import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';

/// تعداد آواتارهای آماده. شناسه‌ی ۰ یعنی «بدون آواتار» (آیکون ساده).
const int avatarCount = 5;

enum _HairStyle { long, buns, bob, scarf, ponytail }

class _AvatarSpec {
  final _HairStyle style;
  final Color background;
  final Color skin;
  final Color hair;
  final Color clothes;
  final Color accent;

  const _AvatarSpec({
    required this.style,
    required this.background,
    required this.skin,
    required this.hair,
    required this.clothes,
    required this.accent,
  });
}

const List<_AvatarSpec> _specs = [
  // ۱) موی بلند با پاپیون
  _AvatarSpec(
    style: _HairStyle.long,
    background: Color(0xFFFBD9E5),
    skin: Color(0xFFF9D9C6),
    hair: Color(0xFF4A2F2A),
    clothes: Color(0xFFD84D88),
    accent: Color(0xFFE5668A),
  ),
  // ۲) موی دوگوشی
  _AvatarSpec(
    style: _HairStyle.buns,
    background: Color(0xFFE4DAFA),
    skin: Color(0xFFF3CDB4),
    hair: Color(0xFF231C2B),
    clothes: Color(0xFF8B5CF6),
    accent: Color(0xFFF2A7C3),
  ),
  // ۳) موی کوتاه با گل
  _AvatarSpec(
    style: _HairStyle.bob,
    background: Color(0xFFFFE3D3),
    skin: Color(0xFFFBE0CF),
    hair: Color(0xFF9A5234),
    clothes: Color(0xFFEC6A3A),
    accent: Color(0xFFFFFFFF),
  ),
  // ۴) روسری
  _AvatarSpec(
    style: _HairStyle.scarf,
    background: Color(0xFFD9F1E6),
    skin: Color(0xFFF1C8A8),
    hair: Color(0xFFE58FB4),
    clothes: Color(0xFFD9749E),
    accent: Color(0xFFC95E8D),
  ),
  // ۵) دم‌اسبی
  _AvatarSpec(
    style: _HairStyle.ponytail,
    background: Color(0xFFD8ECF8),
    skin: Color(0xFFE8B893),
    hair: Color(0xFF6B4530),
    clothes: Color(0xFF0F9BA8),
    accent: Color(0xFFF2C94C),
  ),
];

/// آواتار کاربر. اگه [avatarId] صفر یا نامعتبر باشه، آیکون ساده نشون می‌ده.
class UserAvatar extends StatelessWidget {
  final int avatarId;
  final double radius;

  const UserAvatar({super.key, required this.avatarId, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final size = radius * 2;

    if (avatarId < 1 || avatarId > _specs.length) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: moon?.avatarBackground,
        child: Icon(
          Icons.person_rounded,
          color: moon?.avatarIcon,
          size: radius * 1.1,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: CustomPaint(painter: _AvatarPainter(_specs[avatarId - 1])),
      ),
    );
  }
}

const double _pi = 3.141592653589793;

class _AvatarPainter extends CustomPainter {
  final _AvatarSpec spec;

  _AvatarPainter(this.spec);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    Offset at(double x, double y) => Offset(x * s, y * s);

    final hairPaint = Paint()..color = spec.hair;
    final skinPaint = Paint()..color = spec.skin;
    final accentPaint = Paint()..color = spec.accent;

    // پس‌زمینه
    canvas.drawRect(Offset.zero & size, Paint()..color = spec.background);

    final isScarf = spec.style == _HairStyle.scarf;
    final faceCenter = at(0.5, 0.50);
    final faceRadius = (isScarf ? 0.205 : 0.225) * s;

    // ---------- موی پشت / روسری ----------
    switch (spec.style) {
      case _HairStyle.long:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(0.19 * s, 0.20 * s, 0.81 * s, 1.05 * s),
            Radius.circular(0.30 * s),
          ),
          hairPaint,
        );
      case _HairStyle.buns:
        canvas.drawCircle(at(0.26, 0.25), 0.115 * s, hairPaint);
        canvas.drawCircle(at(0.74, 0.25), 0.115 * s, hairPaint);
        canvas.drawCircle(at(0.5, 0.46), 0.275 * s, hairPaint);
      case _HairStyle.bob:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(0.18 * s, 0.19 * s, 0.82 * s, 0.74 * s),
            Radius.circular(0.27 * s),
          ),
          hairPaint,
        );
      case _HairStyle.scarf:
        canvas.drawOval(
          Rect.fromCenter(
            center: at(0.5, 0.82),
            width: 0.78 * s,
            height: 0.60 * s,
          ),
          hairPaint,
        );
        canvas.drawCircle(at(0.5, 0.47), 0.31 * s, hairPaint);
      case _HairStyle.ponytail:
        canvas.save();
        canvas.translate(0.80 * s, 0.52 * s);
        canvas.rotate(-0.25);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: 0.20 * s,
            height: 0.46 * s,
          ),
          hairPaint,
        );
        canvas.restore();
        canvas.drawCircle(at(0.5, 0.46), 0.275 * s, hairPaint);
    }

    // ---------- شانه و گردن ----------
    if (!isScarf) {
      canvas.drawRect(
        Rect.fromLTRB(0.44 * s, 0.66 * s, 0.56 * s, 0.82 * s),
        skinPaint,
      );
    }
    canvas.drawOval(
      Rect.fromCenter(
        center: at(0.5, 1.04),
        width: 0.74 * s,
        height: 0.50 * s,
      ),
      Paint()..color = spec.clothes,
    );

    // ---------- صورت ----------
    canvas.drawCircle(faceCenter, faceRadius, skinPaint);

    // ---------- چتری / لبه‌ی روسری ----------
    if (isScarf) {
      // نوار زیر روسری بالای پیشونی
      final band = Path()
        ..addArc(
          Rect.fromCircle(center: at(0.5, 0.455), radius: 0.215 * s),
          _pi,
          _pi,
        )
        ..close();
      canvas.drawPath(band, accentPaint);
    } else {
      final fringe = Path()
        ..addArc(
          Rect.fromCircle(center: at(0.5, 0.435), radius: 0.245 * s),
          _pi,
          _pi,
        )
        ..close();
      canvas.drawPath(fringe, hairPaint);
    }

    // ---------- اجزای صورت ----------
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.022 * s
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF4A2F2A);

    // چشم‌های بسته‌ی خندان
    for (final dx in [-0.085, 0.085]) {
      canvas.drawArc(
        Rect.fromCenter(
          center: at(0.5 + dx, 0.535),
          width: 0.075 * s,
          height: 0.055 * s,
        ),
        _pi,
        _pi,
        false,
        linePaint,
      );
    }

    // گونه‌ها
    final blushPaint = Paint()
      ..color = const Color(0xFFF28FA8).withValues(alpha: 0.55);
    canvas.drawCircle(at(0.375, 0.59), 0.036 * s, blushPaint);
    canvas.drawCircle(at(0.625, 0.59), 0.036 * s, blushPaint);

    // لبخند
    canvas.drawArc(
      Rect.fromCenter(
        center: at(0.5, 0.60),
        width: 0.10 * s,
        height: 0.07 * s,
      ),
      0,
      _pi,
      false,
      linePaint,
    );

    // ---------- تزئین ----------
    switch (spec.style) {
      case _HairStyle.long:
        // پاپیون
        final center = at(0.68, 0.25);
        final bow = Path()
          ..moveTo(center.dx, center.dy)
          ..lineTo(center.dx - 0.10 * s, center.dy - 0.065 * s)
          ..lineTo(center.dx - 0.10 * s, center.dy + 0.065 * s)
          ..close()
          ..moveTo(center.dx, center.dy)
          ..lineTo(center.dx + 0.10 * s, center.dy - 0.065 * s)
          ..lineTo(center.dx + 0.10 * s, center.dy + 0.065 * s)
          ..close();
        canvas.drawPath(bow, accentPaint);
        canvas.drawCircle(center, 0.03 * s, accentPaint);
      case _HairStyle.buns:
        // گل‌سر کوچک
        canvas.drawCircle(at(0.33, 0.33), 0.03 * s, accentPaint);
        canvas.drawCircle(at(0.67, 0.33), 0.03 * s, accentPaint);
      case _HairStyle.bob:
        // گل کنار مو
        final center = at(0.70, 0.30);
        for (var i = 0; i < 5; i++) {
          canvas.drawCircle(
            center + Offset.fromDirection(i * 2 * _pi / 5, 0.045 * s),
            0.034 * s,
            accentPaint,
          );
        }
        canvas.drawCircle(
          center,
          0.028 * s,
          Paint()..color = const Color(0xFFF2C94C),
        );
      case _HairStyle.scarf:
        break;
      case _HairStyle.ponytail:
        // کش مو
        canvas.drawCircle(at(0.745, 0.335), 0.04 * s, accentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter oldDelegate) =>
      oldDelegate.spec != spec;
}
