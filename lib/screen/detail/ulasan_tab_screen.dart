import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/data/model/review.dart';
import 'package:wonderfood/provider/detail/restaurant_detail_provider.dart';
import 'package:wonderfood/static/navigation_route.dart';

class UlasanTabScreen extends StatefulWidget {
  final Restaurant restaurant;

  const UlasanTabScreen({super.key, required this.restaurant});

  @override
  State<UlasanTabScreen> createState() => _UlasanTabScreenState();
}

class _UlasanTabScreenState extends State<UlasanTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 22, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lihat Ulasan",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Flexible(
                flex: 1,
                child: TextButton(
                  onPressed: () async {
                    final updatedReviews = await Navigator.pushNamed(
                      context,
                      NavigationRoute.reviewRoute.name,
                      arguments: widget.restaurant.id,
                    );
                    if (!context.mounted || updatedReviews is! List<Review>) {
                      return;
                    }
                    context.read<RestaurantDetailProvider>().setCustomerReviews(
                      updatedReviews,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Review',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  context
                      .watch<RestaurantDetailProvider>()
                      .customerReviews
                      .length,
              itemBuilder: (context, index) {
                final review =
                    context
                        .watch<RestaurantDetailProvider>()
                        .customerReviews[index];
                return Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 50,
                            minHeight: 50,
                            maxWidth: 50,
                            minWidth: 50,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
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
                                review.name,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox.square(dimension: 2),
                              Text(
                                review.date,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox.square(dimension: 2),
                              Text(
                                review.review,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
