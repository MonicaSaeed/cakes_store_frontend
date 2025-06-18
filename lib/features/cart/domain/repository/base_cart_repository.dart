import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';

abstract class BaseCardRepository {
  Future<CartModel> getCartItems(String? userId);
}
