import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';

abstract class OrderRepositoryBase {
  Future<OrderEntity> placeOrder(Order order);
  Future<void> clearCart(String userId);
}
