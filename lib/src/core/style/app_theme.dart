import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'color_scheme.dart';

@immutable
final class AppTheme {
  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData ligthTheme;

  AppTheme({required this.mode})
      : darkTheme = ThemeData(
          brightness: Brightness.dark,
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: Colors.black,
        ),
        ligthTheme = ThemeData(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
          scaffoldBackgroundColor: Colors.white,
        );

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: Colors.black,
      );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: Colors.white,
      );

  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return ligthTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark ? darkTheme : ligthTheme;
    }
  }
}
