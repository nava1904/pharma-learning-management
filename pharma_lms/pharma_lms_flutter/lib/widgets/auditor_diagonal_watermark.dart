import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Paints faint diagonal repeating "AUDIT COPY" text across the entire area (plan 6C).
class AuditorDiagonalWatermarkPainter extends CustomPainter {
  AuditorDiagonalWatermarkPainter({
    this.text = 'AUDIT COPY',
    this.angle = -0.35,
    this.spacing = 180,
    this.fontSize = 14,
    Color? color,
  }) : _textColor = color ?? Colors.grey.withValues(alpha: 0.12);

  final String text;
  final double angle;
  final double spacing;
  final double fontSize;
  final Color _textColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: 'Roboto',
        fontSize: fontSize,
        fontWeight: ui.FontWeight.w600,
      ),
    )..pushStyle(ui.TextStyle(color: _textColor));
    paragraphBuilder.addText(text);
    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: size.width * 2));

    const double dx = 180;
    const double dy = 110;

    canvas.save();
    canvas.rotate(angle);
    final extent = size.width + size.height + 200;
    for (double y = -extent; y < extent; y += dy) {
      for (double x = -extent; x < extent; x += dx) {
        canvas.drawParagraph(paragraph, Offset(x, y));
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant AuditorDiagonalWatermarkPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.angle != angle ||
        oldDelegate.spacing != spacing ||
        oldDelegate.fontSize != fontSize ||
        oldDelegate._textColor != _textColor;
  }
}
