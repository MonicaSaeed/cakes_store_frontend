import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/category_selector.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/interactive_rating.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/price_range_slider.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetWidget extends StatelessWidget {
  final int selectedOne;
  final List<String> categories;
  final void Function(int index)? onItemSelected;
  FilterBottomSheetWidget({
    super.key,
    required this.selectedOne,
    required this.categories,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 650,
      decoration: BoxDecoration(
        color: Colors.white,
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
                      color: Colors.black,
                      fontFamily: 'popins',
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black),
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
                categories: categories,
                selectedIndex: selectedOne,
                // need to think of how to provide it the context of the cubit
                onCategorySelected: (onCategorySelectedindex) {
                  // context.read<ProductListCubit>().selectedCategory =
                  //     onCategorySelectedindex;
                },
              ),
              PriceRangeSlider(),
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
                  Switch(value: true, onChanged: (onChanged) {}),
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
              InteractiveRating(onRatingUpdate: (double) {}),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        MediaQuery.of(context).size.width / 2 - 30,
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
                        MediaQuery.of(context).size.width / 2 - 30,
                        50,
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Apply Filters'),
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
