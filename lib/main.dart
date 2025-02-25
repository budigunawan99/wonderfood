import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/provider/detail/restaurant_detail_provider.dart';
import 'package:wonderfood/provider/home/restaurant_list_provider.dart';
import 'package:wonderfood/provider/search/restaurant_search_provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/screen/detail/detail_screen.dart';
import 'package:wonderfood/screen/home/home_screen.dart';
import 'package:wonderfood/screen/search/search_screen.dart';
import 'package:wonderfood/static/navigation_route.dart';
import 'package:wonderfood/style/theme/wonderfood_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
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
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
          },
        );
      },
    );
  }
}
