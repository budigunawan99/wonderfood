import 'package:wonderfood/data/model/drink.dart';
import 'package:wonderfood/data/model/food.dart';
import 'package:wonderfood/data/model/menu.dart';
import 'package:wonderfood/data/model/review.dart';
import 'package:wonderfood/data/model/restaurant_category.dart';

class Restaurant {
  final int id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String? address;
  final List<RestaurantCategory>? categories;
  final Menu? menus;
  final List<Review>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews,
  });
}

final List<Restaurant> restaurantList = [
  Restaurant(
    id: 1,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
  Restaurant(
    id: 2,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
  Restaurant(
    id: 3,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
  Restaurant(
    id: 4,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
  Restaurant(
    id: 5,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
  Restaurant(
    id: 6,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
  Restaurant(
    id: 7,
    name: 'TN Kelimutu',
    description:
        'Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).',
    address: 'Detusoko, Kabupaten Ende, NTT',
    pictureId:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg',
    city: 'Medan',
    rating: 4,
    categories: [
      RestaurantCategory(
        name: "italia",
      ),
      RestaurantCategory(
        name: "modern",
      ),
    ],
    menus: Menu(
      foods: [
        Food(name: "Paket rosemary"),
        Food(name: "Salmon"),
      ],
      drinks: [
        Drink(name: "Sirup"),
        Drink(name: "Es krim"),
      ],
    ),
    customerReviews: [
      Review(
        name: "Ahmad",
        review: "Enak sekali",
        date: "13 November 2019",
      ),
      Review(
        name: "Dhani",
        review: "Tidak Enak",
        date: "12 November 2018",
      ),
    ],
  ),
];
