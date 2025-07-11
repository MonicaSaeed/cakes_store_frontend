import 'dart:developer';

import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/components/info_row.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/components/product_card.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/components/status_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = NumberFormat.currency(locale: 'en', symbol: '\$');
    log('${order.orderItems}');

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _sectionTitle(context, 'Order Summary'),
            InfoRow(
              label: 'Total Price:',
              value: currency.format(order.totalPrice),
            ),
            if (order.promoCodeApplied != null &&
                order.promoCodeApplied!.isNotEmpty)
              InfoRow(label: 'Promo Code:', value: order.promoCodeApplied!),
            if (order.promoCodeApplied != null &&
                order.promoCodeApplied!.isNotEmpty)
              InfoRow(
                label: 'Promo Discount:',
                value: '${order.discountApplied?.toInt()}%',
              ),
            const Divider(height: 32),
            _sectionTitle(context, 'Shipping Info'),
            InfoRow(label: 'Address:', value: order.shippingAddress),
            if (order.deliveryDate != null)
              InfoRow(
                label: 'Delivery Date:',
                value: DateFormat.yMMMMd().format(order.deliveryDate!),
              ),
            const Divider(height: 32),
            _sectionTitle(context, 'Status'),
            StatusComponent(order: order),
            const Divider(height: 32),
            _sectionTitle(context, 'Order Items'),
            ...order.orderItems.map(
              (item) => Column(
                children: [
                  ProductCard(productId: item.productId),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Qty: ${item.quantity} × \$${item.unitPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall,
                    ),
                    trailing: Text(
                      currency.format(item.quantity * item.unitPrice),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
