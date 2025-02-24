import 'package:flutter/material.dart';
import 'package:wonderfood/data/model/restaurant.dart';

class UlasanTabScreen extends StatelessWidget {
  final Restaurant restaurant;

  const UlasanTabScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: restaurant.customerReviews?.length,
        itemBuilder: (context, index) {
          final review = restaurant.customerReviews?[index];
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
                        "images/user.png",
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
                          review!.name,
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
    );
  }
}
