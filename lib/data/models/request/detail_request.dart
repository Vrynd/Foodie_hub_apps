class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<CategoryRestaurant> categories;
  RestaurantMenu menus;
  double rating;
  List<Review> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: List<CategoryRestaurant>.from(
        json["categories"].map((x) => CategoryRestaurant.fromJson(x)),
      ),
      menus: RestaurantMenu.fromJson(json["menus"]),
      rating: json["rating"]?.toDouble(),
      customerReviews: List<Review>.from(
        json["customerReviews"].map((x) => Review.fromJson(x)),
      ),
    );
  }
}

class CategoryRestaurant {
  String name;

  CategoryRestaurant({required this.name});

  factory CategoryRestaurant.fromJson(Map<String, dynamic> json) {
    return CategoryRestaurant(name: json["name"]);
  }
}

class RestaurantMenu {
  List<CategoryRestaurant> foods;
  List<CategoryRestaurant> drinks;

  RestaurantMenu({required this.foods, required this.drinks});

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) {
    return RestaurantMenu(
      foods: List<CategoryRestaurant>.from(
        json["foods"].map((x) => CategoryRestaurant.fromJson(x)),
      ),
      drinks: List<CategoryRestaurant>.from(
        json["drinks"].map((x) => CategoryRestaurant.fromJson(x)),
      ),
    );
  }
}

class Review {
  String name;
  String review;
  String date;

  Review({required this.name, required this.review, required this.date});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json["name"],
      review: json["review"],
      date: json["date"],
    );
  }
}
