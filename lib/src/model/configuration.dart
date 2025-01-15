import 'package:flutter/material.dart';

/// The configuration for the [LightDarkThemeToggle].
///
///  Defaults to [LightDarkThemeToggleConfig]
///   * duration: [Duration(milliseconds: 750)]
///   * reverseDuration: [Duration(milliseconds: 750)]
///   * curve: [Curves.easeInOutCubic]
///   * reverseCurve: [Curves.easeInOutCubic]
///   * size: [24.0]
class LightDarkThemeToggleConfig {
  /// The duration of the animation.
  ///
  /// Defaults to [Duration(milliseconds: 750)].
  final Duration duration;

  /// The duration of the reverse animation.
  ///
  /// Defaults to [Duration(milliseconds: 750)].
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
  /// Defaults to [24.0].
  final double? size;

  const LightDarkThemeToggleConfig({
    this.duration = const Duration(milliseconds: 750),
    this.reverseDuration = const Duration(milliseconds: 750),
    this.curve = Curves.easeOutBack,
    this.reverseCurve = Curves.easeOutBack,
    this.size,
  }) : assert(size == null || size > 0, 'Size must be null or greater than 0');

  LightDarkThemeToggleConfig copyWith({
    Duration? duration,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    double? size,
  }) {
    return LightDarkThemeToggleConfig(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      size: size ?? this.size,
    );
  }
}
