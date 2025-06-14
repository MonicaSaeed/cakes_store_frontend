import 'package:cakes_store_frontend/features/home/domain/repositories/base_home_repository.dart';

import '../../../shared_product/domain/entities/product.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepository implements BaseHomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepository(this.remoteDatasource);

  @override
  Future<List<Product>> getAllProducts() {
    return remoteDatasource.getAllProducts();
  }
}
