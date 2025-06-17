import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

class GetAllFavsUsecase {
  final BaseFavRepo _repo;
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
