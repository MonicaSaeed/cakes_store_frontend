import 'dart:convert';

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
}
