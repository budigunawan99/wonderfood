import 'package:wonderfood/data/model/drink.dart';
import 'package:wonderfood/data/model/food.dart';
import 'package:wonderfood/data/model/menu.dart';
import 'package:wonderfood/data/model/review.dart';
import 'package:wonderfood/data/model/restaurant_category.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String? address;
  final List<RestaurantCategory>? categories;
  final Menu? menus;
  final List<Review>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      address: json["address"] ?? "",
      categories:
          json["categories"] != null
              ? List<RestaurantCategory>.from(
                json["categories"].map((x) => RestaurantCategory.fromJson(x)),
              )
              : <RestaurantCategory>[],
      menus:
          json["menus"] != null
              ? Menu.fromJson(json["menus"])
              : Menu(foods: <Food>[], drinks: <Drink>[]),
      customerReviews:
          json["customerReviews"] != null
              ? List<Review>.from(
                json["customerReviews"].map((x) => Review.fromJson(x)),
              )
              : <Review>[],
    );
  }
}
