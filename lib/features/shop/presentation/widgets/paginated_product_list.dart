import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart'
    show
        ProductListLoaded,
        ProductListLoading,
        ProductListState,
        ProductListError;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginatedProductList extends StatefulWidget {
  const PaginatedProductList({super.key});

  @override
  State<PaginatedProductList> createState() => _PaginatedProductListState();
}

class _PaginatedProductListState extends State<PaginatedProductList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final cubit = context.read<ProductListCubit>();
      final currentState = cubit.state;

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (currentState is ProductListLoaded &&
            currentState.hasMore &&
            !currentState.isLoadingMore) {
          cubit.loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        if (state is ProductListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductListLoaded) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio:
                        MediaQuery.of(context).size.width /
                        2 /
                        (MediaQuery.of(context).size.width / 2 / 0.6),
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= state.products.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final product = state.products[index];
                      return BlocBuilder<FavCubit, FavState>(
                        builder: (context, favState) {
                          final isFav =
                              favState is FavLoaded &&
                              favState.favProducts.any(
                                (fav) => fav.id == product.id,
                              );

                          return CustomCard(
                            cardtitle: product.name!,
                            price: '${product.price}',
                            rating: product.totalRating!,
                            imageUrl: product.imageUrl!,
                            favicon:
                                context.read<FavCubit>().favouritesProducts.any(
                                      (favProduct) =>
                                          favProduct.id == product.id,
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
                                productId: product.id!,
                              );
                            },
                          );
                        },
                      );
                    },
                    childCount:
                        state.products.length +
                        (state.isLoadingMore ? 1 : 0), // +1 if loading more
                  ),
                ),
              ),
            ],
          );
        } else if (state is ProductListError) {
          return Center(
            child: Column(
              children: [
                Text(state.errorMessage),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductListCubit>().getfilteredProductList();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
