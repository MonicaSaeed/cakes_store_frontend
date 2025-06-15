import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/category_selector.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/filter_bottom_sheet_widget.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/interactive_rating.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/price_range_slider.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/sort_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class ShopProductScreen extends StatelessWidget {
//   const ShopProductScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double itemWidth = screenWidth / 2; // لو عدد الأعمدة 2 مثلاً
//     double itemHeight = itemWidth / 0.6; // أو حسب المطلوب
//     // print('products $products');
//     return BlocProvider(
//       create: (context) => ProductListCubit()..getfilteredProductList(),
//       child: BlocBuilder<ProductListCubit, ProductListState>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(title: Center(child: const Text('Shop Now'))),
//             body: Builder(
//               builder: (context) {
//                 switch (state) {
//                   case ProductListLoading():
//                     return const Center(child: CircularProgressIndicator());
//                   case ProductListLoaded():
//                     final categories =
//                         context.read<ProductListCubit>().categories;
//                     final products = state.products;
//                     final filters =
//                         context.read<ProductListCubit>().filterSortOptions;
//                     int selectedCategory =
//                         context.read<ProductListCubit>().selectedCategory;
//                     int selectedFilterSort =
//                         context.read<ProductListCubit>().selectedSortfilter;
//                     return Column(
//                       children: [
//                         SizedBox(height: 20),
//                         SizedBox(
//                           height: 50,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                             ),
//                             child: ListView.separated(
//                               scrollDirection: Axis.horizontal,

//                               itemBuilder: (context, index) {
//                                 final selected =
//                                     context
//                                         .read<ProductListCubit>()
//                                         .filterbody['category'] ??
//                                     "All Items";
//                                 return GestureDetector(
//                                   onTap: () {
//                                     if (index == 0) {
//                                       context
//                                           .read<ProductListCubit>()
//                                           .filterbody
//                                           .remove('category');
//                                     } else {
//                                       context
//                                           .read<ProductListCubit>()
//                                           .selectedCategory = index;
//                                       context
//                                               .read<ProductListCubit>()
//                                               .filterbody['category'] =
//                                           categories[index];
//                                     }
//                                     context
//                                         .read<ProductListCubit>()
//                                         .getfilteredProductList();
//                                   },
//                                   child: Material(
//                                     elevation: 2, // Controls shadow intensity
//                                     shadowColor: Colors.black.withOpacity(0.5),
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: RawChip(
//                                       label: Text(
//                                         categories[index],
//                                         style: TextStyle(
//                                           color:
//                                               selected == categories[index]
//                                                   ? Colors.white
//                                                   : Color(0xFF252c39),
//                                           letterSpacing: 2,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       side:
//                                           BorderSide
//                                               .none, // This ensures MaterialState outline is removed

//                                       backgroundColor:
//                                           selected == categories[index]
//                                               ? Theme.of(
//                                                 context,
//                                               ).colorScheme.primary
//                                               : const Color.fromARGB(
//                                                 255,
//                                                 197,
//                                                 195,
//                                                 195,
//                                               ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         side:
//                                             BorderSide
//                                                 .none, // ✅ Explicit no border
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 15,
//                                         vertical: 10,
//                                       ),
//                                       elevation: 0, // ✅ No shadow outline
//                                       pressElevation: 0,
//                                       shadowColor: Colors.transparent,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               separatorBuilder: (context, index) {
//                                 return SizedBox(width: 8);
//                               },
//                               itemCount: categories.length,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(22),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 8,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Row(
//                                 children: [
//                                   SizedBox(width: 2),
//                                   GestureDetector(
//                                     onTap: () {
//                                       filterBottomSheet(
//                                         context,
//                                         categories,
//                                         context
//                                                 .read<ProductListCubit>()
//                                                 .filterbody['category'] ??
//                                             "All Items",
//                                         (filterbody1) {
//                                           context
//                                               .read<ProductListCubit>()
//                                               .filterbody = filterbody1;
//                                           context
//                                               .read<ProductListCubit>()
//                                               .getfilteredProductList();
//                                         },
//                                       );
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.filter_alt, size: 30),
//                                         SizedBox(width: 8),
//                                         Text(
//                                           'Filter',
//                                           style: Theme.of(
//                                             context,
//                                           ).textTheme.bodyLarge?.copyWith(
//                                             letterSpacing: 2,
//                                             fontSize: 17,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     '${products.length} products',
//                                     style: Theme.of(
//                                       context,
//                                     ).textTheme.bodyMedium?.copyWith(
//                                       fontSize: 17,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   SizedBox(width: 16),
//                                   GestureDetector(
//                                     onTap: () {
//                                       showSortBottomSheetDialog(
//                                         context,
//                                         selectedFilterSort,
//                                         filters,
//                                         (selectedIndex) {
//                                           context
//                                                   .read<ProductListCubit>()
//                                                   .selectedSortfilter =
//                                               selectedIndex;
//                                           context
//                                                   .read<ProductListCubit>()
//                                                   .filterbody['sortOption'] =
//                                               filters[selectedIndex];
//                                           context
//                                               .read<ProductListCubit>()
//                                               .getfilteredProductList();
//                                         },
//                                       );
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.sort_sharp,
//                                           size: 30,
//                                           color: LightThemeColors.textDark,
//                                         ),
//                                         SizedBox(width: 4),
//                                         Text(
//                                           'Sort',
//                                           style: Theme.of(
//                                             context,
//                                           ).textTheme.bodyLarge?.copyWith(
//                                             letterSpacing: 2,
//                                             fontSize: 17,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),

//                                   SizedBox(width: 4),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Divider(
//                         //   thickness: 1,
//                         //   color: Colors.grey, // Line thickness
//                         // ),
//                         SizedBox(height: 10),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 10,
//                                     mainAxisSpacing: 20,
//                                     childAspectRatio: itemWidth / itemHeight,
//                                   ), // const SliverGridDelegateWithMaxCrossAxisExtent(
//                               //   mainAxisSpacing: 1,
//                               //   crossAxisSpacing: 1,
//                               //   childAspectRatio: .5,
//                               //   maxCrossAxisExtent:
//                               //       300, // Maximum width of each grid tile
//                               // ),
//                               itemBuilder: (context, index) {
//                                 final product = products[index];
//                                 return CustomCard(
//                                   cardtitle: product.name!,
//                                   price: '${product.price}',
//                                   rating: product.totalRating!,
//                                   imageUrl: product.imageUrl!,
//                                   favicon: Icons.favorite_border,
//                                   addcartIcon: Icons.shopping_cart_outlined,
//                                 );
//                               },

//                               itemCount: products.length,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   case ProductListError():
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.error, size: 64, color: Colors.red),
//                           const SizedBox(height: 16),
//                           Align(
//                             alignment: Alignment.topCenter,
//                             child: const Text(
//                               'Error loading the data',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text('Please try again later'),
//                         ],
//                       ),
//                     );
//                   case ProductListInitial():
//                     return Container();
//                   default:
//                     return SizedBox.shrink();
//                 }
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<dynamic> filterBottomSheet(
//     BuildContext context,
//     List<String> categories,
//     String selectedCategory,
//     final void Function(Map<String, dynamic> filterbody)? onItemSelected,
//   ) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // <-- this is required!

//       builder: (context) {
//         return FilterBottomSheetWidget(
//           selectedOne: selectedCategory,
//           categories: categories,
//           onItemSelected: onItemSelected,
//         );
//       },
//     );
//   }

//   Future<void> showSortBottomSheetDialog(
//     BuildContext context,
//     int selectedFilterSort,
//     List<String> filters,
//     void Function(int) onItemSelected,
//   ) {
//     return showModalBottomSheet(
//       context: context,
//       builder:
//           (context) => SortBottomSheet(
//             selectedFilterSort: selectedFilterSort,
//             filters: filters,
//             onItemSelected: onItemSelected,
//           ),
//     );
//   }
// }

class ShopProductScreen extends StatelessWidget {
  const ShopProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ProductListCubit(
            userId: context.read<AuthCubit>().currentUser?.uid,
          )..getfilteredProductList(),
      child: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Shop Now'))),
        body: Column(
          children: [
            // Fixed controls section - only rebuilds when categories/filters change
            const _FixedControlsSection(),

            // Products grid section - rebuilds when products change
            const Expanded(child: _ProductsGridSection()),
          ],
        ),
      ),
    );
  }
}

class _FixedControlsSection extends StatelessWidget {
  const _FixedControlsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      buildWhen: (previous, current) {
        // Only rebuild when categories or filter options change
        return current is ProductListLoaded &&
            (previous is! ProductListLoaded ||
                previous.categories != current.categories ||
                previous.filterSortOptions != current.filterSortOptions);
      },
      builder: (context, state) {
        if (state is! ProductListLoaded) return const SizedBox.shrink();

        final cubit = context.read<ProductListCubit>();
        final categories = cubit.categories;
        final filters = cubit.filterSortOptions;
        final selectedCategory = cubit.filterbody['category'] ?? "All Items";

        return Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          cubit.filterbody.remove('category');
                        } else {
                          cubit.filterbody['category'] = categories[index];
                        }
                        cubit.getfilteredProductList();
                      },
                      child: Material(
                        elevation: 2,
                        shadowColor: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        child: RawChip(
                          label: Text(
                            categories[index],
                            style: TextStyle(
                              color:
                                  selectedCategory == categories[index]
                                      ? Colors.white
                                      : const Color(0xFF252c39),
                              fontSize: 16,
                            ),
                          ),
                          side: BorderSide.none,
                          backgroundColor:
                              selectedCategory == categories[index]
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromARGB(255, 197, 195, 195),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide.none,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 8),
                  itemCount: categories.length,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () => _showFilterBottomSheet(context, cubit),
                        child: const Row(
                          children: [
                            Icon(Icons.filter_alt, size: 30),
                            SizedBox(width: 8),
                            Text('Filter'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      BlocSelector<ProductListCubit, ProductListState, int>(
                        selector:
                            (state) =>
                                state is ProductListLoaded
                                    ? state.products.length
                                    : 0,
                        builder: (context, count) {
                          return Text('$count products');
                        },
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => _showSortBottomSheet(context, cubit),
                        child: const Row(
                          children: [
                            Icon(Icons.sort_sharp, size: 30),
                            SizedBox(width: 4),
                            Text('Sort'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context, ProductListCubit cubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FilterBottomSheetWidget(
          selectedOne: cubit.filterbody['category'] ?? "All Items",
          categories: cubit.categories,
          onItemSelected: (filterbody1) {
            cubit.filterbody = filterbody1;
            cubit.getfilteredProductList();
          },
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context, ProductListCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SortBottomSheet(
          selectedFilterSort: cubit.selectedSortfilter,
          filters: cubit.filterSortOptions,
          onItemSelected: (selectedIndex) {
            cubit.selectedSortfilter = selectedIndex;
            cubit.filterbody['sortOption'] =
                cubit.filterSortOptions[selectedIndex];
            cubit.getfilteredProductList();
          },
        );
      },
    );
  }
}

class _ProductsGridSection extends StatelessWidget {
  const _ProductsGridSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      buildWhen: (previous, current) {
        // Only rebuild when products actually change
        return current is ProductListLoaded &&
            (previous is! ProductListLoaded ||
                !listEquals(previous.products, current.products));
      },
      builder: (context, state) {
        if (state is ProductListLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductListError) {
          return const Center(
            child: Icon(Icons.error, size: 64, color: Colors.red),
          );
        }
        if (state is! ProductListLoaded) return const SizedBox.shrink();

        final screenWidth = MediaQuery.of(context).size.width;
        final itemWidth = screenWidth / 2;
        final itemHeight = itemWidth / 0.6;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return CustomCard(
                cardtitle: product.name!,
                price: '${product.price}',
                rating: product.totalRating!,
                imageUrl: product.imageUrl!,
                favicon: Icons.favorite_border,
                addcartIcon: Icons.shopping_cart_outlined,
                onPressedFav: () {
                  context.read<ProductListCubit>().toggleFavorite(
                    productId: product.id!,
                  );
                },
              );
            },
            itemCount: state.products.length,
          ),
        );
      },
    );
  }
}
