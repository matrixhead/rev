import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const revRed = Color(0xfffd6671);

(
  ColorScheme,
  ColorScheme,
) buildColorScheme(
  ColorScheme? lightDynamic,
  ColorScheme? darkDynamic,
) {
  ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: revRed,
  );
  ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: revRed,
    brightness: Brightness.dark,
  );

  if (lightDynamic != null && darkDynamic != null) {
    lightColorScheme = lightColorScheme.copyWith(
        primary: lightDynamic.primary,
        secondary: revRed,
        tertiary: lightDynamic.tertiary);
    lightColorScheme = lightColorScheme.harmonized();
    darkColorScheme = darkColorScheme.copyWith(
        primary: darkDynamic.primary,
        secondary: revRed,
        tertiary: darkDynamic.tertiary);
    darkColorScheme = darkColorScheme.harmonized();
  }

  return (lightColorScheme, darkColorScheme);
}

InputDecorationTheme buildInputDecorationTheme(ThemeData baseThemeData) {
  return baseThemeData.inputDecorationTheme.copyWith(
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(3.0),
    ),
  );
}

ElevatedButtonThemeData buildElevatedButtonTheme(ThemeData baseThemeData) {
  final style =
      (baseThemeData.elevatedButtonTheme.style ?? ButtonStyle()).copyWith(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
  return ElevatedButtonThemeData(style: style);
}

TextButtonThemeData buildTextButtonTheme(ThemeData baseThemeData) {
  final style = (baseThemeData.textButtonTheme.style ?? ButtonStyle()).copyWith(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    elevation: WidgetStatePropertyAll(0),
    splashFactory: NoSplash.splashFactory,
    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
  return TextButtonThemeData(style: style);
}

ThemeData buildFromBaseThemedata(ThemeData baseThemeData) {
  baseThemeData = baseThemeData.copyWith(
      inputDecorationTheme: buildInputDecorationTheme(baseThemeData));
  baseThemeData = baseThemeData.copyWith(
      elevatedButtonTheme: buildElevatedButtonTheme(baseThemeData));
  baseThemeData = baseThemeData.copyWith(
      textButtonTheme: buildTextButtonTheme(baseThemeData));

  return baseThemeData;
}

(ThemeData, ThemeData) buildTheme(
    ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
  final (lightColorScheme, darkColorScheme) =
      buildColorScheme(lightDynamic, darkDynamic);
  return (
    //note: [colorScheme] and [textTheme] are used by the Material components to compute default values
    buildFromBaseThemedata(
      ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
    ),
    buildFromBaseThemedata(
      ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
    ),
  );
}
