import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/model/configuration.dart';
import 'model/animation_type.dart';
import 'painters/painters.dart';

class LightDarkThemeToggle extends StatefulWidget {
  // TODO : Add Parameters to get customization
  final AnimationType animationType;
  final LightDarkThemeToggleConfig configuration;

  const LightDarkThemeToggle({
    super.key,
    this.animationType = AnimationType.halfSun,
    this.configuration = const LightDarkThemeToggleConfig(),
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
      duration: widget.configuration.duration,
      reverseDuration: widget.configuration.reverseDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.configuration.curve,
      reverseCurve: widget.configuration.reverseCurve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size =
        widget.configuration.size ?? (Theme.of(context).iconTheme.size ?? 24);

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
        size: Size.square(size),
        painter: switch (widget.animationType) {
          AnimationType.classic => ClassicPainter(animation: _animation),
          AnimationType.simple => SimplePainter(animation: _animation),
          AnimationType.eclipse => EclipsePainter(animation: _animation),
          AnimationType.halfSun => HalfSunPainter(animation: _animation),
          AnimationType.darkSide => DarkSidePainter(animation: _animation),
          AnimationType.innerMoon => InnerMoonPainter(animation: _animation),
          AnimationType.expand => ExpandPainter(animation: _animation),
          AnimationType.darkInner => DarkInnerPainter(animation: _animation),
        },
      ),
    );
  }
}
