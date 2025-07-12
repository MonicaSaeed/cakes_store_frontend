import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  String selectedCategory;
  final Function(int) onCategorySelected;

  CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  // You can map your categories to icons here
  IconData _getIcon(String category) {
    switch (category) {
      case 'All Items':
        return Icons.category;
      case 'Birthday':
        return Icons.cake;
      case 'Wedding':
        return Icons.card_giftcard_outlined;
      case 'Custom':
        return Icons.design_services;
      case 'Cheesecakes':
        return Icons.cake_rounded;
      case 'Cupcakes':
        return Icons.cookie;
      case 'Molten Cakes':
        return Icons.fluorescent_rounded;
      default:
        return Icons.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    const Color brown = Color(0xFF432c23);
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 22),
        itemBuilder: (context, index) {
          final isSelected =
              widget.categories[index] == widget.selectedCategory;
          final bgColor =
              isSelected
                  ? isDarkMode
                      ? colorScheme.surfaceTint
                      : brown.withOpacity(0.1)
                  : Colors.transparent;
          final iconColor =
              isSelected
                  ? brown
                  : isDarkMode
                  ? colorScheme.surfaceTint.withOpacity(0.5)
                  : brown.withOpacity(0.6);
          final textColor =
              isSelected
                  ? isDarkMode
                      ? colorScheme.surfaceTint
                      : brown
                  : isDarkMode
                  ? colorScheme.surfaceTint.withOpacity(0.6)
                  : Colors.black;

          return GestureDetector(
            onTap:
                () => {
                  setState(() {
                    widget.selectedCategory = widget.categories[index];
                    widget.onCategorySelected(index);
                  }),
                },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: bgColor,
                  child: Icon(
                    _getIcon(widget.categories[index]),
                    color: iconColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.categories[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
