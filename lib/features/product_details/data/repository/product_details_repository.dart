import '../../../shared_product/data/models/product_model.dart';
import '../../domain/repository/base_product_details_repository.dart';
import '../datasource/product_details_data_source.dart';

class ProductDetailsRepository extends BaseProductDetailsRepository {
  final ProductDetailsDataSource _productDetailsDataSource;

  ProductDetailsRepository(this._productDetailsDataSource);

  @override
  Future<ProductModel> getProduct(String productId, String? userId) async {
    try {
      return await _productDetailsDataSource.getProduct(productId, userId);
    } catch (e) {
      throw Exception('$e');
    }
  }
}
