enum NavigationRoute {
  homeRoute("/home"),
  detailRoute("/detail"),
  reviewRoute("/review"),
  searchRoute("/search");

  const NavigationRoute(this.name);
  final String name;
}
