import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _currentRange = const RangeValues(50, 250);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 19,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: _currentRange,
          min: 0,
          max: 500,
          divisions: 50,
          activeColor:
              isDarkMode
                  ? colorScheme.surfaceTint.withOpacity(0.7)
                  : Color(0xFF432c23),
          inactiveColor:
              isDarkMode
                  ? colorScheme.surfaceTint.withOpacity(0.2)
                  : Color(0xFF432c23).withOpacity(0.2),
          labels: RangeLabels(
            'EGP ${_currentRange.start.toInt()}',
            'EGP ${_currentRange.end.toInt()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRange = values;
            });
          },
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('EGP ${_currentRange.start.toInt()}'),
            Text('EGP ${_currentRange.end.toInt()}'),
          ],
        ),
      ],
    );
  }
}
