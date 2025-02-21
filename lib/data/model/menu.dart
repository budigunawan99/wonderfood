import 'package:wonderfood/data/model/drink.dart';
import 'package:wonderfood/data/model/food.dart';

class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });
}
