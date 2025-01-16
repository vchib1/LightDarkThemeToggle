import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';

void main() {
  testWidgets('LightDarkThemeToggle responds to taps', (tester) async {
    bool value = true;
    await tester.pumpWidget(MaterialApp(
      home: LightDarkThemeToggle(
        value: value,
        onChanged: (newValue) => value = newValue,
      ),
    ));

    await tester.tap(find.byType(IconButton));
    expect(value, false);
  });
}
