import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';

abstract class BaseCardRepository {
  Future<CartModel> getCartItems(String? userId);
  Future<bool> addCartItem(String userId, String productId);
  Future<bool> removeCartItem(String userId, String productId);
  Future<bool> editCartItem(String userId, String productId, String operation);
}
