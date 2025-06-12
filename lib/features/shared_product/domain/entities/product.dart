import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final String price;
  final String totalRating;
  final String discountPercentage;
  final String updatedAt;
  final String stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.totalRating,
    required this.discountPercentage,
    required this.updatedAt,
    required this.stock,
  });
}
