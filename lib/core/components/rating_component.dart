import 'package:flutter/material.dart';

class RatingComponent extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingComponent({
    Key? key,
    required this.rating,
    required this.reviewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    return Row(
      children: [
        ...List.generate(
          fullStars,
          (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
        ),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.amber, size: 20),
        if (fullStars + (hasHalfStar ? 1 : 0) < 5)
          ...List.generate(
            5 - fullStars - (hasHalfStar ? 1 : 0),
            (index) =>
                const Icon(Icons.star_border, color: Colors.amber, size: 20),
          ),
        const SizedBox(width: 6),
        reviewCount > 0
            ? Text(
              '$rating ($reviewCount reviews)',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? colorScheme.surfaceTint : Colors.black87,
              ),
            )
            : Text(''),
      ],
    );
  }
}
