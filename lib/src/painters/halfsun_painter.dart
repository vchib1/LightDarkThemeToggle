import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class HalfSunPainter extends CustomPainter {
  final Animation<double> animation;

  const HalfSunPainter({required this.animation}) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final (height, width) = (size.height, size.width);

    final center = Offset(width / 2, height / 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);

    canvas.rotate(progress * math.pi);

    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: width * 0.75,
      height: height * 0.75,
    );
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final arcRect = Rect.fromCenter(
      center: Offset.zero,
      width: size.width * 0.60,
      height: size.height * 0.60,
    );

    //rect 1
    canvas.drawPath(
      Path()
        ..addRect(rect)
        ..addArc(arcRect..shift(Offset.zero), -getRadian(90), getRadian(180))
        ..fillType = PathFillType.evenOdd,
      paint,
    );
    // rotate canvas 45 degrees
    canvas.rotate(getRadian(45));
    // rect 2
    canvas.drawPath(
      Path()
        ..addRect(rect)
        ..addArc(arcRect..shift(Offset.zero), -getRadian(135), getRadian(180))
        ..fillType = PathFillType.evenOdd,
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant HalfSunPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}
