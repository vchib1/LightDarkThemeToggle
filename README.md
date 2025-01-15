<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Light Dark Theme Toggle

A highly customizable and animated Flutter widget for toggling between light and dark themes. This package provides multiple beautiful transition animations and styles for theme switching, perfect for enhancing your app's user interface.

## Features

- 🎨 8 unique animation styles:
    - Classic Sun/Moon
    - Simple Toggle
    - Eclipse
    - Half Sun
    - Dark Side
    - Inner Moon
    - Expand
    - Dark Inner

- ⚡ Smooth, customizable animations
- 🎯 Pixel-perfect rendering using CustomPainter
- 🛠️ Highly configurable:
    - Custom colors
    - Adjustable size
    - Custom animation duration
    - Custom curves
    - Tooltips
    - Padding

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  light_dark_theme_toggle: ^1.0.0
```

Import it in your code:

```dart
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
```

## Usage

### Basic Usage

```dart
bool isDarkMode = false;

LightDarkThemeToggle(
  value: isDarkMode,
  onChanged: (value) {
    setState(() {
      isDarkMode = value;
    });
  },
)
```

### Customized Toggle

```dart
LightDarkThemeToggle(
  value: isDarkMode,
  onChanged: (value) {
    setState(() {
      isDarkMode = value;
    });
  },
  themeIconType: ThemeIconType.classic,
  configuration: LightDarkThemeToggleConfig(
    size: 30,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  ),
  color: Colors.blue,
  tooltip: 'Change theme',
  padding: const EdgeInsets.all(8),
)
```

### With Theme Switching

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            LightDarkThemeToggle(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Animation Styles

### Classic Sun/Moon
The traditional sun-to-moon transition with rays that fade out during the animation.

### Simple Toggle
A minimalist toggle with a clean transition between light and dark states.

### Eclipse
Simulates a solar eclipse effect for the theme transition.

### Half Sun
A modern interpretation showing a half-sun morphing into a moon.

### Dark Side
Inspired by the phases of the moon with a sliding dark side.

### Inner Moon
Features an inner circle that transforms for the theme change.

### Expand
An expanding circular transition between states.

### Dark Inner
Displays an inner shadow effect during the transition.

## Configuration Options

The `LightDarkThemeToggleConfig` class allows you to customize:

```dart
LightDarkThemeToggleConfig(
  size: 24.0,                    // Icon size
  duration: Duration(ms: 300),   // Animation duration
  reverseDuration: Duration(...),// Reverse animation duration
  curve: Curves.easeInOut,      // Animation curve
  reverseCurve: Curves.easeIn,  // Reverse animation curve
)
```

## Additional Information

### Compatibility
- Flutter: >=3.0.0
- Dart: >=3.0.0

### Contributing
Contributions are welcome! If you find a bug or want to add a new feature:
1. Open an issue
2. Create a pull request with your changes
3. Follow the existing code style
4. Add tests for new functionality

### License
This project is licensed under the MIT License - see the LICENSE file for details.

### Support
For bugs or feature requests, please open an issue on the GitHub repository.

### Credits
Created and maintained by [Your Name/Organization]
