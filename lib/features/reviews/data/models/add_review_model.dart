class AddReviewModel {
  final String productId;
  final String userId;
  final double rating;
  final String comment;

  AddReviewModel({
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
  });

  factory AddReviewModel.fromJson(Map<String, dynamic> json) {
    return AddReviewModel(
      productId: json['productId'],
      userId: json['userId'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
    );
  }
}
