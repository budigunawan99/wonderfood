import 'package:flutter/material.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';
import 'package:wonderfood/style/typography/wonderfood_text_style.dart';

class WonderfoodTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: lightColorScheme,
      focusColor: _lightFocusColor,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _lightAppBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: darkColorScheme,
      focusColor: _darkFocusColor,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _darkAppBarTheme,
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

  static AppBarTheme get _lightAppBarTheme {
    return AppBarTheme(
      backgroundColor: WonderfoodColors.white.color,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: WonderfoodColors.orange.color,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: WonderfoodColors.orange.color,
        size: 14.0,
      ),
    );
  }

  static AppBarTheme get _darkAppBarTheme {
    return AppBarTheme(
      backgroundColor: WonderfoodColors.darkBlue.color,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: WonderfoodColors.white.color,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: WonderfoodColors.white.color,
        size: 14.0,
      ),
    );
  }

  static ColorScheme lightColorScheme = ColorScheme(
    primary: WonderfoodColors.orange.color,
    onPrimary: WonderfoodColors.white.color,
    secondary: WonderfoodColors.brown.color,
    onSecondary: WonderfoodColors.white.color,
    error: WonderfoodColors.red.color,
    onError: WonderfoodColors.white.color,
    surface: WonderfoodColors.lightOrange.color,
    onSurface: WonderfoodColors.black.color,
    brightness: Brightness.light,
    surfaceContainer: WonderfoodColors.white.color,
  );

  static ColorScheme darkColorScheme = ColorScheme(
    primary: WonderfoodColors.darkBlue.color,
    onPrimary: WonderfoodColors.white.color,
    secondary: WonderfoodColors.neutralBlue.color,
    onSecondary: WonderfoodColors.white.color,
    error: WonderfoodColors.red.color,
    onError: WonderfoodColors.white.color,
    surface: WonderfoodColors.neutralBlue.color,
    onSurface: WonderfoodColors.white.color,
    brightness: Brightness.dark,
    surfaceContainer: WonderfoodColors.lightBlue.color,
  );

  static final Color _lightFocusColor = Colors.black.withValues(
    alpha: 0.12,
  );
  static final Color _darkFocusColor = Colors.white.withValues(
    alpha: 0.12,
  );
}
