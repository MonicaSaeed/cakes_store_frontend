import '../../data/models/reviews_model.dart';

abstract class BaseReviewsRepository {
  Future<List<ReviewsModel>> getReviews(String productId);
}
