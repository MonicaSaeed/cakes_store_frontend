import 'package:cakes_store_frontend/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final int stock;
  final String productId;
  const QuantitySelector({
    super.key,
    this.quantity = 1,
    this.stock = 1,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 110,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            // mainAxisSize: MainAxisSize.,
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: isDarkMode ? colorScheme.secondary : null,
                ),
                onPressed: () {
                  context.read<CartCubit>().decrementCartItem(
                    productId,
                    context,
                  );
                },
                splashRadius: 10,
              ),
              Container(
                width: 10,
                alignment: Alignment.center,
                child: Text('$quantity', style: const TextStyle(fontSize: 16)),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: isDarkMode ? colorScheme.secondary : null,
                ),
                onPressed:
                    (quantity < stock)
                        ? () {
                          context.read<CartCubit>().incrementCartItem(
                            productId,
                            context,
                          );
                        }
                        : null,
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
