import 'package:cakes_store_frontend/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';
import 'package:cakes_store_frontend/features/orders/domain/repos/base_order_repository.dart';

class OrderRepositoryImpl implements BaseOrderRepository{
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderEntity>> getUserOrders(String userId) async {
    final orders = await remoteDataSource.fetchUserOrders(userId);
    return orders;
  }
  @override
  Future<ProductEntity> getProductById(String productId) {
    return remoteDataSource.getProductById(productId);
  }
}
