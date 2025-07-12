import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    ;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sweet Favorites',
          style: TextStyle(
            color: isDarkMode ? colorScheme.surfaceTint : colorScheme.primary,
          ),
        ),
      ),
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
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FavCubit>().loadAllFavourites();
                    },
                    child: const Text('Retry'),
                  ),
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

            return LayoutBuilder(
              builder: (context, constraints) {
                final int gridCrossAxisCount;
                final double gridChildAspectRatio;
                if (constraints.maxWidth >= 800) {
                  gridCrossAxisCount = 4;
                  gridChildAspectRatio = 0.55;
                } else if (constraints.maxWidth >= 600) {
                  gridCrossAxisCount = 3;
                  gridChildAspectRatio = 0.55;
                } else {
                  gridCrossAxisCount = 2;
                  gridChildAspectRatio = 0.55;
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
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridCrossAxisCount,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: gridChildAspectRatio,
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
                                product: favorite,
                                userId:
                                    context.read<UserCubit>().currentUser!.id!,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
