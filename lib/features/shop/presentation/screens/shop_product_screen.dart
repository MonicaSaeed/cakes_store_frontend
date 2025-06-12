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
            body: Builder(
              builder: (context) {
                switch (state) {
                  case ProductListLoading():
                    return const Center(child: CircularProgressIndicator());
                  case ProductListLoaded():
                    return Center(child: Text('${state.products[0].name}'));
                  case ProductListError():
                    return Center(child: Text('Error loading products'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
