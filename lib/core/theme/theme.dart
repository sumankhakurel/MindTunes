import 'package:flutter/material.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';

class AppTheme {
  static _boder([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _boder(),
      enabledBorder: _boder(),
      focusedBorder: _boder(AppPallete.gradient2),
      errorBorder: _boder(AppPallete.errorColor),
    ),
  );
}
