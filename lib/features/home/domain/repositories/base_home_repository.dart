import '../../../shared_product/domain/entities/product.dart';

abstract class BaseHomeRepository {
  Future<List<Product>> getAllProducts();
}
