import 'package:flutter/widgets.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/model/restaurant_review_request.dart';
import 'package:wonderfood/static/restaurant_review_result_state.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantReviewProvider(
    this._apiServices,
  );

  RestaurantReviewResultState _resultState = RestaurantReviewNoneState();

  RestaurantReviewResultState get resultState => _resultState;

  void setResultState(RestaurantReviewResultState value) {
    _resultState = value;
    notifyListeners();
  }

  Future<void> postRestaurantReview(RestaurantReviewRequest review) async {
    try {
      _resultState = RestaurantReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.postRestaurantReview(review);

      if (result.error) {
        _resultState = RestaurantReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}
