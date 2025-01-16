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
          title: const Text('Light/Dark Theme Toggle'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
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
            children: ThemeIconType.values.map((iconType) {
              return Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LightDarkThemeToggle(
                    value: isDarkMode,
                    themeIconType: iconType,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                  Text(
                    iconType.name.substring(0, 1).toUpperCase() +
                        iconType.name.substring(1),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
