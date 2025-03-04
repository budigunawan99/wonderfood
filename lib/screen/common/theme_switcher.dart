import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/provider/theme_shared_preferences_provider.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  void initState() {
    super.initState();
    final themeSharedPreferencesProvider =
        context.read<ThemeSharedPreferencesProvider>();
    final themeProvider = context.read<ThemeProvider>();

    Future.microtask(() async {
      themeSharedPreferencesProvider.getTheme();
      final theme = themeSharedPreferencesProvider.currentTheme;
      if (theme != null) {
        themeProvider.setDarkMode(theme);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          onPressed: () async {
            themeProvider.setDarkMode(!themeProvider.isDarkMode);
            final themeSharedPreferencesProvider =
                context.read<ThemeSharedPreferencesProvider>();
            try {
              await themeSharedPreferencesProvider.saveTheme(
                themeProvider.isDarkMode,
              );
            } catch (e) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(themeSharedPreferencesProvider.message),
                    backgroundColor: WonderfoodColors.red.color,
                  ),
                );
              });
            }
          },
          icon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              themeProvider.isDarkMode
                  ? Icons.brightness_2
                  : Icons.brightness_4,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
