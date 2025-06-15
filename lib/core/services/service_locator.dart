import 'package:cakes_store_frontend/features/product_details/data/datasource/product_details_data_source.dart';
import 'package:cakes_store_frontend/features/reviews/data/datasource/reviews_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/data/webservice/auth_webservice.dart';
import '../../features/product_details/data/repository/product_details_repository.dart';
import '../../features/product_details/domain/repository/base_product_details_repository.dart';
import '../../features/reviews/data/repository/reviews_repository.dart';
import '../../features/reviews/domain/repository/base_reviews_repository.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Services
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSource());
  sl.registerLazySingleton<AuthWebservice>(() => AuthWebservice());
  sl.registerLazySingleton<ProductDetailsDataSource>(
    () => ProductDetailsDataSource(),
  );
  sl.registerLazySingleton<ReviewsDataSource>(() => ReviewsDataSource());

  // Repository
  sl.registerLazySingleton<BaseProductsRepository>(
    () => ProductsRepository(sl<ProductDataSource>()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<BaseProductDetailsRepository>(
    () => ProductDetailsRepository(sl<ProductDetailsDataSource>()),
  );
  sl.registerLazySingleton<BaseReviewsRepository>(
    () => ReviewsRepository(sl<ReviewsDataSource>()),
  );
}
