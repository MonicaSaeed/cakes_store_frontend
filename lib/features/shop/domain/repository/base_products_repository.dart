import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

abstract class BaseProductsRepository {
  Future<List<ProductModel>> getfilteredProductList(filterbody);
}
