import 'package:cakes_store_frontend/features/reviews/domain/repository/base_reviews_repository.dart';

import '../datasource/reviews_data_source.dart';
import '../models/reviews_model.dart';

class ReviewsRepository extends BaseReviewsRepository {
  final ReviewsDataSource reviewsDataSource;

  ReviewsRepository(this.reviewsDataSource);

  @override
  Future<List<ReviewsModel>> getReviews(String productId) async {
    try {
      return await reviewsDataSource.getReviews(productId);
    } catch (e) {
      throw Exception('Failed to get reviews: $e');
    }
  }
}
