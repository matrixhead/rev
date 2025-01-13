import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const revRed = Color(0xfffd6671);

const _faceColors = FaceColors(colors: [
  Colors.amber,
  Colors.blue,
  Colors.brown,
  Colors.cyan,
  Colors.green,
  Colors.indigo,
  Colors.lime,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
]);

class FaceColors extends ThemeExtension<FaceColors> {
  final List<Color> colors;

  const FaceColors({required this.colors});
  @override
  FaceColors copyWith({List<Color>? colors}) {
    return FaceColors(colors: colors ?? this.colors);
  }

  @override
  FaceColors lerp(covariant ThemeExtension<FaceColors>? other, double t) {
    if (other is! FaceColors) {
      return this;
    }
    final newColors = IterableZip([colors, other.colors])
        .map((final colorPair) =>
            Color.lerp(colorPair[0], colorPair[1], t) ?? colorPair[0])
        .toList();
    return FaceColors(colors: newColors);
  }

  FaceColors harmonized(Color hColor) {
    final hColors =
        colors.map((final color) => color.harmonizeWith(hColor)).toList();
    return FaceColors(colors: hColors);
  }
}

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
  baseThemeData = baseThemeData.copyWith(
      extensions: [_faceColors.harmonized(baseThemeData.colorScheme.primary)]);
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
