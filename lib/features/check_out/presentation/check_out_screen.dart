import 'dart:developer';

import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_item.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/check_out/domain/place_order_use_case.dart';
import 'package:flutter/material.dart';
import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutScreen extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final String? promo;
  final String userId;

  const CheckOutScreen({
    super.key,
    required this.items,
    required this.total,
    this.promo,
    required this.userId
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
}) async {
  if (userId == null){
    log('UserId = null at CheckOutScreen');
return;
  } 

  // Simulate sending order
    log('Order placed for user: $userId');
    log('Address: $address');
    log('Items: ${items.length}');

  final order = Order(
    userId: userId,
    orderItems: items.map((item) {
      return OrderItem(
        productId: item.product.id!,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
      );
    }).toList(),
    totalPrice: widget.total,
    promoCodeApplied: 'SWEET10', // dynamic if available
    discountApplied: 10,
    shippingAddress: address,
  );

  try {
    final placeOrderUseCase = sl<PlaceOrderUseCase>();
    await placeOrderUseCase(order);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to place order')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final total = widget.total;

    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
      
                    return ListTile(
                      leading: Image.network(product.imageUrl!),
                      title: Text(product.name!),
                      subtitle: Text(
                        'Qty: $quantity  •  EGP ${discountedPrice.toStringAsFixed(2)}',
                      ),
                      trailing: Text(
                        'EGP ${(discountedPrice * quantity).toStringAsFixed(2)}',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Delivery Address',
                  border: OutlineInputBorder(),
                  errorText: _errorText,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'EGP ${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
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
                        _errorText = 'Please enter a delivery address';
                      });
                      return;
                    }
      
                    
                    _confirmOrder(
                      address: address,
                      items: items,
                      userId: widget.userId,
                    );
                  },
                  child: const Text('Confirm Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
