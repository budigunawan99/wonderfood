import 'package:wonderfood/data/model/drink.dart';
import 'package:wonderfood/data/model/food.dart';

class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "foods": List<Food>.from(foods.map((x) => x.toJson())),
    "drinks": List<Drink>.from(drinks.map((x) => x.toJson())),
  };
}
