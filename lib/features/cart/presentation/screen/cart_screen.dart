import 'dart:developer';

import 'package:cakes_store_frontend/features/check_out/presentation/check_out_screen.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product_details/presentation/components/quantity_selector.dart';
import '../components/promo_code_component.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/promo_code_cubit/promo_code_cubit.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  double itemTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    String? userId = context.read<UserCubit>().currentUser?.id;
    return MultiBlocProvider(

      providers: [BlocProvider(create: (_) => PromoCodeCubit(promoCode: ''))],
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

                    // Calculate total price after discounts
                    final total = items.fold<double>(0, (sum, item) {
                      final discount =
                          (item.product.discountPercentage ?? 0) / 100;
                      final discountedPrice = item.unitPrice * (1 - discount);
                      return sum + discountedPrice * item.quantity;
                    });

                    String? myPromocode;
                    int? myPromoDiscount;

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 12),
                            itemCount: items.length + 1, // +1 for total section
                            itemBuilder: (context, index) {
                              if (index < items.length) {
                                // Regular cart items
                                final item = items[index];
                                final product = item.product;
                                final quantity = item.quantity;
                                final discount =
                                    (product.discountPercentage ?? 0) / 100;
                                final originalPrice = item.unitPrice;
                                final discountedPrice =
                                    originalPrice * (1 - discount);
                                itemTotal = discountedPrice * quantity;

                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          product.imageUrl!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  product.name!,
                                                  style:
                                                      Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium,
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .removeCartItem(
                                                          product.id!,
                                                          context,
                                                        );
                                                  },
                                                  splashRadius: 20,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text('Quantity:'),
                                                const SizedBox(width: 8),
                                                QuantitySelector(
                                                  quantity: quantity,
                                                  productId: product.id!,
                                                  stock: product.stock ?? 1,
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  'EGP ${discountedPrice.toStringAsFixed(2)}',
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.bodyMedium,
                                                ),
                                                const SizedBox(width: 8),
                                                if (discount > 0)
                                                  Text(
                                                    'EGP ${originalPrice.toStringAsFixed(2)}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                  ),
                                                if (discount > 0)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 8.0,
                                                        ),
                                                    child: Text(
                                                      '-${(discount * 100).toStringAsFixed(0)}%',
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Item Total: EGP ${itemTotal.toStringAsFixed(2)}',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return PromoCodeSection(
                                  cartTotal: total,
                                  onDiscountApplied: (
                                    discountedTotal,
                                    promoCode,
                                    promoDiscount,
                                  ) {
                                    // use the discounted total if needed
                                    log(
                                      'inside onDiscountApplied at CartScreen : ',
                                    );
                                    itemTotal = discountedTotal;
                                    myPromocode = promoCode;
                                    myPromoDiscount = promoDiscount;

                                    log('promoCode $myPromocode');
                                    log('promoDiscount $myPromoDiscount');
                                    log(
                                      'Item total after promo code: $itemTotal',
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              log('Promocode = $myPromocode');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider(
                                      create:
                                          (context) =>
                                              CartCubit(userId: userId)
                                                ..getCartItems(),
                                      child: CheckOutScreen(
                                        items: items, // from CartLoaded
                                        total: total,
                                        userId: userId ?? '',
                                        promoCode: myPromocode,
                                        promoDiscount: myPromoDiscount,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('Check out'),
                          ),
                        ),
                      ],
                    );
                  case CartError:
                    return Center(
                      child: Text(
                        'Error: ${(state as CartError).errorMessage}',
                      ),
                    );
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
