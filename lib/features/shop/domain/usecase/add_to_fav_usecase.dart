import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';

class AddToFavUsecase {
  final BaseProductsRepository _repo;
  AddToFavUsecase(this._repo);
  Future<void>? addToFav(String productId, String userId) {
    try {
      return _repo.addToFav(productId, userId);
    } catch (e) {
      print('error in usecase');
      return null;
    }
  }
}
