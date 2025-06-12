import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';

class GetProductListUseCase {
  final BaseProductsRepository _repo;
  GetProductListUseCase(this._repo);
  Future<List<ProductModel>>? getProductList() {
    try {
      return _repo.getProductList();
    } catch (e) {
      print('error in usecase');
      return null;
    }
  }
}
