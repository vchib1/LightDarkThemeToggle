import 'package:flutter/material.dart';
import '../utils/get_radian.dart';
import 'constants.dart';

class InnerMoonPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  const InnerMoonPainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  double get progress => animation.value;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    final (height, width) = (size.height, size.width);

    final center = Offset(width / 2, height / 2);

    canvas.save();

    canvas.translate(center.dx, center.dy);

    canvas.rotate(progress * getRadian(180));

    final clipCircle = Rect.fromCircle(
      center: Offset.zero,
      radius: width * .30,
    );

    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: width * squareSizeFactor,
      height: height * squareSizeFactor,
    );

    final rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular((width * squareSizeFactor) * borderRadiusFactor),
    );

    // first box
    canvas.drawPath(
      Path()
        ..addRRect(rRect)
        ..addOval(clipCircle)
        ..fillType = PathFillType.evenOdd,
      paint,
    );

    canvas.rotate(getRadian(45));

    canvas.drawPath(
      Path()
        ..addRRect(rRect)
        ..addOval(clipCircle)
        ..fillType = PathFillType.evenOdd,
      paint,
    );

    canvas.restore();

    final translateX = width / 2 + (progress.clamp(0.0, 1.0) * width * .175);
    final translateY = height / 2;

    canvas.drawCircle(Offset(translateX, translateY), width * .225, paint);
  }

  @override
  bool shouldRepaint(covariant InnerMoonPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color;
  }
}
