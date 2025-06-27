import 'dart:developer';

import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/components/product_card.dart';
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
            _infoRow(
              context,
              'Total Price:',
              currency.format(order.totalPrice),
            ),
            _infoRow(
              context,
              'Discount:',
              '${order.discountApplied?.toStringAsFixed(2)}',
            ),
            if (order.promoCodeApplied != null &&
                order.promoCodeApplied!.isNotEmpty)
              _infoRow(context, 'Promo Code:', order.promoCodeApplied!),
            const Divider(height: 32),

            _sectionTitle(context, 'Shipping Info'),
            _infoRow(context, 'Address:', order.shippingAddress),
            if (order.deliveryDate != null)
              _infoRow(
                context,
                'Delivery Date:',
                DateFormat.yMMMMd().format(order.deliveryDate!),
              ),
            const Divider(height: 32),

            _sectionTitle(context, 'Status'),
            _infoRow(context, 'Order Status:', order.orderStatus),
            _infoRow(context, 'Payment Status:', order.paymentStatus),
            _infoRow(
              context,
              'Created At:',
              DateFormat.yMMMMd().add_jm().format(order.createdAt),
            ),
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

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
