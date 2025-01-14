import 'dart:math' as math;
import 'package:flutter/material.dart';

class ClassicPainter extends CustomPainter {
  final Animation<double> animation;

  const ClassicPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final minDimension = math.min(size.width, size.height);
    final radius = minDimension * 0.45; // Base circle radius

    // Ray dimensions relative to size
    final baseStrokeWidth = minDimension * 0.075; // Ray thickness
    final rayGap = minDimension * 0.05; // Gap between circle and rays
    final rayStartRadius = radius + rayGap; // Rays start after the gap
    final rayLength = minDimension * 0.20;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final rayPaint = Paint()
      ..color = Color.lerp(
          Colors.blue, Colors.blue.withOpacity(0.8), animation.value)!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = baseStrokeWidth
      ..isAntiAlias = true;

    const int numRays = 8;
    const double angleStep = 2 * math.pi / numRays;

    if (animation.value < 1.0) {
      canvas.save();
      canvas.translate(center.dx, center.dy);

      final rotationAngle = math.pi * (1 + animation.value * 0.8);
      final scale = math.max(0.01, 1 - animation.value);

      canvas.rotate(rotationAngle);
      canvas.scale(scale);

      final rayOpacity = (1 - animation.value).clamp(0.0, 1.0);
      final rayColor = rayPaint.color.withOpacity(rayOpacity);

      for (int i = 0; i < numRays; i++) {
        final angle = angleStep * i;
        // Start ray after the gap
        final xStart = rayStartRadius * math.cos(angle);
        final yStart = rayStartRadius * math.sin(angle);
        // End ray at calculated length
        final xEnd = (rayStartRadius + rayLength) * math.cos(angle);
        final yEnd = (rayStartRadius + rayLength) * math.sin(angle);

        canvas.drawLine(Offset(xStart, yStart), Offset(xEnd, yEnd),
            rayPaint..color = rayColor);
      }
      canvas.restore();
    }

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.drawCircle(center, radius, paint);

    final eclipseCircle = Paint()
      ..blendMode = BlendMode.clear
      ..isAntiAlias = true;

    final progress = Curves.easeInOutCubic.transform(animation.value);
    final translateX = size.width + (progress * -size.width * .75);
    final translateY = size.height + (progress * -size.height * .75);

    canvas.translate(translateX, -translateY);
    canvas.drawCircle(center, radius * 0.8, eclipseCircle);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ClassicPainter oldDelegate) => false;
}
