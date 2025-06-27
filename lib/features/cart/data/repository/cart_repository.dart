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
}
