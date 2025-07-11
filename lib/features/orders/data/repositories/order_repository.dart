import 'dart:developer';

import 'package:cakes_store_frontend/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';
import 'package:cakes_store_frontend/features/orders/domain/repos/base_order_repository.dart';

class OrderRepositoryImpl implements BaseOrderRepository{
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderEntity>> getUserOrders(String userId) async {
    try {
      final orders = await remoteDataSource.fetchUserOrders(userId);
      return orders;
    } catch (e) {
      log('Exception occured at OrderRepositoryImpl in orders feature : ');
      log(e.toString());
      throw Exception(e.toString());
    }
  }
  @override
  Future<ProductEntity> getProductById(String productId) {
    return remoteDataSource.getProductById(productId);
  }

  Future<void> cancelOrder(String orderId){
    return remoteDataSource.cancelOrder(orderId);
  }
}
