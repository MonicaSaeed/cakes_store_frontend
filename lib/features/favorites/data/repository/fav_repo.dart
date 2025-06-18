import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

class FavRepo extends BaseFavRepo {
  FavRepo(super.favDatasource);

  @override
  Future<void> addToFav(String productId, String userId) {
    return favDatasource.addToFav(productId, userId);
  }

  @override
  Future<void> removeFromFav(String productId, String userId) {
    return favDatasource.removeFromFav(productId, userId);
  }

  @override
  Future<List<ProductModel>> getAllFavs(String userId) {
    return favDatasource.getAllFavs(userId);
  }
}
