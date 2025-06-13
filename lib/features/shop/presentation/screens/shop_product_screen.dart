import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
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
            appBar: AppBar(title: const Text('Shop Now')),
            body: Builder(
              builder: (context) {
                switch (state) {
                  case ProductListLoading():
                    return const Center(child: CircularProgressIndicator());
                  case ProductListLoaded():
                    final categories =
                        context.read<ProductListCubit>().categories;
                    final products = state.products;
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
                                return Chip(
                                  label: Text(
                                    categories[index],
                                    style: const TextStyle(
                                      color: Colors.white, // Text color
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor:
                                      Theme.of(
                                        context,
                                      ).colorScheme.primary, // Background color
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                                    onTap: () {},
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
                                      fontSize: 16,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(width: 16),
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
                                    childAspectRatio: .55,
                                    maxCrossAxisExtent:
                                        300, // Maximum width of each grid tile
                                  ),
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return CustomCard(
                                  cardtitle: product.name!,
                                  price: '${product.price}',
                                  imageUrl: product.imageUrl!,
                                  favicon: Icons.favorite,
                                  addcartIcon: Icons.shop,
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
}
