import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Services
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSource());

  // Repository
  sl.registerLazySingleton<BaseProductsRepository>(
    () => ProductsRepository(sl<ProductDataSource>()),
  );
}
