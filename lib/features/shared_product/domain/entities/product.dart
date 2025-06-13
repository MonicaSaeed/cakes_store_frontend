class Product {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? category;
  final double? price; // updated
  final double? totalRating; // updated
  final int? discountPercentage;
  final String? updatedAt;
  final int? stock;

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
