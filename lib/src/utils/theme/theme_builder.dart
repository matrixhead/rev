import 'package:flutter/material.dart';
import 'package:rebar/src/utils/theme/color_consts.dart';

ThemeData buildDefaultTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
        primary: primary, secondary: secondary, background: background),
  );
}
