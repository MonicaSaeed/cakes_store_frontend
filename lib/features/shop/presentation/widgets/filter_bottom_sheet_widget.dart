import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/category_selector.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/interactive_rating.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/price_range_slider.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final String selectedOne;
  final List<String> categories;
  final Map filterbody;
  final void Function(Map<String, dynamic> filterbody)? onItemSelected;
  FilterBottomSheetWidget({
    super.key,
    required this.selectedOne,
    required this.categories,
    required this.onItemSelected,
    required this.filterbody,
  });

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  bool value = false;
  // for the in stock switch
  // var filterbody = {};
  bool isLoading = false;
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();

    _currentRange = RangeValues(
      (widget.filterbody['minPrice'] ?? 50).toDouble(),
      (widget.filterbody['maxPrice'] ?? 250).toDouble(),
    );

    // Also initialize switch state from filterbody
    value = widget.filterbody['inStock'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // RangeValues _currentRange = RangeValues(
    //   widget.filterbody['minPrice']?.toInt() ?? 50,
    //   widget.filterbody['maxPrice']?.toInt() ?? 250,
    // );

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    print('rating');
    print(widget.filterbody['rating']);
    return Container(
      width: double.infinity,
      height: 650,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Products',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      letterSpacing: 2,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color:
                          isDarkMode ? colorScheme.surfaceTint : Colors.black,
                      fontFamily: 'popins',
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color:
                          isDarkMode ? colorScheme.surfaceTint : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 19,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              CategorySelector(
                categories: widget.categories,
                selectedCategory:
                    widget.filterbody['category'] ?? widget.selectedOne,
                // need to think of how to provide it the context of the cubit
                onCategorySelected: (onCategorySelectedindex) {
                  widget.filterbody['category'] =
                      widget.categories[onCategorySelectedindex];
                  // context.read<ProductListCubit>().selectedCategory =
                  //     onCategorySelectedindex;
                },
              ),
              // PriceRangeSlider(),
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
                    widget.filterbody['maxPrice'] = _currentRange.end.toInt();
                    widget.filterbody['minPrice'] = _currentRange.start.toInt();
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'In Stock Only',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 19,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Switch(
                    value: value,
                    onChanged: (onChanged) {
                      setState(() {
                        value = onChanged;
                        widget.filterbody['inStock'] = onChanged;
                        // context.read<ProductListCubit>().inStock = onChanged;
                      });
                    },
                    // activeColor: colorScheme.surfaceTint, // Thumb
                    // activeTrackColor: colorScheme.surfaceTint.withOpacity(
                    //   0.3,
                    // ), // Track
                    // inactiveThumbColor: Color(0xFFA19086),
                    // inactiveTrackColor: Color(0xFF6A524D),
                    activeColor: isDarkMode ? colorScheme.surfaceTint : null,
                    activeTrackColor:
                        isDarkMode
                            ? colorScheme.surfaceTint.withOpacity(0.3)
                            : null,
                    inactiveThumbColor: isDarkMode ? Color(0xFFA19086) : null,
                    inactiveTrackColor: isDarkMode ? Color(0xFF6A524D) : null,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Rating',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 19,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              InteractiveRating(
                initialRating: widget.filterbody['rating'] ?? 0,
                onRatingUpdate: (double1) {
                  widget.filterbody['rating'] = double1;
                  // context.read<ProductListCubit>().selectedRating = double;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        value = false; // Reset the switch
                        widget.filterbody.clear(); // Clear the filter body
                        widget.onItemSelected?.call(
                          widget.filterbody.cast<String, dynamic>(),
                        );
                        Navigator.pop(context);
                        // context.read<ProductListCubit>().resetFilters();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        isLandscape
                            ? MediaQuery.of(context).size.width / 4
                            : MediaQuery.of(context).size.width / 2 - 30,
                        50,
                      ),
                      backgroundColor: Color.fromARGB(255, 197, 195, 195),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Color(0xFF252c39)),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        isLandscape
                            ? MediaQuery.of(context).size.width / 4
                            : MediaQuery.of(context).size.width / 2 - 30,
                        50,
                      ),
                    ),
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              setState(() {
                                isLoading = true;
                              });

                              await Future.delayed(
                                const Duration(milliseconds: 100),
                              );
                              print("filter body");
                              print(widget.filterbody.cast<String, dynamic>());
                              widget.onItemSelected?.call(
                                widget.filterbody.cast<String, dynamic>(),
                              );

                              if (mounted) {
                                Navigator.pop(context);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            },
                    child:
                        isLoading
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                            : const Text('Apply Filters'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
