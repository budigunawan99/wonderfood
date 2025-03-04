sealed class FavoriteActionState {}

class FavoriteActionNoneState extends FavoriteActionState {}

class FavoriteActionLoadingState extends FavoriteActionState {}

class FavoriteActionErrorState extends FavoriteActionState {
  final String error;

  FavoriteActionErrorState(this.error);
}

class FavoriteActionLoadedState extends FavoriteActionState {
  final String message;

  FavoriteActionLoadedState(this.message);
}
