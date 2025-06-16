import 'package:cakes_store_frontend/features/reviews/data/models/user_reviews_data_model.dart';

class ReviewsModel {
  final String productId;
  final UserReviewsDataModel user;
  final double rating;
  final String comment;
  final DateTime createdAt;

  ReviewsModel({
    required this.productId,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      productId: json['productId'],
      user: UserReviewsDataModel.fromJson(json['userId']),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
