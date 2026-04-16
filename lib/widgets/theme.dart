import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF4D9C89),
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    brightness: Brightness.light,
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF4D9C89),
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    brightness: Brightness.dark,
  ),
);

final themeMode = ValueNotifier(ThemeMode.light);
