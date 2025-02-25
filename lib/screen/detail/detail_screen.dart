import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/provider/detail/restaurant_detail_provider.dart';
import 'package:wonderfood/provider/theme_provider.dart';
import 'package:wonderfood/screen/detail/detail_tab_screen.dart';
import 'package:wonderfood/screen/detail/ulasan_tab_screen.dart';
import 'package:wonderfood/static/restaurant_detail_result_state.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';
import 'package:wonderfood/utils/sliver_header_delegate.dart';

class DetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  const DetailScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const String _mediumImageUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurant.id);
    });
  }

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
                title: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    widget.restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                background: Hero(
                  tag: widget.restaurant.id,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "$_mediumImageUrl${widget.restaurant.pictureId}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: context.watch<ThemeProvider>().isDarkMode
                            ? [
                                WonderfoodColors.lightBlue.color
                                    .withValues(alpha: 0),
                                WonderfoodColors.lightBlue.color
                                    .withValues(alpha: 0.5),
                                WonderfoodColors.lightBlue.color
                                    .withValues(alpha: 1)
                              ]
                            : [
                                WonderfoodColors.lightOrange.color
                                    .withValues(alpha: 0),
                                WonderfoodColors.lightOrange.color
                                    .withValues(alpha: 0.5),
                                WonderfoodColors.lightOrange.color
                                    .withValues(alpha: 1),
                              ],
                      ),
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
                child: Consumer<RestaurantDetailProvider>(
                  builder: (context, value, child) {
                    return switch (value.resultState) {
                      RestaurantDetailLoadingState() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      RestaurantDetailLoadedState(data: var restaurantDetail) =>
                        TabBarView(
                          children: <Widget>[
                            DetailTabScreen(restaurant: restaurantDetail),
                            UlasanTabScreen(restaurant: restaurantDetail),
                          ],
                        ),
                      RestaurantDetailErrorState(error: var message) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  kToolbarHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/nodata.png",
                                    width: 250,
                                    height: 250,
                                  ),
                                  const SizedBox.square(dimension: 10),
                                  Text(
                                    message,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      _ => const SizedBox(),
                    };
                  },
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
