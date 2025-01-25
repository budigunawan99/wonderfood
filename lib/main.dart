import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/screen/home/home_screen.dart';
import 'package:wonderfood/static/navigation_route.dart';
import 'package:wonderfood/style/theme/wonderfood_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
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
            // NavigationRoute.detailRoute.name: (context) => DetailScreen(
            //       tourism: ModalRoute.of(context)?.settings.arguments as int,
            //     ),
          },
        );
      },
    );
  }
}
