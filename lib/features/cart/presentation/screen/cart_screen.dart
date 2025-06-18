import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit()..getCartItems(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cart')),
            body: Builder(
              builder: (_) {
                switch (state.runtimeType) {
                  case CartLoading:
                    return const Center(child: CircularProgressIndicator());
                  case CartEmpty:
                    return const Center(child: Text('Your cart is empty'));
                  case CartLoaded:
                    final cartLoadedState = state as CartLoaded;
                    final items = cartLoadedState.items;

                    if (items.isEmpty) {
                      return const Center(child: Text('Your cart is empty'));
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final product = item.product;

                        return ListTile(
                          leading: Image.network(
                            product.imageUrl!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            product.name!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${item.quantity}'),
                          trailing: Text(
                            'EGP ${(item.unitPrice * item.quantity).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    );

                  case CartError:
                    final errorMessage = (state as CartError).errorMessage;
                    return Center(child: Text('Error: $errorMessage'));
                  case CartEmpty:
                    return const Center(child: Text('Your cart is empty'));
                  default:
                    return const Center(child: Text('Unknown state'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
