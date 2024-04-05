import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class AppTheme {
  static _inputBorder([Color color = ColorPallete.grey400]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      );

  static final darkThemeMode = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'montserrat',
      scaffoldBackgroundColor: ColorPallete.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorPallete.backgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: _inputBorder(ColorPallete.grey400),
        focusedBorder: _inputBorder(ColorPallete.blue800),
        errorBorder: _inputBorder(ColorPallete.errorColor),
        focusedErrorBorder: _inputBorder(ColorPallete.errorColor),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: ColorPallete.backgroundColor,
      ));
}
