import 'package:flutter/material.dart';
import 'painters/painters.dart';

const duration = Duration(milliseconds: 300);
const reverseDuration = Duration(milliseconds: 300);
const curve = Curves.easeInOutBack;
const reverseCurve = Curves.easeInOutBack;

class LightDarkThemeToggle extends StatefulWidget {
  // TODO : Add Parameters to get customization
  //final Duration duration;
  //final Duration reverseDuration;
  //final Curve curve;

  const LightDarkThemeToggle({
    super.key,
    //required this.duration,
    //required this.reverseDuration,
    //required this.curve,
  });

  @override
  State<LightDarkThemeToggle> createState() => _LightDarkThemeToggleState();
}

class _LightDarkThemeToggleState extends State<LightDarkThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: reverseDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: curve,
      reverseCurve: reverseCurve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 100,
      onPressed: () {
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      icon: CustomPaint(
        size: Size.square(100),
        painter: DarkSidePainter(
          animation: _animation,
        ),
      ),
    );
  }
}
