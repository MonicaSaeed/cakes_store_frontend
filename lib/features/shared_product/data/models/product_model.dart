import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.category,
    required super.price,
    required super.totalRating,
    required super.discountPercentage,
    required super.updatedAt,
    required super.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      totalRating: (json['totalRating'] as num).toDouble(),
      discountPercentage: json['discountPercentage'],
      updatedAt: json['updatedAt'],
      stock: json['stock'],
    );
  }
  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, category: $category, price: $price, totalRating: $totalRating, discountPercentage: $discountPercentage, updatedAt: $updatedAt, stock: $stock)';
  }
}
