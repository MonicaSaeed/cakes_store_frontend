import 'package:cakes_store_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/rating_component.dart';
import '../../../../core/theme/theme_colors.dart';
import '../../data/models/reviews_model.dart';

class ReviewDetailsScreen extends StatelessWidget {
  final ReviewsModel review;
  const ReviewDetailsScreen({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                        backgroundImage: NetworkImage(review.user.image!),
                        radius: 30.0,
                        backgroundColor: LightThemeColors.primary,
                      )
                      : const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: LightThemeColors.primary,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    review.createdAt.toString().formattedDate,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4.0),
                  RatingComponent(rating: review.rating, reviewCount: 0),
                  const SizedBox(height: 4.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      review.comment,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
