import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/category_selector.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/filter_bottom_sheet_widget.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/interactive_rating.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/price_range_slider.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopProductScreen extends StatelessWidget {
  const ShopProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print('products $products');
    return BlocProvider(
      create: (context) => ProductListCubit()..getProductList(),
      child: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Center(child: const Text('Shop Now'))),
            body: Builder(
              builder: (context) {
                switch (state) {
                  case ProductListLoading():
                    return const Center(child: CircularProgressIndicator());
                  case ProductListLoaded():
                    final categories =
                        context.read<ProductListCubit>().categories;
                    final products = state.products;
                    final filters =
                        context.read<ProductListCubit>().filtersOptions;
                    int selectedCategory =
                        context.read<ProductListCubit>().selectedCategory;
                    int selectedFilterSort =
                        context.read<ProductListCubit>().selectedfilter;
                    return Column(
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,

                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProductListCubit>()
                                        .selectedCategory = index;
                                  },
                                  child: Material(
                                    elevation: 2, // Controls shadow intensity
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    child: RawChip(
                                      label: Text(
                                        categories[index],
                                        style: TextStyle(
                                          color:
                                              selectedCategory == index
                                                  ? Colors.white
                                                  : Color(0xFF252c39),
                                          letterSpacing: 2,
                                          fontSize: 16,
                                        ),
                                      ),
                                      side:
                                          BorderSide
                                              .none, // This ensures MaterialState outline is removed

                                      backgroundColor:
                                          selectedCategory == index
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                              : const Color.fromARGB(
                                                255,
                                                197,
                                                195,
                                                195,
                                              ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side:
                                            BorderSide
                                                .none, // ✅ Explicit no border
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      elevation: 0, // ✅ No shadow outline
                                      pressElevation: 0,
                                      shadowColor: Colors.transparent,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 8);
                              },
                              itemCount: categories.length,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 2),
                                  GestureDetector(
                                    onTap: () {
                                      filterBottomSheet(
                                        context,
                                        categories,
                                        selectedCategory,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.filter_alt, size: 30),
                                        SizedBox(width: 8),
                                        Text(
                                          'Filter',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            letterSpacing: 2,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${products.length} products',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontSize: 17,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {
                                      showSortBottomSheetDialog(
                                        context,
                                        selectedFilterSort,
                                        filters,
                                        (selectedIndex) {
                                          selectedFilterSort = selectedIndex;
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.sort_sharp,
                                          size: 30,
                                          color: LightThemeColors.textDark,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Sort',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            letterSpacing: 2,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 4),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Divider(
                        //   thickness: 1,
                        //   color: Colors.grey, // Line thickness
                        // ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1,
                                    childAspectRatio: .5,
                                    maxCrossAxisExtent:
                                        300, // Maximum width of each grid tile
                                  ),
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return CustomCard(
                                  cardtitle: product.name!,
                                  price: '${product.price}',
                                  rating: product.totalRating!,
                                  imageUrl: product.imageUrl!,
                                  favicon: Icons.favorite_border,
                                  addcartIcon: Icons.shopping_cart_outlined,
                                );
                              },

                              itemCount: products.length,
                            ),
                          ),
                        ),
                      ],
                    );
                  case ProductListError():
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              'Error loading the data',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('Please try again later'),
                        ],
                      ),
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> filterBottomSheet(
    BuildContext context,
    List<String> categories,
    int selectedCategory,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // <-- this is required!

      builder: (context) {
        return FilterBottomSheetWidget(
          selectedOne: selectedCategory,
          categories: categories,
          onItemSelected: (int index) {},
        );
      },
    );
  }

  Future<void> showSortBottomSheetDialog(
    BuildContext context,
    int selectedFilterSort,
    List<String> filters,
    void Function(int) onItemSelected,
  ) {
    return showModalBottomSheet(
      context: context,
      builder:
          (context) => SortBottomSheet(
            selectedFilterSort: selectedFilterSort,
            filters: filters,
            onItemSelected: onItemSelected,
          ),
    );
  }
}
