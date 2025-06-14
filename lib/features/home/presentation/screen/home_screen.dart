import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Cake Store")),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (_, index) {
                    final product = state.products[index];
                    return CustomCard(
                      cardtitle: product.name!,
                      price: '${product.price}',
                      rating: product.totalRating!,
                      imageUrl: product.imageUrl!,
                      favicon: Icons.favorite_border,
                      addcartIcon: Icons.shopping_cart_outlined,
                    );
                  },
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
