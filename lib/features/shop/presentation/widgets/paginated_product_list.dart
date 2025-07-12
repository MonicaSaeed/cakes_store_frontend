import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart'
    show
        ProductListLoaded,
        ProductListLoading,
        ProductListState,
        ProductListError;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../user_shared_feature/presentation/cubit/user_cubit.dart';

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
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCrossAxisCount,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: gridChildAspectRatio,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= state.products.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final product = state.products[index];
                          return CustomCard(
                            product: product,
                            userId: context.read<UserCubit>().currentUser!.id!,
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
            },
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
