import 'dart:developer';

import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_item.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/check_out/domain/place_order_use_case.dart';
import 'package:flutter/material.dart';
import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutScreen extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final String? promoCode;
  final int? promoDiscount;
  final String userId;

  const CheckOutScreen({
    super.key,
    required this.items,
    required this.total,
    this.promoCode,
    this.promoDiscount,
    required this.userId,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final TextEditingController _addressController = TextEditingController();
  String? _errorText;

  void _confirmOrder({
    required String address,
    required List<CartItem> items,
    required String? userId,
    required double totalPrice,
    String? promoCode,
    int? promoDiscount
  }) async {
    if (userId == null) {
      log('UserId = null at CheckOutScreen');
      return;
    }

    // Simulate sending order
    log('Order placed for user: $userId');
    log('Address: $address');
    log('Items: ${items.length}');

    final order = Order(
      userId: userId,
      orderItems:
          items.map((item) {
            return OrderItem(
              productId: item.product.id!,
              quantity: item.quantity,
              unitPrice: item.unitPrice,
            );
          }).toList(),
      totalPrice: totalPrice,
      promoCodeApplied: promoCode, // dynamic if available
      discountApplied: promoDiscount?.toDouble(),
      shippingAddress: address,
    );

    try {
      final placeOrderUseCase = sl<PlaceOrderUseCase>();
      await placeOrderUseCase(order);

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Order Confirmed'),
              content: const Text('Your order has been placed successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } catch (e) {
      print('Order error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to place order')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final total = widget.total;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartLoading:
                return Scaffold(appBar: AppBar(),body: const Center(child: CircularProgressIndicator()));
              case CartEmpty:
                return Scaffold( appBar: AppBar(),body: const Center(child: Text('Your cart is empty')));
              case CartLoaded:
                final cartLoadedState = state as CartLoaded;
                final items = cartLoadedState.items;

                if (items.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }

                log('$cartLoadedState');

                return Scaffold(
                  appBar: AppBar(title: const Text('Checkout')),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 0,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              final product = item.product;
                              final discount =
                                  (product.discountPercentage ?? 0) / 100;
                              final discountedPrice =
                                  item.unitPrice * (1 - discount);
                              final quantity = item.quantity;

                              return Card(
                                child: Column(
                                  children: [
                                    Text(
                                      product.name!,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
                                    ),
                                    ListTile(
                                      leading: Image.network(product.imageUrl!),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            ' EGP ${item.unitPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          Text(
                                            ' EGP ${discountedPrice.toStringAsFixed(2)}',
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text('Qty: $quantity'),
                                          Text(
                                            'EGP ${(discountedPrice * quantity).toStringAsFixed(2)}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _addressController,
                          hintText: 'Enter Delivery Address',
                          title: 'Delivery Address',
                          suffixIcon: const Icon(Icons.home),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            widget.promoCode == null
                                ? Text(
                                  'EGP ${total.toStringAsFixed(2)}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                                : Column(
                                  children: [
                                    Text(
                                      'EGP ${total.toStringAsFixed(2)}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      'EGP ${(total * (1 - (widget.promoDiscount ?? 0) / 100)).toStringAsFixed(2)}',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
                                    ),
                                  ],
                                ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final address = _addressController.text.trim();
                              if (address.isEmpty) {
                                setState(() {
                                  _errorText =
                                      'Please enter a delivery address';
                                });
                                return;
                              }

                              _confirmOrder(
                                address: address,
                                items: items,
                                userId: widget.userId,
                                totalPrice:widget.promoCode == null? total : total * (1 - (widget.promoDiscount ?? 0) / 100),
                                promoCode: widget.promoCode,
                                promoDiscount: widget.promoDiscount
                              );
                            },
                            child: const Text('Confirm Order'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              default:
                return const Center(child: Text('Unknown state'));
            }
          },
        ),
     
    );
  }
}
