import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class ExpandPainter extends CustomPainter {
  final Animation<double> animation;

  const ExpandPainter({required this.animation}) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final radius = size.width / 2;

    final mainCircleRadius = lerpDouble(radius * .70, radius, progress)!;

    const int count = 8;
    double angleStep = getRadian(360) / count;
    if (animation.value < 1.0) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(lerpDouble(1, 0, progress)!);

      for (int i = 0; i < count; i++) {
        final angle = angleStep * i;
        final x = radius * math.cos(angle);
        final y = radius * math.sin(angle);
        canvas.drawCircle(Offset(x, y), radius * .15, paint);
      }
      canvas.restore();
    }

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    canvas.drawCircle(center, mainCircleRadius, paint);

    // Create paint for the eclipse (transparent)
    final eclipsePaint = Paint()..blendMode = BlendMode.clear;

    // Move the eclipse circle from the right to the center
    double translateX = size.width + (animation.value * -size.width * .75);
    double translateY = size.height + (animation.value * -size.height * .75);

    // Apply translation to the canvas
    canvas.translate(translateX, -translateY);

    // Draw the eclipse
    canvas.drawCircle(center, radius * 0.8, eclipsePaint);

    // Restore canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
