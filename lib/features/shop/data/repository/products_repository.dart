import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';

class ProductsRepository extends BaseProductsRepository {
  final ProductDataSource _productDataSource;

  ProductsRepository(this._productDataSource);

  @override
  Future<List<ProductModel>> getProductList() =>
      _productDataSource.getProductList();
}
