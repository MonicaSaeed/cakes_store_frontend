import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/orders/domain/repos/base_order_repository.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/products_cubit/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  const ProductCard({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(sl<BaseOrderRepository>())..fetchProduct(productId),
      child: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final product = state.product;
            return Card(
              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: product.imageUrl!=null ?Image.network(
                          product.imageUrl!,
                          width: 300,
                          height: 350,
                          fit: BoxFit.cover,
                        ):Image.asset('assets/images/no_image_available.png'),
                      ),
                      Row(
                        children: [
                          Text(product.name,style: Theme.of(context).textTheme.titleLarge,),
                          Spacer(),
                          (product.totalRating??0) > 0?Text('${product.totalRating}/5'):Text('')
                        ],
                      ),
                
                    ListTile(
                      title: Text(product.category,style: Theme.of(context).textTheme.labelMedium,),
                      subtitle: Text(product.description, maxLines: 4, overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.labelSmall),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${product.price}',
                            style:Theme.of(context).textTheme.bodyMedium,
                          ),
                          if ((product.discountPercentage??0) > 0)
                            Text(
                              '-${product.discountPercentage}%',
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductError) {
            return Text(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
