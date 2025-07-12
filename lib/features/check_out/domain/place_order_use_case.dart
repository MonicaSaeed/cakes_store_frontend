import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/check_out/data/repo/order_repo_base.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';

class PlaceOrderUseCase {
  final OrderRepositoryBase repository;

  PlaceOrderUseCase(this.repository);

  Future<OrderEntity> call(Order order) async {
    repository.clearCart(order.userId);
    return await repository.placeOrder(order);
  }
}
