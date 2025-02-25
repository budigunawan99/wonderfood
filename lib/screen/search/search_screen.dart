import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/provider/search/restaurant_search_provider.dart';
import 'package:wonderfood/screen/common/rounded_sliver_app_bar.dart';
import 'package:wonderfood/screen/common/skeleton_loading.dart';
import 'package:wonderfood/screen/home/restaurant_list_item.dart';
import 'package:wonderfood/static/navigation_route.dart';
import 'package:wonderfood/static/restaurant_search_result_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    onSearchTextChanged("");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RoundedSliverAppBar(
            isFirstPage: false,
          ),
          SliverPadding(
            padding: EdgeInsets.all(9),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      _searchController.clear();
                      onSearchTextChanged("");
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: Consumer<RestaurantSearchProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantSearchLoadingState() => SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: SkeletonLoading(
                          count: 10,
                        ),
                      ),
                    ),
                  RestaurantSearchLoadedState(data: var restaurantList) =>
                    SliverList.separated(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
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
                  _ => SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/search_illustration.png",
                            width: 250,
                            height: 250,
                          ),
                          Text(
                            "Ketik nama restoran yang ingin anda cari",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
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

  Future onSearchTextChanged(String text) async {
    context.read<RestaurantSearchProvider>().fetchRestaurantSearch(text);
  }
}
