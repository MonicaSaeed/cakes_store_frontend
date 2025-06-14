class ReviewsModel {
  final String productId;
  final String userId;
  final double rating;
  final String comment;

  ReviewsModel({
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      productId: json['productId'],
      userId: json['userId'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
    };
  }

  ReviewsModel copyWith({
    String? productId,
    String? userId,
    double? rating,
    String? comment,
  }) {
    return ReviewsModel(
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }
}
