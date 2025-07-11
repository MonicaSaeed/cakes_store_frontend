import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:cakes_store_frontend/features/orders/domain/repos/base_order_repository.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/order_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOrdersCubit extends Cubit<OrderStates> {
  GetOrdersCubit():super(OrdersInitialState());
  final BaseOrderRepository orderRepository = sl<BaseOrderRepository>();
  List<OrderEntity> orders=[];

  getOrders(String? userId) async {
    if(userId != null){
      try {
      orders = await orderRepository.getUserOrders(
        userId,
      );
      emit(OrdersLoadedState(orders));
    } catch (e) {
      emit(OrdersFailureState(e.toString()));
    }
    }else{
      emit(state);
    }
  }

  cancelOrder(String orderId)async{
    await orderRepository.cancelOrder(orderId);
  }
}
