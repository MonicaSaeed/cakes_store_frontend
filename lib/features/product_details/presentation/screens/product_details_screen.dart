import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/quantity_selector.dart';
import '../components/rating_component.dart';

// to navigate to this screen, you can use the following code snippet:
// onPressed: () {
// print('Navigating to Product Details');
// Navigator.pushNamed(
// context,
// AppRouter.productDetails,
// arguments: '6849b9c2c1bdb9bd5987066d',
// );
// print('Navigated to Product Details');
// },

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (_) => ProductListCubit(userId: null)..getProduct(productId),
      child: BlocBuilder<ProductListCubit, ProductDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Product Details')),
            body: Builder(
              builder: (_) {
                switch (state) {
                  case ProductDetailsLoading():
                    return const Center(child: CircularProgressIndicator());
                  case ProductDetailsLoaded():
                    final product = state.product;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            '${product.imageUrl}',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  '${product.name}',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 16),
                                RatingComponent(
                                  rating: product.totalRating ?? 0.0,
                                  reviewCount: 0,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      ' EGP ${(product.price! - (product.discountPercentage ?? 0) / 100 * product.price!).toStringAsFixed(2)}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      ' EGP ${product.price!.toStringAsFixed(2)}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFBE6E6),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        '${product.discountPercentage}% off',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          color: const Color(0xFFFF8C8C),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '${product.description}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Quantity',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                QuantitySelector(quantity: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                  case ProductDetailsError():
                    return Center(child: Text('Error: ${state.errorMessage}'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
