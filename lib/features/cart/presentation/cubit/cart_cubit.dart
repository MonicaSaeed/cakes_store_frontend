import 'package:bloc/bloc.dart';
import 'package:cakes_store_frontend/features/cart/data/datasource/cart_data_source.dart';
import 'package:cakes_store_frontend/features/cart/data/repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/services/toast_helper.dart';
import '../../data/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final String? userId;
  CartCubit({this.userId}) : super(CartInitial());
  int totalPrice = 0;

  getCartItems() async {
    emit(CartLoading());
    try {
      CartModel cartModel = await CartRepository(
        sl<CartDataSource>(),
      ).getCartItems(userId);

      if (cartModel.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cartModel.items));
      }
    } on Exception catch (e) {
      if (e.toString().contains('Cart not found')) {
        emit(CartEmpty());
      } else {
        emit(CartError(e.toString()));
      }
    }
  }

  addToCart(String productId, BuildContext context) async {
    emit(CartLoading());
    try {
      print('Adding item to cart: $productId for user: $userId');
      final res = await CartRepository(
        sl<CartDataSource>(),
      ).addCartItem(userId!, productId);
      if (res) {
        ToastHelper.showToast(
          context: context,
          message: 'Item added to cart successfully',
          toastType: ToastType.success,
        );
        getCartItems();
      } else {
        emit(AddCartError('Failed to add item to cart'));
        ToastHelper.showToast(
          context: context,
          message: 'Failed to add item to cart',
          toastType: ToastType.error,
        );
      }
    } catch (e) {
      final errorMessage = _parseErrorMessage(e.toString());

      emit(AddCartError(errorMessage));
      ToastHelper.showToast(
        context: context,
        message: errorMessage,
        toastType: ToastType.error,
      );
    }
  }

  incrementCartItem(String productId, BuildContext context) async {
    emit(CartLoading());
    try {
      final res = await CartRepository(
        sl<CartDataSource>(),
      ).addCartItem(userId!, productId);
      if (res) {
        getCartItems();
      } else {
        emit(AddCartError('Failed to add item to cart'));
        ToastHelper.showToast(
          context: context,
          message: 'Failed to add item to cart',
          toastType: ToastType.error,
        );
      }
    } catch (e) {
      emit(AddCartError(e.toString()));
      print(e.toString());
      // ToastHelper.showToast(
      //   context: context,
      //   message: e.toString(),
      //   toastType: ToastType.error,
      // );
    }
  }

  removeCartItem(String productId, BuildContext context) async {
    emit(CartLoading());

    try {
      final res = await CartRepository(
        sl<CartDataSource>(),
      ).removeCartItem(userId!, productId);
      if (res) {
        getCartItems();
      } else {
        emit(RemoveCartError('Failed to remove item from cart'));
        ToastHelper.showToast(
          context: context,
          message: 'Failed to remove item from cart',
          toastType: ToastType.error,
        );
      }
    } catch (e) {
      emit(RemoveCartError(e.toString()));
      ToastHelper.showToast(
        context: context,
        message: e.toString(),
        toastType: ToastType.error,
      );
    }
  }

  decrementCartItem(String productId, BuildContext context) async {
    emit(CartLoading());

    try {
      final res = await CartRepository(
        sl<CartDataSource>(),
      ).editCartItem(userId!, productId, 'decrement');
      if (res) {
        getCartItems();
      } else {
        emit(EditCartError('Failed to decrement item from cart'));
        ToastHelper.showToast(
          context: context,
          message: 'Failed to decrement item from cart',
          toastType: ToastType.error,
        );
      }
    } catch (e) {
      emit(EditCartError(e.toString()));
      ToastHelper.showToast(
        context: context,
        message: e.toString(),
        toastType: ToastType.error,
      );
    }
  }

  String _parseErrorMessage(String error) {
    // Remove repeated "Exception:" if present
    return error.replaceAll(RegExp(r'Exception:\s*'), '').trim();
  }
}
