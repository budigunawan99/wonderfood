import 'package:flutter/material.dart';
import 'package:wonderfood/data/model/restaurant.dart';

class DetailTabScreen extends StatelessWidget {
  final Restaurant restaurant;

  const DetailTabScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox.square(dimension: 6),
                Expanded(
                  child: Text(
                    restaurant.rating.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.pin_drop,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox.square(dimension: 6),
                Expanded(
                  child: Text(
                    restaurant.address ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_city,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox.square(dimension: 6),
                Expanded(
                  child: Text(
                    restaurant.city,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tentang Kami",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox.square(dimension: 6),
                Text(
                  restaurant.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Makanan",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox.square(dimension: 12),
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus?.foods.length,
                    itemBuilder: (context, index) {
                      final food = restaurant.menus?.foods[index];
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 120,
                              minHeight: 100,
                              maxWidth: 100,
                              minWidth: 100,
                            ),
                            child: Card(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      food!.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            child: Image.asset(
                              "images/food_default.png",
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Minuman",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox.square(dimension: 12),
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus?.drinks.length,
                    itemBuilder: (context, index) {
                      final food = restaurant.menus?.drinks[index];
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 120,
                              minHeight: 100,
                              maxWidth: 100,
                              minWidth: 100,
                            ),
                            child: Card(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      food!.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            child: Image.asset(
                              "images/drink_default.png",
                              width: 85,
                              height: 85,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
