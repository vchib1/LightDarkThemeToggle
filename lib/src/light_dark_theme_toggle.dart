import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/src/model/configuration.dart';
import 'model/theme_icon_type.dart';
import 'painters/painters.dart';

class LightDarkThemeToggle extends StatefulWidget {
  const LightDarkThemeToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.themeIconType = ThemeIconType.halfSun,
    this.configuration = const LightDarkThemeToggleConfig(),
    this.color,
    this.padding,
    this.tooltip,
  });

  /// The current value of the toggle
  ///
  /// Determines whether the toggle is in light or dark mode.
  ///
  /// true is [light], false is [dark]
  final bool value;

  /// Called when the toggle is pressed.
  ///
  /// Provides the new value of the toggle.
  final ValueChanged<bool> onChanged;

  /// The type of the icon to display
  ///
  /// Defaults to [ThemeIconType.halfSun]
  final ThemeIconType themeIconType;

  /// The configuration of the toggle
  ///
  /// Defaults to [LightDarkThemeToggleConfig()]
  final LightDarkThemeToggleConfig configuration;

  /// The color of the icon
  ///
  /// Defaults to [Brightness == dark ? Colors.white : Colors.black]
  final Color? color;

  /// The tooltip of the icon
  ///
  /// Defaults to [null]
  final String? tooltip;

  /// The padding of the icon
  ///
  /// Defaults to [null]
  final EdgeInsetsGeometry? padding;

  @override
  State<LightDarkThemeToggle> createState() => _LightDarkThemeToggleState();
}

class _LightDarkThemeToggleState extends State<LightDarkThemeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

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

    _controller.value = widget.value ? 1 : 0;
  }

  @override
  void didUpdateWidget(LightDarkThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the value has changed
    // start the animation
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;
    final size = widget.configuration.size ?? (iconTheme.size ?? 24);
    final color = widget.color ?? Theme.of(context).colorScheme.onSurface;

    return IconButton(
      onPressed: () {
        widget.onChanged(!widget.value);
      },
      iconSize: size,
      tooltip: widget.tooltip,
      padding: widget.padding,
      icon: CustomPaint(
        size: Size.square(size),
        painter: switch (widget.themeIconType) {
          ThemeIconType.classic =>
            ClassicPainter(animation: _animation, color: color),
          ThemeIconType.simple =>
            SimplePainter(animation: _animation, color: color),
          ThemeIconType.eclipse =>
            EclipsePainter(animation: _animation, color: color),
          ThemeIconType.halfSun =>
            HalfSunPainter(animation: _animation, color: color),
          ThemeIconType.darkSide =>
            DarkSidePainter(animation: _animation, color: color),
          ThemeIconType.innerMoon =>
            InnerMoonPainter(animation: _animation, color: color),
          ThemeIconType.expand =>
            ExpandPainter(animation: _animation, color: color),
          ThemeIconType.darkInner =>
            DarkInnerPainter(animation: _animation, color: color),
        },
      ),
    );
  }
}
