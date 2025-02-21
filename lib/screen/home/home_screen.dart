import 'package:flutter/material.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/screen/common/rounded_sliver_app_bar.dart';
import 'package:wonderfood/screen/home/restaurant_list_item.dart';
import 'package:wonderfood/static/navigation_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RoundedSliverAppBar(
            isFirstPage: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(9),
            sliver: SliverList.separated(
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
          ),
        ],
      ),
    );
  }
}
