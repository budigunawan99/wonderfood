import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/provider/detail/favorite_icon_provider.dart';
import 'package:wonderfood/provider/favorite/favorite_provider.dart';
import 'package:wonderfood/static/favorite_action_state.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();
    final favoriteProvider = context.read<FavoriteProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await favoriteProvider.getRestaurantById(widget.restaurant.id);

      favoriteIconProvider.isFavorited = favoriteProvider.checkItemFavorite(
        widget.restaurant.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, value, child) {
        return switch (value.actionResultState) {
          FavoriteActionLoadingState() => Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          ),

          FavoriteActionErrorState(error: var message) => Builder(
            builder: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
                value.setActionResultState(FavoriteActionNoneState());
              });

              return IconButton(
                onPressed: () async {
                  final favoriteIconProvider =
                      context.read<FavoriteIconProvider>();
                  final isFavorited = favoriteIconProvider.isFavorited;

                  if (!isFavorited) {
                    await value.saveRestaurant(widget.restaurant);
                  } else {
                    await value.removeRestaurantById(widget.restaurant.id);
                  }

                  favoriteIconProvider.isFavorited = !isFavorited;
                  value.getAllRestaurants();
                },
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      context.watch<FavoriteIconProvider>().isFavorited
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 25,
                    ),
                  ),
                ),
              );
            },
          ),

          FavoriteActionLoadedState(message: var message) => Builder(
            builder: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),                   
                  ),
                );
                value.setActionResultState(FavoriteActionNoneState());
              });

              return IconButton(
                onPressed: () async {
                  final favoriteIconProvider =
                      context.read<FavoriteIconProvider>();
                  final isFavorited = favoriteIconProvider.isFavorited;

                  if (!isFavorited) {
                    await value.saveRestaurant(widget.restaurant);
                  } else {
                    await value.removeRestaurantById(widget.restaurant.id);
                  }

                  favoriteIconProvider.isFavorited = !isFavorited;
                  value.getAllRestaurants();
                },
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      context.watch<FavoriteIconProvider>().isFavorited
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 25,
                    ),
                  ),
                ),
              );
            },
          ),

          _ => IconButton(
            onPressed: () async {
              final favoriteIconProvider = context.read<FavoriteIconProvider>();
              final isFavorited = favoriteIconProvider.isFavorited;

              if (!isFavorited) {
                await value.saveRestaurant(widget.restaurant);
              } else {
                await value.removeRestaurantById(widget.restaurant.id);
              }

              favoriteIconProvider.isFavorited = !isFavorited;
              value.getAllRestaurants();
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  context.watch<FavoriteIconProvider>().isFavorited
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  size: 25,
                ),
              ),
            ),
          ),
        };
      },
    );
  }
}
