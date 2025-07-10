import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';

abstract class OrderRepositoryBase {
  Future<void> placeOrder(Order order);
  Future<void> clearCart(String userId);
}
