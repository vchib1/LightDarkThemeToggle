import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/painters/constants.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class DarkSidePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  const DarkSidePainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * mainRadiusFactor;

    // Outer circle paint
    final outerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Arc paint (transparent)
    final clearPaint = Paint()..blendMode = BlendMode.clear;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Draw the outer circle
    canvas.drawCircle(center, radius, outerPaint);

    // Create the arc rect
    final arcRect = Rect.fromCenter(
      center: center,
      width: radius * 1.5,
      height: radius * 1.5,
    );

    // Rotate canvas based on animation
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animation.value * math.pi);
    canvas.translate(-center.dx, -center.dy);

    // Draw the transparent arc
    canvas.drawArc(arcRect, -getRadian(90), getRadian(180), true, clearPaint);

    // Restore canvas to apply transparency effect
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant DarkSidePainter oldDelegate) {
    return animation.value != oldDelegate.animation.value || color != oldDelegate.color;
  }
}
