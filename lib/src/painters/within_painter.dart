import 'dart:ui';

import 'package:flutter/material.dart';

class WithinPainter extends CustomPainter {
  final Animation<double> animation;

  const WithinPainter({required this.animation}) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) * .90;
    final innerRadius = radius * .70;
    final eclipseRadius = radius * .50;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    final scaleRadius = lerpDouble(radius, radius * .75, progress)!;
    final scaleInnerRadius = lerpDouble(innerRadius, 0, progress)!;

    // Draw the outer circle
    canvas.drawCircle(center, scaleRadius, paint);

    // Create paint for the eclipse (transparent)
    final innerCirclePaint = Paint()..blendMode = BlendMode.clear;

    // Apply translation to the canvas
    canvas.translate(-center.dx, -center.dy);

    canvas.drawCircle(center * 2, scaleInnerRadius, innerCirclePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
