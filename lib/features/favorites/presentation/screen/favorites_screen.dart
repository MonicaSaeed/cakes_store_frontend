import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Sweet Favorites'))),
      body: BlocBuilder<FavCubit, FavState>(
        builder: (context, state) {
          if (state is FavLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('please try again later.'),
                ],
              ),
            );
          }
          if (state is FavLoaded) {
            final screenWidth = MediaQuery.of(context).size.width;
            final itemWidth = screenWidth / 2;
            final itemHeight = itemWidth / 0.6;
            final favorites = state.favProducts;
            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'Your Favorites is Empty',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add items to your favorites to view them here.',
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: (itemWidth * 0.95) * 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF432c23), // Primary color
                          Color.fromARGB(
                            255,
                            154,
                            128,
                            128,
                          ), // Lighter shade for gradient effect
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                          child: Text(
                            '${favorites.length}\nSaved Items',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              height: 1.7,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      key: ValueKey(favorites.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: itemWidth / itemHeight,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final favorite = favorites[index];
                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(
                            milliseconds: 500 + index * 100,
                          ), // delay each item a bit
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(
                                  0,
                                  (1 - value) * 20,
                                ), // move up 20px while loading
                                child: child,
                              ),
                            );
                          },

                          child: CustomCard(
                            cardtitle: favorite.name!,
                            price: '${favorite.price}',
                            rating: favorite.totalRating!,
                            imageUrl: favorite.imageUrl!,
                            favicon:
                                context.read<FavCubit>().favouritesProducts.any(
                                      (favProduct) =>
                                          favProduct.id == favorite.id,
                                    )
                                    ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                    : const Icon(Icons.favorite_border),
                            addcartIcon: const Icon(
                              Icons.shopping_cart_outlined,
                            ),
                            onPressedFav: () {
                              context.read<FavCubit>().toggleFavourite(
                                productId: favorite.id!,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
