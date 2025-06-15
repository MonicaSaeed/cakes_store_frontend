import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/reviews_cubit.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (_) => ReviewsCubit()..getReviews(productId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Reviews')),
        body: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            switch (state) {
              case ReviewsLoading():
                return const Center(child: CircularProgressIndicator());

              case ReviewsLoaded():
                return ListView.builder(
                  itemCount: state.reviews.length,
                  itemBuilder: (context, index) {
                    final review = state.reviews[index];
                    return ListTile(
                      leading: Text(review.rating.toString()),
                      title: Text(review.comment),
                      subtitle: Text('User ID: ${review.userId}'),
                    );
                  },
                );

              case ReviewsEmpty():
                return const Center(child: Text('No reviews found.'));

              case ReviewsError():
                return Center(child: Text('Error: ${state.errorMessage}'));

              default:
                return const Center(child: Text('Please wait...'));
            }
          },
        ),
      ),
    );
  }
}
