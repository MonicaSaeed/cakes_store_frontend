import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';

class OrderStates {}

class OrdersInitialState extends OrderStates {}

class OrdersLoadedState extends OrderStates {
  OrdersLoadedState(this.orders);
  List<OrderEntity> orders;
}

class OrdersFailureState extends OrderStates {}
class InvalidUserIdState extends OrderStates{}
