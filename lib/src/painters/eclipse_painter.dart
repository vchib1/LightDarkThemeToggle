import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/painters/constants.dart';

class EclipsePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  const EclipsePainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) * mainRadiusFactor;

    final paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Draw the outer circle
    canvas.drawCircle(center, radius, paint);

    // Create paint for the eclipse (transparent)
    final eclipseCircle = Paint()
      ..isAntiAlias = true
      ..blendMode = BlendMode.clear;

    // Move the eclipse circle from the right to the center
    double translateX = size.width + (animation.value * -size.width);

    // Apply translation to the canvas
    canvas.translate(translateX, 0);

    // Draw the eclipse
    canvas.drawCircle(center, radius * 0.8, eclipseCircle);

    // Restore canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant EclipsePainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color;
  }
}
