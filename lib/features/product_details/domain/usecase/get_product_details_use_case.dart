import '../../../shared_product/data/models/product_model.dart';
import '../repository/base_product_details_repository.dart';

class GetProductDetailsUseCase {
  final BaseProductDetailsRepository _repo;

  GetProductDetailsUseCase(this._repo);

  Future<ProductModel> getProduct(String productId, String? userId) async {
    try {
      return await _repo.getProduct(productId, userId);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }
}
