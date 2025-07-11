import '../../data/models/add_review_model.dart';
import '../../data/models/reviews_model.dart';

abstract class BaseReviewsRepository {
  Future<List<ReviewsModel>> getReviews(String productId);
  Future<String> addReview(AddReviewModel review);
}
