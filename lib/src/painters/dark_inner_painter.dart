import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/utils/get_radian.dart';

class DarkInnerPainter extends CustomPainter {
  final Animation<double> animation;

  const DarkInnerPainter({required this.animation}) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final (height, width) = (size.height, size.width);

    final center = Offset(width / 2, height / 2);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final mainRadius = width / 2 * .90;
    final innerRadius = mainRadius * .50;

    // Save layer for clipping effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    canvas.drawCircle(center, mainRadius, paint);

    canvas.translate(center.dx, center.dy);

    final outerArc = Rect.fromCenter(
      center: Offset.zero,
      width: width * .70,
      height: height * .70,
    );

    canvas.rotate(getRadian(180) * progress);

    canvas.drawArc(
      outerArc,
      -getRadian(90),
      getRadian(180),
      false,
      Paint()..blendMode = BlendMode.clear,
    );

    canvas.translate(-center.dx, -center.dy);

    canvas.drawCircle(
      center,
      innerRadius,
      Paint()..blendMode = BlendMode.clear,
    );

    canvas.restore();

    canvas.save();

    canvas.translate(center.dx, center.dy);

    canvas.rotate(-getRadian(180) * progress);

    final innerArc = Rect.fromCenter(
      center: Offset.zero,
      width: mainRadius,
      height: mainRadius,
    );

    canvas.drawArc(innerArc, -getRadian(90), getRadian(180), false, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
