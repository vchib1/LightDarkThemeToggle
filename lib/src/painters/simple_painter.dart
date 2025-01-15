import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/painters/constants.dart';

class SimplePainter extends CustomPainter {
  final Animation<double> animation;

  const SimplePainter({required this.animation}) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2 * mainRadiusFactor;
    final eclipseRadius = radius * 0.8;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Draw the outer circle
    canvas.drawCircle(center, radius, paint);

    // Create paint for the eclipse (transparent)
    final eclipsePaint = Paint()..blendMode = BlendMode.clear;

    // Move the eclipse circle from the right to the center
    double translateX = size.width + (progress * -size.width * .70);

    // Apply translation to the canvas
    canvas.translate(translateX, -center.dy / 3);

    // Draw the eclipse
    canvas.drawCircle(center, eclipseRadius, eclipsePaint);

    // Restore canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SimplePainter oldDelegate) {
    return false;
  }
}
