import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/local/theme_shared_preferences_service.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/data/model/restaurant_search_response.dart';
import 'package:wonderfood/provider/search/restaurant_search_provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/provider/theme_shared_preferences_provider.dart';
import 'package:wonderfood/screen/common/theme_switcher.dart';
import 'package:wonderfood/screen/search/search_screen.dart';

import 'robot/ask_robot.dart';

class MockThemeSharedPreferencesService extends Mock
    implements ThemeSharedPreferencesService {}

class MockApiServices extends Mock implements ApiServices {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockThemeSharedPreferencesService themeSharedPreferencesService;
  late MockApiServices apiServices;

  testWidgets("integrate theme switcher feature", (tester) async {
    final askRobot = AskRobot(tester);
    themeSharedPreferencesService = MockThemeSharedPreferencesService();

    await askRobot.loadUI(
      MaterialApp(
        home: ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
          child: ChangeNotifierProvider<ThemeSharedPreferencesProvider>(
            create:
                (context) => ThemeSharedPreferencesProvider(
                  themeSharedPreferencesService,
                ),
            child: const ThemeSwitcher(),
          ),
        ),
      ),
    );

    //Initially, icon changes to dark mode icon if tapped
    await askRobot.tapThemeSwitcher();
    await askRobot.checkUpdatedIcon(Icons.brightness_2);

    //icon changes back to light mode icon if tapped again
    await askRobot.tapThemeSwitcher();
    await askRobot.checkUpdatedIcon(Icons.brightness_4);
  });

  testWidgets("integrate search feature", (tester) async {
    final askRobot = AskRobot(tester);
    apiServices = MockApiServices();
    themeSharedPreferencesService = MockThemeSharedPreferencesService();

    final searchSuccessQuery = "Melting Pot";
    final restaurantSearchSuccessResult = [
      Restaurant(
        id: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        description: "Melting Pot",
        pictureId: "14",
        city: "Medan",
        rating: 4.2,
      ),
    ];

    await askRobot.loadUI(
      MaterialApp(
        home: ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
          child: ChangeNotifierProvider<ThemeSharedPreferencesProvider>(
            create:
                (context) => ThemeSharedPreferencesProvider(
                  themeSharedPreferencesService,
                ),
            child: ChangeNotifierProvider<RestaurantSearchProvider>(
              create: (context) => RestaurantSearchProvider(apiServices),
              child: const SearchScreen(),
            ),
          ),
        ),
      ),
    );

    when(() => apiServices.searchRestaurantList(searchSuccessQuery)).thenAnswer(
      (_) async => RestaurantSearchResponse(
        error: false,
        founded: 1,
        restaurants: restaurantSearchSuccessResult,
      ),
    );

    await askRobot.typeSearchQuery(searchSuccessQuery);
    await askRobot.checkSuccessSearchResult(searchSuccessQuery);
  });
}
