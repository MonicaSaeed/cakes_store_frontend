import 'package:flutter/material.dart';

class SortBottomSheet extends StatelessWidget {
  final int selectedFilterSort;
  final List<String> filters;
  final void Function(int index)? onItemSelected;

  const SortBottomSheet({
    super.key,
    required this.selectedFilterSort,
    required this.filters,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: isDarkMode ? colorScheme.primary : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort By',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    letterSpacing: 2,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: isDarkMode ? colorScheme.surfaceTint : Colors.black,
                    fontFamily: 'popins',
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? colorScheme.surfaceTint : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Filter Options
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final isSelected = selectedFilterSort == index;
                    return GestureDetector(
                      onTap: () {
                        onItemSelected?.call(index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? isDarkMode
                                      ? Colors.white
                                      : const Color.fromARGB(255, 249, 233, 227)
                                  : isDarkMode
                                  ? Color.fromARGB(255, 249, 233, 227)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            isSelected
                                ? const Icon(Icons.check_outlined)
                                : const SizedBox(width: 22),
                            const SizedBox(width: 10),
                            Text(
                              filters[index],
                              style: Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(
                                letterSpacing: 2,
                                fontSize: 20,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                color:
                                    isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
