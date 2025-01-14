import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/get_radian.dart';

class InnerMoonPainter extends CustomPainter {
  final Animation<double> animation;

  const InnerMoonPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final (height, width) = (size.height, size.width);

    final center = Offset(width / 2, height / 2);

    canvas.save();

    canvas.translate(center.dx, center.dy);

    canvas.rotate(animation.value * math.pi);

    final clipCircle = Rect.fromCircle(
      center: Offset.zero,
      radius: width * .325,
    );

    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: width * .75,
      height: height * .75,
    );

    // first box
    canvas.drawPath(
      Path()
        ..addRect(rect)
        ..addOval(clipCircle)
        ..fillType = PathFillType.evenOdd,
      paint,
    );

    canvas.rotate(getRadian(45));

    canvas.drawPath(
      Path()
        ..addRect(rect)
        ..addOval(clipCircle)
        ..fillType = PathFillType.evenOdd,
      paint,
    );

    canvas.restore();

    final translateX = size.width / 2 + (animation.value * size.width * .175);
    final translateY = size.height / 2;

    canvas.drawCircle(Offset(translateX, translateY), width * .25, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
