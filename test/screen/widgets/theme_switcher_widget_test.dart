import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/local/theme_shared_preferences_service.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/provider/theme_shared_preferences_provider.dart';
import 'package:wonderfood/screen/common/theme_switcher.dart';

class MockThemeProvider extends Mock implements ThemeProvider {}

class MockThemeSharedPreferencesService extends Mock
    implements ThemeSharedPreferencesService {}

void main() {
  late MockThemeProvider themeProvider;
  late MockThemeSharedPreferencesService themeSharedPreferencesService;
  late Widget widget;

  setUp(() {
    themeProvider = MockThemeProvider();
    themeSharedPreferencesService = MockThemeSharedPreferencesService();

    widget = MaterialApp(
      home: ChangeNotifierProvider<ThemeProvider>(
        create: (context) => themeProvider,
        child: ChangeNotifierProvider<ThemeSharedPreferencesProvider>(
          create:
              (context) =>
                  ThemeSharedPreferencesProvider(themeSharedPreferencesService),
          child: const ThemeSwitcher(),
        ),
      ),
    );
  });

  group('theme switcher widget', () {
    testWidgets("have an IconButton", (tester) async {
      when(() => themeProvider.isDarkMode).thenReturn(false);
      await tester.pumpWidget(widget);

      final iconButton = find.byType(IconButton);

      expect(iconButton, findsOneWidget);
    });

    testWidgets("have a brightness_4 icon when theme is light mode", (
      tester,
    ) async {
      when(() => themeProvider.isDarkMode).thenReturn(false);
      await tester.pumpWidget(widget);

      final iconButton = find.byType(IconButton);

      final iconInIconButtonFinder = find.descendant(
        of: iconButton,
        matching: find.byType(Icon),
      );

      final iconInIconButton = tester.widget<Icon>(iconInIconButtonFinder);

      expect(iconInIconButton.icon, Icons.brightness_4);
    });

    testWidgets("have a brightness_2 icon when theme is dark mode", (
      tester,
    ) async {
      when(() => themeProvider.isDarkMode).thenReturn(true);
      await tester.pumpWidget(widget);

      final iconButton = find.byType(IconButton);

      final iconInIconButtonFinder = find.descendant(
        of: iconButton,
        matching: find.byType(Icon),
      );

      final iconInIconButton = tester.widget<Icon>(iconInIconButtonFinder);

      expect(iconInIconButton.icon, Icons.brightness_2);
    });
  });
}
