import 'package:flutter/material.dart';

class RatingBarWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double size;
  final Color color;

  const RatingBarWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.size = 20.0,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            if (rating >= index + 1) {
              return Icon(Icons.star, color: color, size: size);
            } else if (rating > index && rating < index + 1) {
              return Icon(Icons.star_half, color: color, size: size);
            } else {
              return Icon(Icons.star_border, color: color, size: size);
            }
          }),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: TextStyle(
            fontSize: size * 0.7,
            color: isDarkMode ? colorScheme.surfaceTint : Colors.black54,
          ),
        ),
      ],
    );
  }
}
