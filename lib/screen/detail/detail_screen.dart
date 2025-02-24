import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/screen/detail/detail_tab_screen.dart';
import 'package:wonderfood/screen/detail/ulasan_tab_screen.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';
import 'package:wonderfood/utils/sliver_header_delegate.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const DetailScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                background: Hero(
                  tag: restaurant.id,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(restaurant.pictureId),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().isDarkMode
                          ? WonderfoodColors.lightBlue.color
                              .withValues(alpha: 0.25)
                          : WonderfoodColors.lightOrange.color
                              .withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ),
            ),
            _header(
              context,
              TabBar.secondary(
                dividerHeight: 0.5,
                labelColor: Theme.of(context).colorScheme.onSurface,
                labelStyle: Theme.of(context).textTheme.labelLarge,
                tabs: [
                  Tab(text: "Detail"),
                  Tab(text: "Ulasan"),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: <Widget>[
                    DetailTabScreen(restaurant: restaurant),
                    UlasanTabScreen(restaurant: restaurant),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader _header(
    BuildContext context,
    TabBar tabBar,
  ) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: tabBar.preferredSize.height,
        maxHeight: tabBar.preferredSize.height,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: tabBar,
        ),
      ),
    );
  }
}
