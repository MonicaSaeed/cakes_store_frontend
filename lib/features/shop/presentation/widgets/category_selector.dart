import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

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
    const Color brown = Color(0xFF432c23);
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 22),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final bgColor =
              isSelected ? brown.withOpacity(0.1) : Colors.transparent;
          final iconColor = isSelected ? brown : brown.withOpacity(0.6);
          final textColor = isSelected ? brown : Colors.black;

          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: bgColor,
                  child: Icon(
                    _getIcon(categories[index]),
                    color: iconColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  categories[index],
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
