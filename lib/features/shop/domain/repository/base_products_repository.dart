import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

abstract class BaseProductsRepository {
  Future<List<ProductModel>> getfilteredProductList(filterbody);
  Future<void> addToFav(String productId, String userId);
  Future<void> removeFromFav(String productId, String userId);
  Future<List<ProductModel>> getAllFavs(String userId);
}
