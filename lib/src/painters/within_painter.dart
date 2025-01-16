import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/painters/constants.dart';

class WithinPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  const WithinPainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) * mainRadiusFactor;
    final innerRadius = radius * .70;

    final paint = Paint()
      ..color = Colors.blue
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    final scaleRadius = lerpDouble(radius, radius * .75, progress)!;
    final scaleInnerRadius = lerpDouble(innerRadius, 0, progress)!;

    // Draw the outer circle
    canvas.drawCircle(center, scaleRadius, paint);

    // Create paint for the eclipse (transparent)
    final innerCirclePaint = Paint()
      ..isAntiAlias = true
      ..blendMode = BlendMode.clear;

    // Apply translation to the canvas
    canvas.translate(-center.dx, -center.dy);

    canvas.drawCircle(center * 2, scaleInnerRadius, innerCirclePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WithinPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color;
  }
}
