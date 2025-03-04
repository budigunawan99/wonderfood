enum NavigationRoute {
  homeRoute("/home"),
  detailRoute("/detail"),
  reviewRoute("/review"),
  favoriteRoute("/favorite"),
  settingsRoute("/settings"),
  searchRoute("/search");

  const NavigationRoute(this.name);
  final String name;
}
