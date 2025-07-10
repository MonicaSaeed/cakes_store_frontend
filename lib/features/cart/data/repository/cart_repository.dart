import 'package:cakes_store_frontend/features/cart/data/datasource/cart_data_source.dart';
import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';
import 'package:cakes_store_frontend/features/cart/domain/repository/base_cart_repository.dart';

class CartRepository extends BaseCardRepository {
  final CartDataSource _cartDataSource;

  CartRepository(this._cartDataSource);

  @override
  Future<CartModel> getCartItems(String? userId) async {
    try {
      print('repository: Getting cart items...${_cartDataSource}');
      return await _cartDataSource.getCartItems(userId);
    } on Exception catch (e) {
      if (e.toString().contains('Cart not found')) {
        throw Exception('Cart not found');
      } else {
        throw Exception('Failed to get cart items: ${e.toString()}');
      }
    }
  }

  @override
  Future<bool> addCartItem(String userId, String productId) async {
    try {
      final res = await _cartDataSource.addCartItem(userId, productId);
      if (res['success'] == true) {
        print('Item added successfully');
        return true;
      } else {
        print('Failed to add item: ${res['message']}');
        throw Exception(res['message']);
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> removeCartItem(String userId, String productId) async {
    try {
      final res = await _cartDataSource.removeCartItem(userId, productId);
      if (res['success'] == true) {
        print('Item removed successfully');
        return true;
      } else {
        print('Failed to remove item');
        throw Exception('Failed to remove item');
      }
    } catch (e) {
      throw Exception('Failed to remove cart item: ${e.toString()}');
    }
  }

  @override
  Future<bool> editCartItem(
    String userId,
    String productId,
    String operation,
  ) async {
    try {
      final res = await _cartDataSource.editCartItem(
        userId,
        productId,
        operation,
      );
      if (res['success'] == true) {
        print('Item edited successfully');
        return true;
      } else {
        print('Failed to edit item: ${res['message']}');
        throw Exception(res['message']);
      }
    } catch (e) {
      throw Exception('Failed to edit cart item: ${e.toString()}');
    }
  }
}
