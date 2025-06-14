import 'package:cakes_store_frontend/features/home/domain/repositories/base_home_repository.dart';
import '../../../shared_product/domain/entities/product.dart';

class GetAllProductsUseCase {
  final BaseHomeRepository repository;

  GetAllProductsUseCase(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}
