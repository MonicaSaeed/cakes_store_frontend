import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InteractiveRating extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingUpdate;

  const InteractiveRating({
    super.key,
    required this.initialRating,
    required this.onRatingUpdate,
  });

  @override
  State<InteractiveRating> createState() => _InteractiveRatingState();
}

class _InteractiveRatingState extends State<InteractiveRating> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    return RatingBar.builder(
      initialRating: _rating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemSize: 30,
      unratedColor:
          isDarkMode
              ? colorScheme.surfaceTint.withOpacity(0.5)
              : Colors.grey.shade300,
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
        widget.onRatingUpdate(rating);
      },
    );
  }
}
