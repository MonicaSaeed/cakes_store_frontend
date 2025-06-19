part of 'reviews_cubit.dart';

sealed class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object?> get props => [];
}

final class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

final class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

final class ReviewsLoaded extends ReviewsState {
  final List<ReviewsModel> reviews;
  const ReviewsLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

final class ReviewsError extends ReviewsState {
  final String errorMessage;
  const ReviewsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class ReviewsEmpty extends ReviewsState {
  const ReviewsEmpty();
}
