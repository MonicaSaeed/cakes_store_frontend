import 'package:bloc/bloc.dart';
import 'package:cakes_store_frontend/features/cart/data/datasource/cart_data_source.dart';
import 'package:cakes_store_frontend/features/cart/data/repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int totalPrice = 0;

  getCartItems() async {
    emit(CartLoading());
    try {
      CartModel cartModel =
          await CartRepository(sl<CartDataSource>()).getCartItems();

      if (cartModel.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cartModel.items));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
