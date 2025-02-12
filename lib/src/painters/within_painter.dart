import 'package:flutter/material.dart';

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
  }

  @override
  bool shouldRepaint(covariant WithinPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color;
  }
}
