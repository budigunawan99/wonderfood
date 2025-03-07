import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/data/model/restaurant_list_response.dart';
import 'package:wonderfood/provider/home/restaurant_list_provider.dart';
import 'package:wonderfood/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices apiServices;
  late RestaurantListProvider restaurantListProvider;

  final restaurantListSuccessResult = [
    Restaurant(
      id: "rqdv5juczeskfw1e867",
      name: "Melting Pot",
      description: "Melting Pot",
      pictureId: "14",
      city: "Medan",
      rating: 4.2,
    ),
    Restaurant(
      id: "s1knt6za9kkfw1e867",
      name: "Kafe Kita",
      description: "Kafe Kita",
      pictureId: "25",
      city: "Gorontalo",
      rating: 4,
    ),
  ];

  final restaurantListErrorResult =
      "Exception: Gagal untuk menampilkan daftar restoran.";

  setUp(() {
    apiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(apiServices);
  });

  group("Restaurant List Provider", () {
    test('Should return RestaurantListNoneState when provider initialize.', () {
      final initState = restaurantListProvider.resultState;

      expect(initState, equals(RestaurantListNoneState()));
    });

    test(
      'Should return list of restaurant when fetching api is successful.',
      () async {
        when(() => apiServices.getRestaurantList()).thenAnswer(
          (_) async => RestaurantListResponse(
            error: false,
            message: "success",
            count: 2,
            restaurants: restaurantListSuccessResult,
          ),
        );

        await restaurantListProvider.fetchRestaurantList();

        expect(
          restaurantListProvider.resultState,
          isA<RestaurantListLoadedState>(),
        );

        expect(
          (restaurantListProvider.resultState as RestaurantListLoadedState)
              .data,
          isA<List<Restaurant>>(),
        );

        expect(
          (restaurantListProvider.resultState as RestaurantListLoadedState)
              .data,
          restaurantListSuccessResult,
        );
      },
    );

    test('Should return error when fetching api is failed.', () async {
      when(
        () => apiServices.getRestaurantList(),
      ).thenThrow(Exception('Gagal untuk menampilkan daftar restoran.'));

      await restaurantListProvider.fetchRestaurantList();

      expect(
        restaurantListProvider.resultState,
        isA<RestaurantListErrorState>(),
      );

      expect(
        (restaurantListProvider.resultState as RestaurantListErrorState).error,
        isA<String>(),
      );

      expect(
        (restaurantListProvider.resultState as RestaurantListErrorState).error,
        restaurantListErrorResult,
      );
    });
  });
}
