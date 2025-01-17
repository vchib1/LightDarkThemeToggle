import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/painters/constants.dart';

class SimplePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  const SimplePainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2 * mainRadiusFactor;
    final eclipseRadius = radius * 0.8;

    final paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Draw the outer circle
    canvas.drawCircle(center, radius, paint);

    // Create paint for the eclipse (transparent)
    final eclipsePaint = Paint()
      ..isAntiAlias = true
      ..blendMode = BlendMode.clear;

    // Move the eclipse circle from the right to the center
    double translateX = size.width + (progress * -size.width * .80);

    // Apply translation to the canvas
    canvas.translate(translateX, -size.height / 4);

    // Draw the eclipse
    canvas.drawCircle(center, eclipseRadius, eclipsePaint);

    // Restore canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SimplePainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color;
  }
}
