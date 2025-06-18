import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeCubit = context.read<HomeCubit>();
    final products = homeCubit.getProductsByCategory(categoryName);

    return Scaffold(
      appBar: AppBar(title: Text('$categoryName Category')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 350;
          final gridCrossAxisCount = isSmallScreen ? 2 : 2;
          final gridChildAspectRatio = isSmallScreen ? 0.6 : 0.55;

          return Padding(
            padding: EdgeInsets.all(16.w),
            child:
                products.isEmpty
                    ? Center(
                      child: Text(
                        'No products in this category',
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                    : GridView.builder(
                      itemCount: products.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCrossAxisCount,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: gridChildAspectRatio,
                      ),
                      itemBuilder: (_, index) {
                        final product = products[index];
                        return CustomCard(
                          cardtitle: product.name!,
                          price: '${product.price}',
                          rating: product.totalRating!,
                          imageUrl: product.imageUrl!,
                          favicon:
                              context.read<FavCubit>().favouritesProducts.any(
                                    (favProduct) => favProduct.id == product.id,
                                  )
                                  ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                  : const Icon(Icons.favorite_border),
                          addcartIcon: const Icon(Icons.shopping_cart_outlined),
                          onPressedFav: () {
                            context.read<FavCubit>().toggleFavourite(
                              productId: product.id!,
                            );
                          },
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
