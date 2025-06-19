import 'package:cakes_store_frontend/features/orders/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchAllOrders();
}
