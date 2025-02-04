import 'package:flutter/material.dart';
import 'model/theme_icon_type.dart';
import 'painters/painters.dart';

/// The main widget for the [LightDarkThemeToggle]
class LightDarkThemeToggle extends StatefulWidget {
  const LightDarkThemeToggle({
    super.key,
    this.size,
    required this.value,
    required this.onChanged,
    this.themeIconType = ThemeIconType.expand,
    this.color,
    this.hoverColor,
    this.highlightColor,
    this.focusColor,
    this.splashColor,
    this.padding,
    this.tooltip,
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutBack,
    this.reverseCurve = Curves.easeOutBack,
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
  /// Defaults to [ThemeIconType.expand]
  final ThemeIconType themeIconType;

  /// The color of the icon
  ///
  /// Defaults to [ThemeData.colorScheme.onSurface]
  final Color? color;

  /// The Color of the Toggle while hovering
  ///
  /// Defaults to [ThemeData.hoverColor]
  final Color? hoverColor;

  /// The Color of the Toggle when it has the input focus.
  ///
  /// Defaults to [ThemeData.focusColor]
  final Color? focusColor;

  /// The Color of the Toggle in pressed down state.
  ///
  /// Defaults to [ThemeData.highlightColor]
  final Color? highlightColor;

  /// The Splash Color of the Toggle.
  ///
  /// Defaults to [ThemeData.splashColor]
  ///
  /// If [ThemeData.useMaterial3] is set to true, this will not be used. Use [highlightColor] instead to show the overlay color of the button when the button is in the pressed state.
  final Color? splashColor;

  /// The tooltip of the icon
  ///
  /// Defaults to [null]
  final String? tooltip;

  /// The padding of the icon
  ///
  /// Defaults to [null]
  final EdgeInsetsGeometry? padding;

  /// The duration of the animation.
  ///
  /// Defaults to [Duration(milliseconds: 5000)].
  final Duration duration;

  /// The duration of the reverse animation.
  ///
  /// Defaults to [Duration(milliseconds: 500)].
  final Duration reverseDuration;

  /// The curve of the animation.
  ///
  /// Defaults to [Curves.easeInOutCubic].
  final Curve curve;

  /// The curve of the reverse animation.
  ///
  /// Defaults to [Curves.easeInOutCubic].
  final Curve reverseCurve;

  /// The size of the icon.
  ///
  /// Defaults to [IconTheme.size] ?? [24.0].
  final double? size;

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
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );

    _controller.value = widget.value ? 1 : 0;
  }

  @override
  void didUpdateWidget(LightDarkThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the value has changed, start the animation
    if (widget.value != oldWidget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
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
    final size = widget.size ?? (iconTheme.size ?? 24.0);
    final color = widget.color ?? Theme.of(context).colorScheme.onSurface;

    return IconButton(
      onPressed: () => widget.onChanged(!widget.value),
      alignment: Alignment.topLeft,
      hoverColor: widget.hoverColor,
      focusColor: widget.focusColor,
      highlightColor: widget.highlightColor,
      splashColor: widget.splashColor,
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
