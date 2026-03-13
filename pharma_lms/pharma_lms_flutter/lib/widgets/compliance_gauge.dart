import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design_system/colors.dart';

/// Circular gauge showing compliance percentage (0–100).
class ComplianceGauge extends StatelessWidget {
  const ComplianceGauge({
    super.key,
    required this.percentage,
    this.size = 120,
    this.strokeWidth = 8,
    this.label,
    this.showValue = true,
  });

  final double percentage;
  final double size;
  final double strokeWidth;
  final String? label;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final clamped = percentage.clamp(0.0, 100.0);
    final color = _colorForPercentage(clamped);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Semantics(
            label: 'Compliance: ${clamped.round()}%',
            child: CustomPaint(
              size: Size(size, size),
              painter: _GaugePainter(
                percentage: clamped / 100,
                strokeWidth: strokeWidth,
                color: color,
              ),
            ),
          ),
          if (showValue || label != null)
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showValue)
                  Text(
                    '${clamped.round()}%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: size * 0.2,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (label != null) ...[
                  if (showValue) SizedBox(height: size * 0.04),
                  Text(
                    label!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: DesignColors.neutral600,
                          fontSize: size * 0.12,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Color _colorForPercentage(double pct) {
    if (pct >= 90) return DesignColors.success;
    if (pct >= 70) return DesignColors.warning;
    return DesignColors.danger;
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.percentage,
    required this.strokeWidth,
    required this.color,
  });

  final double percentage;
  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background arc
    final bgPaint = Paint()
      ..color = DesignColors.neutral200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi,
      false,
      bgPaint,
    );

    // Value arc
    final valuePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percentage,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.percentage != percentage ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth;
}
