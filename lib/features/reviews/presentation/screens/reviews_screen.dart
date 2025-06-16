import 'package:cakes_store_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/rating_component.dart';
import '../../../../core/theme/theme_colors.dart';
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
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: LightThemeColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child:
                                  review.user.image != null
                                      ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          review.user.image!,
                                        ),
                                        radius: 30.0,
                                        backgroundColor:
                                            LightThemeColors.primary,
                                      )
                                      : const CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor:
                                            LightThemeColors.primary,
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                          color: LightThemeColors.white,
                                        ),
                                      ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.user.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    review.createdAt.toString().formattedDate,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4.0),
                                  RatingComponent(
                                    rating: review.rating,
                                    reviewCount: 0,
                                  ),
                                  const SizedBox(height: 4.0),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      review.comment,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    // return ListTile(
                    //   leading:
                    //       review.user.image != null
                    //           ? CircleAvatar(
                    //             backgroundImage: NetworkImage(
                    //               review.user.image!,
                    //             ),
                    //           )
                    //           : const CircleAvatar(child: Icon(Icons.person)),
                    //   title: Text(review.user.username),
                    //   subtitle: Text(
                    //     ' date ${review.createdAt.toString().formattedDate}\n Rating: ${review.rating}\nComment: ${review.comment}',
                    //     style: const TextStyle(
                    //       fontSize: 14,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // );
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
