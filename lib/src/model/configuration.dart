import 'package:flutter/material.dart';

class LightDarkThemeToggleConfig {
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final double? size;

  const LightDarkThemeToggleConfig({
    this.duration = const Duration(milliseconds: 750),
    this.reverseDuration = const Duration(milliseconds: 750),
    this.curve = Curves.easeOutBack,
    this.reverseCurve = Curves.easeOutBack,
    this.size,
  }) : assert(size == null || size > 0, 'Size must be null or greater than 0');
}
