import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../reviews/presentation/cubit/reviews_cubit.dart';
import '../components/review_details_screen.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        switch (state) {
          case ReviewsLoading():
            return const Center(child: CircularProgressIndicator());
          case ReviewsLoaded():
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.reviews.length,
              itemBuilder: (context, index) {
                final review = state.reviews[index];
                return ReviewDetailsScreen(review: review);
              },
            );
          case ReviewsEmpty():
            return const Center(
              child: Text('No reviews available for this product.'),
            );
          case ReviewsError():
            return Text('Error loading reviews: ${state.errorMessage}');
          default:
            return const Text('Loading reviews...');
        }
      },
    );
  }
}
