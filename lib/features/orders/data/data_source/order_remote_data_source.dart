import 'package:cakes_store_frontend/features/orders/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchUserOrders(String userId);
  Future<ProductEntity> getProductById(String productId);
  Future<void>cancelOrder(String orderId);
}
