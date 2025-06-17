import 'package:cakes_store_frontend/features/favorites/data/datasource/fav_datasource.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

abstract class BaseFavRepo {
  FavDatasource favDatasource;
  BaseFavRepo(this.favDatasource);

  Future<void> addToFav(String productId, String userId);

  Future<void> removeFromFav(String productId, String userId);

  Future<List<ProductModel>> getAllFavs(String userId);
}
