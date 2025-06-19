import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';

abstract class BaseOrderRepository {
  Future<List<OrderEntity>> getUserOrders(String userId);
}
