import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class ClassicPainter extends CustomPainter {
  final Animation<double> animation;

  const ClassicPainter({required this.animation}) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final minDimension = math.min(size.width, size.height);
    final radius = minDimension * 0.325;

    // Ray dimensions relative to size
    final baseStrokeWidth = minDimension * 0.05;
    final rayGap = minDimension * 0.075;
    final rayStartRadius = (radius * .90) + rayGap;
    final rayLength = minDimension * 0.15;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final rayPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = baseStrokeWidth
      ..isAntiAlias = true;

    const int numRays = 8;
    double angleStep = getRadian(360) / numRays;

    if (progress < 1.0) {
      canvas.save();
      canvas.translate(center.dx, center.dy);

      final rotationAngle = math.pi * (1 + animation.value * 0.35);
      final scale = math.max(0.01, 1 - animation.value);

      canvas.rotate(rotationAngle);
      canvas.scale(scale);

      final rayOpacity = (1 - progress).clamp(0.0, 1.0);
      final rayColor = rayPaint.color.withValues(alpha: rayOpacity);

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

    final translateX = size.width + (progress * -size.width * .75);
    final translateY = size.height + (progress * -size.height * .80);

    canvas.translate(translateX, -translateY);
    canvas.drawCircle(center, radius, eclipseCircle);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ClassicPainter oldDelegate) => false;
}
