import 'package:flutter/widgets.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(
    this._apiServices,
  );

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  Future<void> fetchRestaurantSearch(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      if (query == "") {
        _resultState = RestaurantSearchNoneState();
      } else {
        final result = await _apiServices.searchRestaurantList(query);

        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
