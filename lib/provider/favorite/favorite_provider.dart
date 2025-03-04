import 'package:flutter/widgets.dart';
import 'package:wonderfood/data/local/local_database_service.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/static/favorite_action_state.dart';
import 'package:wonderfood/static/favorite_list_result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  FavoriteProvider(this._service);

  FavoriteListResultState _resultState = FavoriteListNoneState();
  FavoriteListResultState get resultState => _resultState;

  FavoriteActionState _actionResultState = FavoriteActionNoneState();
  FavoriteActionState get actionResultState => _actionResultState;

  void setActionResultState(FavoriteActionState value) {
    _actionResultState = value;
    notifyListeners();
  }

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> getAllRestaurants() async {
    try {
      _resultState = FavoriteListLoadingState();
      notifyListeners();

      final result = await _service.getAllItems();
      _restaurant = null;
      if (result.isEmpty) {
        _resultState = FavoriteListNoneState();
        notifyListeners();
      } else {
        _resultState = FavoriteListLoadedState(result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = FavoriteListErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    try {
      _actionResultState = FavoriteActionLoadingState();
      notifyListeners();

      final result = await _service.insertItem(restaurant);
      final isError = result == 0;

      if (isError) {
        _actionResultState = FavoriteActionErrorState(
          "Yahh, data anda gagal tersimpan!",
        );
        notifyListeners();
      } else {
        _actionResultState = FavoriteActionLoadedState(
          "Yeayy, data anda berhasil disimpan!",
        );
        notifyListeners();
      }
    } on Exception catch (e) {
      _actionResultState = FavoriteActionErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      _actionResultState = FavoriteActionLoadingState();
      notifyListeners();

      await _service.removeItem(id);
      _restaurant = null;

      _actionResultState = FavoriteActionLoadedState(
        "Yeay, data anda berhasil dihapus!",
      );
      notifyListeners();
    } on Exception catch (e) {
      _actionResultState = FavoriteActionErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> getRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      notifyListeners();
    } on Exception catch (e) {
      _actionResultState = FavoriteActionErrorState(e.toString());
      notifyListeners();
    }
  }

  bool checkItemFavorite(String id) {
    final isSameRestaurant =
        _restaurant == null ? false : _restaurant!.id == id;
    return isSameRestaurant;
  }
}
