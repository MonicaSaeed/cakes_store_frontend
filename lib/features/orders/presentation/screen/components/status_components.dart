import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/get_orders_cubit.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/components/info_row.dart';
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

  @override
  void initState() {
    _status = widget.order.orderStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          InfoRow(label: 'Payment Status:', value: widget.order.paymentStatus),
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
