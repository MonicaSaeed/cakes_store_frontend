import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/add_review_model.dart';
import '../../data/models/reviews_model.dart';
import '../../domain/repository/base_reviews_repository.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());
  getReviews(String productId) async {
    try {
      emit(ReviewsLoading());
      List<ReviewsModel> reviews = await sl<BaseReviewsRepository>().getReviews(
        productId,
      );
      if (reviews == null || reviews.isEmpty) {
        emit(ReviewsEmpty());
      } else {
        emit(ReviewsLoaded(reviews));
      }
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }

  addReview(AddReviewModel review) async {
    try {
      emit(ReviewAddLoading());
      String message = await sl<BaseReviewsRepository>().addReview(review);
      emit(ReviewAdded(message));
      // refresh the reviews after adding a new one
      await getReviews(review.productId);
    } catch (e) {
      emit(ReviewAddError(e.toString()));
    }
  }
}
