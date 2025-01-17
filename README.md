# LightDarkThemeToggle

The `LightDarkThemeToggle` widget is a customizable and animated light/dark theme toggle switch for
Flutter apps. It provides a visually appealing way for users to switch between light and dark modes
in your app.

## Features

- Customizable size, color, padding, and tooltip.
- Smooth animations with adjustable duration and curves.
- Multiple animated icon styles using different theme icon types.
- Built entirely with Dart code and `CustomPainter` for efficient rendering and better performance.

## Preview

![LightDarkThemeToggle Demo](https://github.com/vchib1/LightDarkThemeToggle/raw/master/example/assets/demo.gif)

---

## Installation

1. Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  light_dark_theme_toggle: ^1.0.0
```

2. Import the package in your Dart file:

```dart
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
```

---

## Usage

Here is an example of how to use the `LightDarkThemeToggle` widget:

```dart
import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
import 'model/theme_icon_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: Text('Light/Dark Theme Toggle')),
        body: Center(
          child: LightDarkThemeToggle(
            value: false,
            // Initial value (false for dark, true for light)
            onChanged: (bool value) {
              // Handle theme change here.
            },
            size: 48.0,
            themeIconType: ThemeIconType.expand,
            color: Colors.orange,
            tooltip: 'Toggle Theme',
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }
}
```

---

## Properties

| Property          | Type                  | Default                                   | Description                                                            |
|-------------------|-----------------------|-------------------------------------------|------------------------------------------------------------------------|
| `value`           | `bool`                | Required                                  | Determines whether the toggle is in light (true) or dark (false) mode. |
| `onChanged`       | `ValueChanged<bool>`  | Required                                  | Callback when the toggle is pressed.                                   |
| `themeIconType`   | `ThemeIconType`       | `ThemeIconType.expand`                    | Defines the style of the icon.                                         |
| `color`           | `Color?`              | `Theme.of(context).colorScheme.onSurface` | Color of the icon.                                                     |
| `tooltip`         | `String?`             | `null`                                    | Tooltip displayed on long press.                                       |
| `padding`         | `EdgeInsetsGeometry?` | `null`                                    | Padding around the icon.                                               |
| `size`            | `double?`             | `IconTheme.size ?? 24.0`                  | Size of the icon.                                                      |
| `duration`        | `Duration`            | `Duration(milliseconds: 750)`             | Duration of the animation.                                             |
| `reverseDuration` | `Duration`            | `Duration(milliseconds: 750)`             | Duration of the reverse animation.                                     |
| `curve`           | `Curve`               | `Curves.easeOutBack`                      | Animation curve for the forward animation.                             |
| `reverseCurve`    | `Curve`               | `Curves.easeOutBack`                      | Animation curve for the reverse animation.                             |

---

## Theme Icon Types

The widget supports the following icon types via the `ThemeIconType` enum:

- **Classic**
- **Simple**
- **Eclipse**
- **HalfSun**
- **DarkSide**
- **InnerMoon**
- **Expand**
- **DarkInner**

To use an icon type, pass it to the `themeIconType` property. For example:

```dart
LightDarkThemeToggle(
  themeIconType: ThemeIconType.eclipse,
  ...
)
```

---

## Customization

### Animation

You can adjust the animation by changing:

- `duration`: Duration of the forward animation.
- `reverseDuration`: Duration of the reverse animation.
- `curve`: Curve for forward animation.
- `reverseCurve`: Curve for reverse animation.

### Appearance

You can customize the icon's:

- `size`: Adjust the size of the toggle.
- `color`: Change the icon's color.
- `padding`: Add padding around the icon.
- `tooltip`: Set a tooltip message for accessibility.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contributions

Contributions, issues, and feature requests are welcome! Feel free to check out
the [issues page](https://github.com/vchib1/LightDarkThemeToggle/issues).

---

## Acknowledgments

This package is inspired by [toggle.dev](https://toggles.dev/) created
by [Alfie Jones](https://github.com/AlfieJones).  
Special thanks for providing inspiration and ideas that helped shape this package.

