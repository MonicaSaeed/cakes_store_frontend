import 'package:cakes_store_frontend/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/rating_component.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../reviews/presentation/components/add_review_popup.dart';
import '../../../reviews/presentation/cubit/reviews_cubit.dart';
import '../../../reviews/presentation/screens/reviews_screen.dart';

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
  final String productId;
  final String userId;

  ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductListCubit()..getProduct(productId, userId),
        ),
        BlocProvider(create: (_) => ReviewsCubit()..getReviews(productId)),
      ],
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
                    final isOutOfStock = product.stock == 0;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                '${product.imageUrl}',
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              if (isOutOfStock)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.4),
                                    child: const Center(
                                      child: Text(
                                        'Out of Stock',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name ?? '',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.headlineLarge,
                                        maxLines:
                                            2, // Adjust depending on layout
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    BlocBuilder<FavCubit, FavState>(
                                      builder: (context, favState) {
                                        return Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                isDarkMode
                                                    ? colorScheme.surfaceTint
                                                    : Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            transitionBuilder: (
                                              child,
                                              animation,
                                            ) {
                                              return ScaleTransition(
                                                scale: animation,
                                                child: child,
                                              );
                                            },
                                            child: IconButton(
                                              icon:
                                                  context
                                                          .read<FavCubit>()
                                                          .favouritesProducts
                                                          .any(
                                                            (favProduct) =>
                                                                favProduct.id ==
                                                                product.id,
                                                          )
                                                      ? Icon(
                                                        Icons.favorite,
                                                        color:
                                                            isDarkMode
                                                                ? colorScheme
                                                                    .primary
                                                                : Colors.red,
                                                      )
                                                      : const Icon(
                                                        Icons.favorite_border,
                                                      ),
                                              onPressed: () {
                                                context
                                                    .read<FavCubit>()
                                                    .toggleFavourite(
                                                      productId: product.id!,
                                                    );
                                              },
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<ReviewsCubit, ReviewsState>(
                                  builder: (context, reviewState) {
                                    int reviewCount = 0;
                                    if (reviewState is ReviewsLoaded) {
                                      reviewCount = reviewState.reviews.length;
                                    }
                                    return RatingComponent(
                                      rating: product.totalRating ?? 0.0,
                                      reviewCount: reviewCount,
                                    );
                                  },
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
                                        color:
                                            isDarkMode
                                                ? colorScheme.surfaceTint
                                                : const Color(0xFFFBE6E6),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        '${product.discountPercentage}% off',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          color:
                                              isDarkMode
                                                  ? colorScheme.primary
                                                  : const Color(0xFFFF8C8C),
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
                                // Add to cart button
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.add_shopping_cart),
                                  label: Text(
                                    isOutOfStock
                                        ? 'Out of Stock'
                                        : 'Add to Cart',
                                  ),
                                  onPressed:
                                      isOutOfStock
                                          ? null // disable button if out of stock
                                          : () {
                                            context.read<CartCubit>().addToCart(
                                              product.id!,
                                              context,
                                            );
                                          },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isOutOfStock ? Colors.grey : null,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<ReviewsCubit, ReviewsState>(
                                  builder: (context, reviewState) {
                                    bool userHasReviewed = false;

                                    if (reviewState is ReviewsLoaded) {
                                      userHasReviewed = reviewState.reviews.any(
                                        (review) => review.user.id == userId,
                                      );
                                    }

                                    return Row(
                                      children: [
                                        Text(
                                          'Customer Reviews',
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                        const Spacer(),
                                        if (product.userOrdered == true &&
                                            userHasReviewed == false)
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons.rate_review),
                                            label: const Text('Add Review'),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    lightTheme
                                                        .colorScheme
                                                        .surface,
                                                builder:
                                                    (_) => BlocProvider.value(
                                                      value:
                                                          context
                                                              .read<
                                                                ReviewsCubit
                                                              >(),
                                                      child: AddReviewPopup(
                                                        productId: product.id!,
                                                        userId: userId,
                                                        onReviewAdded: () {
                                                          context
                                                              .read<
                                                                ProductListCubit
                                                              >()
                                                              .getProduct(
                                                                product.id!,
                                                                userId,
                                                              ); // 👈 refresh rating
                                                        },
                                                      ),
                                                    ),
                                              );
                                            },
                                          ),
                                      ],
                                    );
                                  },
                                ),

                                const SizedBox(height: 8),
                                const ReviewsSection(),
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
