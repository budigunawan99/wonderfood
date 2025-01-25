import 'package:flutter/material.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';
import 'package:wonderfood/style/typography/wonderfood_text_style.dart';

class WonderfoodTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: WonderfoodColors.orange.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: WonderfoodColors.darkBlue.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: WonderfoodTextStyle.displayLarge,
      displayMedium: WonderfoodTextStyle.displayMedium,
      displaySmall: WonderfoodTextStyle.displaySmall,
      headlineLarge: WonderfoodTextStyle.headlineLarge,
      headlineMedium: WonderfoodTextStyle.headlineMedium,
      headlineSmall: WonderfoodTextStyle.headlineSmall,
      titleLarge: WonderfoodTextStyle.titleLarge,
      titleMedium: WonderfoodTextStyle.titleMedium,
      titleSmall: WonderfoodTextStyle.titleSmall,
      bodyLarge: WonderfoodTextStyle.bodyLargeBold,
      bodyMedium: WonderfoodTextStyle.bodyLargeMedium,
      bodySmall: WonderfoodTextStyle.bodyLargeRegular,
      labelLarge: WonderfoodTextStyle.labelLarge,
      labelMedium: WonderfoodTextStyle.labelMedium,
      labelSmall: WonderfoodTextStyle.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: WonderfoodColors.white.color,
        size: 16.0,
      ),
    );
  }
}
