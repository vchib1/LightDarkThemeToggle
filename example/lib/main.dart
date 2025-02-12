import 'package:flutter/material.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';

void main() => runApp(const MyApp());

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
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Light/Dark Theme Toggle Example'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: LightDarkThemeToggle(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              ...ThemeIconType.values.map(
                (themeIconType) {
                  return Card(
                    child: LightDarkThemeToggle(
                      size: 128.0,
                      themeIconType: themeIconType,
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                        });
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
