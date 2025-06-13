import '../../../shared_product/data/models/product_model.dart';

abstract class BaseProductDetailsRepository {
  Future<ProductModel> getProduct(String productId);
}
