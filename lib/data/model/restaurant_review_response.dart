import 'package:wonderfood/data/model/review.dart';

class RestaurantReviewResponse {
  final bool error;
  final String message;
  final List<Review> customerReviews;

  RestaurantReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantReviewResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantReviewResponse(
      error: json["error"],
      message: json["message"],
      customerReviews: json["customerReviews"] != null
          ? List<Review>.from(
              json["customerReviews"].map((x) => Review.fromJson(x)))
          : <Review>[],
    );
  }
}
