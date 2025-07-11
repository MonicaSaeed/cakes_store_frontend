import 'dart:developer';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/get_orders_cubit.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/components/info_row.dart';
import 'package:cakes_store_frontend/features/payment/payment_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusComponent extends StatefulWidget {
  const StatusComponent({super.key, required this.order});

  final OrderEntity order;

  @override
  State<StatusComponent> createState() => _StatusComponentState();
}

class _StatusComponentState extends State<StatusComponent> {
  late String _status;
  late String _paymentStatus;

  @override
  void initState() {
    _status = widget.order.orderStatus;
    _paymentStatus = widget.order.paymentStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_paymentStatus == 'onDelivery' &&
            _status != 'delivered' &&
            _status != 'Canceled')
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  // Step 1: Get iframe URL from your backend
                  final response = await Dio().post(
                    ApiConstance.payUrl,
                    data: {
                      "mongo_order_id": widget.order.id,
                      "amount": widget.order.totalPrice,
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
                            (context) => PaymentScreen(iframeUrl: iframeUrl),
                      ),
                    );
                  }
                  // Fetch updated order data
                  final statusResponse = await Dio().get(
                    '${ApiConstance.ordersUrl}/${widget.order.id}',
                  );

                  if (statusResponse.statusCode == 200 &&
                      statusResponse.data['success'] == true) {
                    final orderData = statusResponse.data['data'];

                    setState(() {
                      _status = orderData['orderStatus'];
                      _paymentStatus = orderData['paymentStatus'];
                    });
                  } else {
                    log(
                      "Order fetch failed (StatusComponent widget): ${response.data['message']}",
                    );
                  }
                } catch (e) {
                  log(
                    "Error while fetching order status(StatusComponent widget): $e",
                  );
                }
              },

              child: const Text('Pay'),
            ),
          ),
        if (_status == 'pending')
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                await GetOrdersCubit().cancelOrder(widget.order.id);
                setState(() {
                  _status = 'Canceled';
                });
              },
              child: const Text('Cancel'),
            ),
          ),

        InfoRow(label: 'Order Status:', value: _status),
        InfoRow(label: 'Payment Status:', value: _paymentStatus),
        InfoRow(
          label: 'Created At:',
          value:
              widget.order.createdAt != null
                  ? DateFormat.yMMMMd().add_jm().format(widget.order.createdAt!)
                  : 'N/A',
        ),
      ],
    );
  }
}
