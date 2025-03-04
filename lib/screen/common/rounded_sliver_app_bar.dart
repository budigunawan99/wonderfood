import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/screen/common/theme_switcher.dart';
import 'package:wonderfood/static/navigation_route.dart';

class RoundedSliverAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isFirstPage;
  final String? title;

  const RoundedSliverAppBar({super.key, required this.isFirstPage, this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SliverAppBar(
          title: titleOptions(title, themeProvider),
          leading: leadingOptions(context),
          actions: [
            ThemeSwitcher(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NavigationRoute.favoriteRoute.name,
                );
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.favorite, size: 20),
              ),
            ),
          ],
          pinned: true,
          floating: true,
          snap: true,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget? leadingOptions(context) {
    if (isFirstPage) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 11.0, right: 11.0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
      );
    }
  }

  Widget titleOptions(title, themeProvider) {
    if (title == null) {
      return Padding(
        padding: const EdgeInsets.only(left: 11.0),
        child:
            themeProvider.isDarkMode
                ? Image.asset(
                  "assets/images/logo_header_wonderfood_dark.png",
                  width: 160,
                  height: 40,
                )
                : Image.asset(
                  "assets/images/logo_header_wonderfood.png",
                  width: 160,
                  height: 40,
                ),
      );
    } else {
      return Text(title);
    }
  }
}
