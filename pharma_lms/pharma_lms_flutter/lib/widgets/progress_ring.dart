import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Circular progress ring (0-100%) for course completion - Odoo-inspired.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 48,
    this.strokeWidth = 4,
    this.backgroundColor,
    this.progressColor,
    this.showLabel = false,
  });

  /// Progress 0.0 to 1.0 (or 0-100 if > 1, treated as percentage)
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color? progressColor;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final p = progress > 1 ? progress / 100 : progress;
    final clamped = p.clamp(0.0, 1.0);
    final bg = backgroundColor ?? AppColors.slate200;
    final fg = progressColor ?? AppColors.teal600;

    return SizedBox(
      width: size,
      height: size,
      child: Semantics(
        label: 'Progress: ${(clamped * 100).round()}%',
        child: CustomPaint(
          painter: _ProgressRingPainter(
            progress: clamped,
            strokeWidth: strokeWidth,
            backgroundColor: bg,
            progressColor: fg,
          ),
          child: showLabel
            ? Center(
                child: Text(
                  '${(clamped * 100).round()}%',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate700,
                      ),
                ),
              )
            : null,
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final sweepAngle = 2 * 3.14159265359 * progress;
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -3.14159265359 / 2,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
