import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';

class ProductsRepository extends BaseProductsRepository {
  final ProductDataSource _productDataSource;

  ProductsRepository(this._productDataSource);

  @override
  Future<List<ProductModel>> getfilteredProductList(filterbody) =>
      _productDataSource.getfilteredProductList(filterbody);

  @override
  Future<void> addToFav(String productId, String userId) =>
      _productDataSource.addToFav(productId, userId);

  @override
  Future<void> removeFromFav(String productId, String userId) =>
      _productDataSource.removeFromFav(productId, userId);

  @override
  Future<List<ProductModel>> getAllFavs(String userId) =>
      _productDataSource.getAllFavs(userId);
}
