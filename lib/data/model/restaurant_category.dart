class RestaurantCategory {
  final String name;

  RestaurantCategory({required this.name});

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) {
    return RestaurantCategory(name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"name": name};
}
