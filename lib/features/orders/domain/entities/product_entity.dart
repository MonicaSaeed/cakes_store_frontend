class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String category;
  final double price;
  final int? totalRating;
  final int? discountPercentage;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.totalRating,
    required this.discountPercentage,
  });
}
