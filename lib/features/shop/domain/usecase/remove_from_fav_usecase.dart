import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';

class RemoveFromFavUsecase {
  final BaseProductsRepository _repo;
  RemoveFromFavUsecase(this._repo);
  Future<void>? removeFromFav(String productId, String userId) {
    try {
      print('from usecase');
      print('productId: $productId, userId: $userId');
      return _repo.removeFromFav(productId, userId);
    } catch (e) {
      print('error in usecase');
      return null;
    }
  }
}
