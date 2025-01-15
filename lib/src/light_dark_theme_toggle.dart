import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/model/configuration.dart';
import 'model/animation_type.dart';
import 'painters/painters.dart';

class LightDarkThemeToggle extends StatefulWidget {
  final AnimationType animationType;
  final LightDarkThemeToggleConfig configuration;
  final Color? color;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;

  const LightDarkThemeToggle({
    super.key,
    this.animationType = AnimationType.halfSun,
    this.configuration = const LightDarkThemeToggleConfig(),
    this.color,
    this.padding,
    this.tooltip,
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
    final iconTheme = Theme.of(context).iconTheme;

    final darkMode = Theme.of(context).brightness == Brightness.dark;

    final size = widget.configuration.size ?? (iconTheme.size ?? 24);
    final color = widget.color ?? (darkMode ? Colors.white : Colors.black);

    return IconButton(
      iconSize: size,
      tooltip: widget.tooltip,
      padding: widget.padding,
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
          AnimationType.classic =>
            ClassicPainter(animation: _animation, color: color),
          AnimationType.simple =>
            SimplePainter(animation: _animation, color: color),
          AnimationType.eclipse =>
            EclipsePainter(animation: _animation, color: color),
          AnimationType.halfSun =>
            HalfSunPainter(animation: _animation, color: color),
          AnimationType.darkSide =>
            DarkSidePainter(animation: _animation, color: color),
          AnimationType.innerMoon =>
            InnerMoonPainter(animation: _animation, color: color),
          AnimationType.expand =>
            ExpandPainter(animation: _animation, color: color),
          AnimationType.darkInner =>
            DarkInnerPainter(animation: _animation, color: color),
        },
      ),
    );
  }
}
