import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';

abstract class BaseOrderRepository {
  Future<List<OrderEntity>> getUserOrders(String userId);
  Future<ProductEntity> getProductById(String productId);
}
