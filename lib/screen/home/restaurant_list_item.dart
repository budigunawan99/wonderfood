import 'package:flutter/material.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantListItem extends StatelessWidget {
  static const String _smallImageUrl =
      "https://restaurant-api.dicoding.dev/images/small/";
  final Restaurant restaurant;
  const RestaurantListItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 76,
                  minHeight: 76,
                  maxWidth: 114,
                  minWidth: 114,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: restaurant.id,
                    child: Image.network(
                      "$_smallImageUrl${restaurant.pictureId}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/img_default.png',
                          fit: BoxFit.fitWidth,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox.square(dimension: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox.square(dimension: 4),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: RatingBarIndicator(
                            rating: restaurant.rating,
                            itemCount: 5,
                            itemSize: 14.0,
                            itemBuilder:
                                (context, _) => Icon(
                                  Icons.star,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        const SizedBox.square(dimension: 4),
                        Expanded(
                          child: Text(
                            restaurant.rating.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox.square(dimension: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox.square(dimension: 4),
                        Expanded(
                          child: Text(
                            restaurant.city,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
