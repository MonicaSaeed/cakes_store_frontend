import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cakes_store_frontend/core/components/rating_bar_widget.dart';
import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCard extends StatelessWidget {
  final Product product;

  const CustomCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final hasDiscount =
        product.discountPercentage != null && product.discountPercentage! > 0;
    final isOutOfStock = product.stock == 0;
    final originalPrice = double.tryParse(product.price.toString()) ?? 0;
    final discountedPrice =
        hasDiscount
            ? (originalPrice * (1 - product.discountPercentage! / 100))
                .toStringAsFixed(2)
            : product.price?.toStringAsFixed(2) ?? 0;

    return GestureDetector(
      onTap: () {},
      child: BlocBuilder<FavCubit, FavState>(
        builder: (context, favState) {
          return SizedBox(
            width: screenWidth * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CachedNetworkImage(
                            imageUrl: product.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),

                          // Out of Stock Banner
                          if (isOutOfStock)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.4),
                                child: const Center(
                                  child: Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Discount Badge
                          if (hasDiscount)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "-${product.discountPercentage!.round()}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                          // Favorite Icon
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
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
                                                    favProduct.id == product.id,
                                              )
                                          ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                          : const Icon(Icons.favorite_border),
                                  onPressed: () {
                                    context.read<FavCubit>().toggleFavourite(
                                      productId: product.id!,
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                letterSpacing: 2,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            RatingBarWidget(
                              rating: product.totalRating!,
                              reviewCount: 28,
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (hasDiscount)
                                        Text(
                                          "${product.price} EGP",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      Text(
                                        "$discountedPrice EGP",
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                if (!isOutOfStock)
                                  SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                      ),
                                      iconSize: 20,
                                      onPressed: isOutOfStock ? null : () {},
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      tooltip: "Add to Cart",
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
