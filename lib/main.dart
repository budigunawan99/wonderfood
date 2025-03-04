import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/local/local_database_service.dart';
import 'package:wonderfood/data/local/notification_shared_preferences_service.dart';
import 'package:wonderfood/data/local/theme_shared_preferences_service.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/provider/detail/restaurant_detail_provider.dart';
import 'package:wonderfood/provider/favorite/favorite_provider.dart';
import 'package:wonderfood/provider/home/restaurant_list_provider.dart';
import 'package:wonderfood/provider/review/restaurant_review_provider.dart';
import 'package:wonderfood/provider/search/restaurant_search_provider.dart';
import 'package:wonderfood/provider/settings/notification_provider.dart';
import 'package:wonderfood/provider/settings/notification_shared_preferences_provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/provider/theme_shared_preferences_provider.dart';
import 'package:wonderfood/screen/detail/detail_screen.dart';
import 'package:wonderfood/screen/favorite/favorite_screen.dart';
import 'package:wonderfood/screen/home/home_screen.dart';
import 'package:wonderfood/screen/review/review_screen.dart';
import 'package:wonderfood/screen/search/search_screen.dart';
import 'package:wonderfood/screen/settings/settings_screen.dart';
import 'package:wonderfood/static/navigation_route.dart';
import 'package:wonderfood/style/theme/wonderfood_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create:
              (context) => RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantSearchProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantReviewProvider(context.read<ApiServices>()),
        ),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create:
              (context) =>
                  FavoriteProvider(context.read<LocalDatabaseService>()),
        ),
        Provider(create: (context) => ThemeSharedPreferencesService(prefs)),
        ChangeNotifierProvider(
          create:
              (context) => ThemeSharedPreferencesProvider(
                context.read<ThemeSharedPreferencesService>(),
              ),
        ),
        Provider(
          create: (context) => NotificationSharedPreferencesService(prefs),
        ),
        ChangeNotifierProvider(
          create:
              (context) => NotificationSharedPreferencesProvider(
                context.read<NotificationSharedPreferencesService>(),
              ),
        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (_) => NotificationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'wonderfood',
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: WonderfoodTheme.lightTheme,
          darkTheme: WonderfoodTheme.darkTheme,
          initialRoute: NavigationRoute.homeRoute.name,
          routes: {
            NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
            NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
            NavigationRoute.favoriteRoute.name:
                (context) => const FavoriteScreen(),
            NavigationRoute.settingsRoute.name:
                (context) => const SettingsScreen(),
            NavigationRoute.reviewRoute.name:
                (context) => ReviewScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.detailRoute.name:
                (context) => DetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
          },
        );
      },
    );
  }
}
