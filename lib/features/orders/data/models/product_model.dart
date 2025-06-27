
import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.category,
    required super.price,
    required super.totalRating,
    required super.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ProductModel(
      id: data['_id'],
      name: data['name'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      category: data['category'],
      price: (data['price'] as num).toDouble(),
      totalRating: (data['totalRating'] as num).toInt(),
      discountPercentage: (data['discountPercentage'] as num).toInt(),
    );
  }
  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, category: $category, price: $price, totalRating: $totalRating, discountPercentage: $discountPercentage)';
  }
}
