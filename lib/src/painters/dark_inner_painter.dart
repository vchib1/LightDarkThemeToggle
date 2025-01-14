import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class DarkInnerPainter extends CustomPainter {
  final Animation<double> animation;

  const DarkInnerPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final (height, width) = (size.height, size.width);

    final center = Offset(width / 2, height / 2);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final mainRadius = width;

    final mainRect =
        Rect.fromCenter(center: center, width: mainRadius, height: mainRadius);

    final rect = Rect.fromCenter(
        center: center, width: width * .75, height: height * .75);

    final rect2 = Rect.fromCenter(
        center: center, width: mainRadius * .45, height: mainRadius * .45);

    canvas.save();

    canvas.drawPath(
      Path()
        ..addOval(mainRect)
        ..addArc(rect, -getRadian(90), getRadian(180))
        ..addArc(rect2, -getRadian(90), getRadian(180))
        ..fillType = PathFillType.evenOdd,
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
