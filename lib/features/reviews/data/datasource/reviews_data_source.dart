import 'dart:convert';

import 'package:cakes_store_frontend/features/reviews/data/models/add_review_model.dart';
import 'package:cakes_store_frontend/features/reviews/data/models/reviews_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';

class ReviewsDataSource {
  Future<List<ReviewsModel>> getReviews(String productId) async {
    final response = await http.get(
      Uri.parse('${ApiConstance.reviewsUrl}/product-review/$productId'),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<ReviewsModel>.from(
        (decoded['data'] as List).map((e) => ReviewsModel.fromJson(e)),
      );
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to get reviews from datasource');
    }
  }

  Future<String> addReview(AddReviewModel review) async {
    final response = await http.post(
      Uri.parse(ApiConstance.reviewsUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': review.userId,
        'productId': review.productId,
        'rating': review.rating,
        'comment': review.comment,
      }),
    );

    if (response.statusCode == 200) {
      return 'Review added successfully';
    } else if (response.statusCode == 500) {
      throw Exception('Server error while adding review');
    } else {
      throw Exception('Failed to add review: ${response.body}');
    }
  }
}
