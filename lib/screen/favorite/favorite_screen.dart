import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/provider/favorite/favorite_provider.dart';
import 'package:wonderfood/screen/common/rounded_sliver_app_bar.dart';
import 'package:wonderfood/screen/common/skeleton_loading.dart';
import 'package:wonderfood/screen/home/restaurant_list_item.dart';
import 'package:wonderfood/static/favorite_list_result_state.dart';
import 'package:wonderfood/static/navigation_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavoriteProvider>().getAllRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RoundedSliverAppBar(isFirstPage: false, title: "Restoran Favorit"),
          SliverPadding(
            padding: EdgeInsets.all(9),
            sliver: Consumer<FavoriteProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  FavoriteListLoadingState() => SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SkeletonLoading(count: 10),
                    ),
                  ),
                  FavoriteListLoadedState(data: var favoriteList) =>
                    SliverList.separated(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        final restaurant = favoriteList[index];
                        return InkWell(
                          child: RestaurantListItem(restaurant: restaurant),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant,
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 9);
                      },
                    ),
                  FavoriteListErrorState(error: var message) =>
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/nodata.png",
                              width: 250,
                              height: 250,
                            ),
                            const SizedBox.square(dimension: 10),
                            Text(
                              message,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  _ => SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inbox,
                            size: 180,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox.square(dimension: 10),
                          Text(
                            "Daftar favoritmu masih kosong.",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
