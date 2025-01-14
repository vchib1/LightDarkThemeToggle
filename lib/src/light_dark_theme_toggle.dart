import 'package:flutter/material.dart';
import 'model/animation_type.dart';
import 'painters/painters.dart';

const duration = Duration(milliseconds: 500);
const reverseDuration = Duration(milliseconds: 500);
const curve = Curves.ease;
const reverseCurve = Curves.ease;
const size = 100.0;

class LightDarkThemeToggle extends StatefulWidget {
  // TODO : Add Parameters to get customization
  final AnimationType animationType;

  //final Duration duration;
  //final Duration reverseDuration;
  //final Curve curve;

  const LightDarkThemeToggle({
    super.key,
    this.animationType = AnimationType.innerMoon,
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
      iconSize: size,
      onPressed: () {
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      icon: CustomPaint(
        size: const Size.square(size),
        painter: switch (widget.animationType) {
          AnimationType.classic => ClassicPainter(animation: _animation),
          AnimationType.simple => SimplePainter(animation: _animation),
          AnimationType.eclipse => EclipsePainter(animation: _animation),
          AnimationType.halfSun => HalfSunPainter(animation: _animation),
          AnimationType.darkSide => DarkSidePainter(animation: _animation),
          AnimationType.innerMoon => InnerMoonPainter(animation: _animation),
          // TODO: Handle this case.
          AnimationType.darkInner => throw UnimplementedError(),
        },
      ),
    );
  }
}
