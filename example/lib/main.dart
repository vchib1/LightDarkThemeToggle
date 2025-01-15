import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: false ? ThemeData.dark() : ThemeData.light(),
      themeAnimationDuration: Duration(milliseconds: 300),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Example"),
          actions: [
            Switch(
              value: isDarkMode,
              onChanged: (value) => setState(() => isDarkMode = value),
            ),
          ],
        ),
        body: Center(
          child: Wrap(
            spacing: 5,
            runSpacing: 20,
            children: ThemeIconType.values.map(
              (e) {
                return Column(
                  spacing: 10,
                  children: [
                    LightDarkThemeToggle(
                      themeIconType: e,
                      value: isDarkMode,
                      onChanged: (value) => setState(() => isDarkMode = value),
                      configuration: LightDarkThemeToggleConfig(size: 100),
                    ),
                    Text(
                      e.name.substring(0, 1).toUpperCase() +
                          e.name.substring(1),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
