enum NavigationRoute {
  homeRoute("/home"),
  detailRoute("/detail"),
  reviewRoute("/review"),
  favoriteRoute("/favorite"),
  searchRoute("/search");

  const NavigationRoute(this.name);
  final String name;
}
