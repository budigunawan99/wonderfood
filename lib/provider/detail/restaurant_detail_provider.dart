import 'package:flutter/widgets.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/model/review.dart';
import 'package:wonderfood/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  List<Review> _customerReviews = [];

  List<Review> get customerReviews => _customerReviews;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        _customerReviews = result.restaurant.customerReviews ?? [];
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }

  void setCustomerReviews(List<Review> reviews) {
    _customerReviews = reviews;
    notifyListeners();
  }
}
