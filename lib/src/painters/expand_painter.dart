import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class ExpandPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  const ExpandPainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = color..isAntiAlias = true
      ..style = PaintingStyle.fill;

    final radius = size.width / 2;

    final mainCircleRadius = lerpDouble(radius * .60, radius * .90, progress)!;

    const int count = 8;
    double angleStep = getRadian(360) / count;
    if (progress < 1.0) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(lerpDouble(1, 0, progress)!);

      final circleRadius = radius * .90;

      for (int i = 0; i < count; i++) {
        final angle = angleStep * i;
        final x = circleRadius * math.cos(angle);
        final y = circleRadius * math.sin(angle);
        canvas.drawCircle(Offset(x, y), circleRadius * .175, paint);
      }
      canvas.restore();
    }

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    canvas.drawCircle(center, mainCircleRadius, paint);

    // Create paint for the eclipse (transparent)
    final eclipsePaint = Paint()..isAntiAlias = true..blendMode = BlendMode.clear;

    // Move the eclipse circle from the right to the center
    double translateX = size.width + (progress * -size.width * .75);
    double translateY = size.height + (progress * -size.height * .75);

    // Apply translation to the canvas
    canvas.translate(translateX, -translateY);

    // Draw the eclipse
    canvas.drawCircle(center, radius * 0.8, eclipsePaint);

    // Restore canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ExpandPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value || color != oldDelegate.color;
  }
}
