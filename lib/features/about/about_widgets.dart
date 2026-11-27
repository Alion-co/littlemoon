part of 'about_page.dart';

/// دکمه‌ی کوچک و کم‌رنگ امتیاز در فروشگاه.
class _PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PillButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.8)),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_border_rounded,
                size: 15,
                color: context.scheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: context.text.labelMedium?.copyWith(
                  color: context.scheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// دکمه‌ی گرد تماس با سازنده (طلایی برند).
class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _alionGold.withValues(alpha: 0.45),
                    width: 1,
                  ),
                ),
                child: Icon(icon, size: 19, color: _alionGold),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: context.text.labelSmall?.copyWith(
                  color: context.scheme.onSurface.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// دو کمان بزرگ و کم‌رنگ: یکی بالا سمت چپ، یکی پایین سمت راست.
class _ArcsPainter extends CustomPainter {
  final Color color;

  const _ArcsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas
      ..drawCircle(
        Offset(-size.width * 0.15, size.height * 0.05),
        size.width * 0.42,
        paint,
      )
      ..drawCircle(
        Offset(size.width * 1.05, size.height * 1.02),
        size.width * 0.5,
        paint,
      );
  }

  @override
  bool shouldRepaint(_ArcsPainter old) => old.color != color;
}
