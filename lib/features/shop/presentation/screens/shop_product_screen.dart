import 'package:cakes_store_frontend/core/components/custom_card.dart';

import 'package:cakes_store_frontend/features/auth/domain/auth_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/filter_bottom_sheet_widget.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/paginated_product_list.dart';
import 'package:cakes_store_frontend/features/shop/presentation/widgets/sort_bottom_sheet.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopProductScreen extends StatelessWidget {
  const ShopProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = ProductListCubit(
              userId: context.read<UserCubit>().currentUser?.id,
            );
            // Delay the fetch until after first build
            Future.microtask(() => cubit.getfilteredProductList());
            return cubit;
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Shop Now'))),
        body: Column(
          children: [
            // Fixed controls section - only rebuilds when categories/filters change
            const _FixedControlsSection(),

            // Products grid section - rebuilds when products change
            const Expanded(child: PaginatedProductList()),
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
                previous.products != current.products ||
                previous.categories != current.categories ||
                previous.filterSortOptions != current.filterSortOptions);
      },
      builder: (context, state) {
        if (state is! ProductListLoaded) return const SizedBox.shrink();

        final cubit = context.read<ProductListCubit>();
        final categories = cubit.categories;
        final filters = cubit.filterSortOptions;
        final selectedCategory = cubit.filterbody['category'] ?? "All Items";
        print('from cubittt ${cubit.filterbody}');
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final isDarkMode = theme.brightness == Brightness.dark;
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
                  color: isDarkMode ? colorScheme.primary : Colors.white,
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt,
                              size: 30,
                              color:
                                  isDarkMode
                                      ? Colors.grey
                                      : colorScheme.primary,
                            ),
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort_sharp,
                              size: 30,
                              color:
                                  isDarkMode
                                      ? Colors.grey
                                      : colorScheme.primary,
                            ),
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

// class _ProductsGridSection extends StatelessWidget {
//   const _ProductsGridSection();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductListCubit, ProductListState>(
//       buildWhen: (previous, current) {
//         // Only rebuild when products actually change
//         return current is ProductListLoaded &&
//             (previous is! ProductListLoaded ||
//                 !listEquals(previous.products, current.products));
//       },
//       builder: (context, state) {
//         final favState = context.watch<FavCubit>().state;

//         if (state is ProductListLoading || favState is FavLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is ProductListError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error, size: 64, color: Colors.red),
//                 const SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: const Text(
//                     'Error loading the data',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<ProductListCubit>().getfilteredProductList();
//                   },
//                   child: Text('Try again'),
//                 ),
//               ],
//             ),
//           );
//         }
//         if (state is! ProductListLoaded || favState is! FavLoaded)
//           return const SizedBox.shrink();

//         final screenWidth = MediaQuery.of(context).size.width;
//         final itemWidth = screenWidth / 2;
//         final itemHeight = itemWidth / 0.6;
//         final favProducts = favState.favProducts;

//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 20,
//               childAspectRatio: itemWidth / itemHeight,
//             ),
//             itemBuilder: (context, index) {
//               final product = state.products[index];
//               return CustomCard(
//                 cardtitle: product.name!,
//                 price: '${product.price}',
//                 rating: product.totalRating!,
//                 imageUrl: product.imageUrl!,
//                 favicon:
//                     context.read<FavCubit>().favouritesProducts.any(
//                           (favProduct) => favProduct.id == product.id,
//                         )
//                         ? Icon(Icons.favorite, color: Colors.red)
//                         : Icon(Icons.favorite_border),
//                 addcartIcon: Icon(Icons.shopping_cart_outlined),
//                 onPressedFav: () {
//                   // context.read<ProductListCubit>().toggleFavorite(
//                   //   productId: product.id!,
//                   // );
//                   print('Toggling favorite for productId: ${product.id}');
//                   print('userId: ${context.read<AuthCubit>().currentUser?.id}');
//                   context.read<FavCubit>().toggleFavourite(
//                     productId: product.id!,
//                   );
//                 },
//               );
//             },
//             itemCount: state.products.length,
//           ),
//         );
//       },
//     );
//   }
// }
