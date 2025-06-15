import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';

class GetAllFavsUsecase {
  final BaseProductsRepository _repo;
  GetAllFavsUsecase(this._repo);
  Future<List<ProductModel>>? getAllFavs(String userId) {
    try {
      return _repo.getAllFavs(userId);
    } catch (e) {
      print('error in usecase');
      return null;
    }
  }
}
