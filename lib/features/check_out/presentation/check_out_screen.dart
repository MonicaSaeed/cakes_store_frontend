import 'dart:developer';

import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_item.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/check_out/domain/place_order_use_case.dart';
import 'package:cakes_store_frontend/features/payment/payment_screen.dart';
import 'package:dio/dio.dart';
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

  void _confirmOrder({
    required String address,
    required List<CartItem> items,
    required String? userId,
    required double totalPrice,
    String? promoCode,
    int? promoDiscount,
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
      final addedOrder = await placeOrderUseCase(order);
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final isDarkMode = colorScheme.brightness == Brightness.dark;
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
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: isDarkMode ? colorScheme.surfaceTint : null,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () async {
                    try {
                      // Step 1: Get iframe URL from your backend
                      final response = await Dio().post(
                        ApiConstance.payUrl,
                        data: {
                          "mongo_order_id": addedOrder.id,
                          "amount": addedOrder.totalPrice,
                        },
                      );

                      if (response.statusCode == 200 &&
                          response.data['iframe_url'] != null) {
                        final iframeUrl = response.data['iframe_url'];

                        // Step 2: Open PaymentScreen and wait for result
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    PaymentScreen(iframeUrl: iframeUrl),
                          ),
                        );
                      }
                    } catch (e) {
                      log("Error while fetching frameUrl $e");
                    }
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: isDarkMode ? colorScheme.surfaceTint : null,
                    ),
                  ),
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
    final total = widget.total;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoading:
              return Scaffold(
                appBar: AppBar(),
                body: const Center(child: CircularProgressIndicator()),
              );
            case CartEmpty:
              return Scaffold(
                appBar: AppBar(),
                body: const Center(child: Text('Your cart is empty')),
              );
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
                    horizontal: 12,
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
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      product.imageUrl!,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          product.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(fontSize: 18),
                                        ),
                                        ListTile(
                                          leading: Column(
                                            children: [
                                              Text(
                                                ' EGP ${item.unitPrice.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                ),
                                              ),
                                              Text(
                                                ' EGP ${discountedPrice.toStringAsFixed(2)}',
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
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
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                          ),
                          widget.promoCode == null
                              ? Text(
                                'EGP ${total.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontSize: 20),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              final address = _addressController.text.trim();
                              if (address.isEmpty) {
                                setState(() {});
                                return;
                              }

                              _confirmOrder(
                                address: address,
                                items: items,
                                userId: widget.userId,
                                totalPrice:
                                    widget.promoCode == null
                                        ? total
                                        : total *
                                            (1 -
                                                (widget.promoDiscount ?? 0) /
                                                    100),
                                promoCode: widget.promoCode,
                                promoDiscount: widget.promoDiscount,
                              );
                            },
                            child: const Text('Confirm Order'),
                          ),
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
