import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/model/restaurant_review_request.dart';
import 'package:wonderfood/provider/review/restaurant_review_provider.dart';
import 'package:wonderfood/screen/common/rounded_sliver_app_bar.dart';
import 'package:wonderfood/static/restaurant_review_result_state.dart';

class ReviewScreen extends StatefulWidget {
  final String restaurantId;

  const ReviewScreen({super.key, required this.restaurantId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String _name = "";
  String _review = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RoundedSliverAppBar(
            isFirstPage: false,
            title: "Review Restoran",
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  counterStyle: Theme.of(context).textTheme.labelSmall,
                  border: InputBorder.none,
                  hintText: 'Ketik Nama Anda',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: null,
                maxLength: 20,
                onChanged: (value) {
                  _name = value;
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  counterStyle: Theme.of(context).textTheme.labelSmall,
                  border: InputBorder.none,
                  hintText: 'Ketik Review Anda',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: null,
                maxLength: 50,
                onChanged: (value) {
                  _review = value;
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Consumer<RestaurantReviewProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantReviewLoadingState() => TextButton(
                        onPressed: null,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(),
                            ),
                            const SizedBox.square(dimension: 8),
                            Text(
                              'Loading ...',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    RestaurantReviewErrorState(error: var message) => Builder(
                        builder: (context) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                              value.setResultState(RestaurantReviewNoneState());
                            },
                          );
                          return TextButton(
                            onPressed: () {
                              if (_name == "" || _review == "") {
                                return;
                              }
                              value.postRestaurantReview(
                                RestaurantReviewRequest(
                                  id: widget.restaurantId,
                                  name: _name,
                                  review: _review,
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                                bottom: 10,
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              'Done',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          );
                        },
                      ),
                    RestaurantReviewLoadedState(data: var restaurantReview) =>
                      Builder(
                        builder: (context) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Review Anda sudah diterima',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(
                                              context, restaurantReview);
                                        },
                                        child: Text(
                                          'OK',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              value.setResultState(RestaurantReviewNoneState());
                            },
                          );
                          return SizedBox();
                        },
                      ),
                    _ => TextButton(
                        onPressed: () {
                          if (_name == "" || _review == "") {
                            return;
                          }
                          value.postRestaurantReview(
                            RestaurantReviewRequest(
                              id: widget.restaurantId,
                              name: _name,
                              review: _review,
                            ),
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
                          'Done',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                  };
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
