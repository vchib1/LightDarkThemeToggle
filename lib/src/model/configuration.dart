import 'package:flutter/material.dart';

class LightDarkThemeToggleConfig {
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final double? size;

  const LightDarkThemeToggleConfig({
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutBack,
    this.reverseCurve = Curves.easeOutBack,
    this.size,
  });
}
