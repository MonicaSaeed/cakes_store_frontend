import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/home/data/repositories/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:cakes_store_frontend/features/home/data/datasource/home_remote_datasource.dart';
import 'package:cakes_store_frontend/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/data/datasource/fav_datasource.dart';
import 'package:cakes_store_frontend/features/favorites/data/repository/fav_repo.dart';
import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';
import 'package:cakes_store_frontend/features/product_details/data/datasource/product_details_data_source.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/datasource/user_shared_datasource.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/repository/user_repo.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/domain/repository/base_user_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/data/webservice/auth_webservice.dart';
import '../../features/product_details/data/repository/product_details_repository.dart';
import '../../features/product_details/domain/repository/base_product_details_repository.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Auth
  sl.registerLazySingleton<AuthWebservice>(() => AuthWebservice());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  // Services
  // for product
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSource());
  // for auth
  sl.registerLazySingleton<AuthWebservice>(() => AuthWebservice());
  // for product details
  sl.registerLazySingleton<ProductDetailsDataSource>(
    () => ProductDetailsDataSource(),
  );
  // for fav
  sl.registerLazySingleton<FavDatasource>(() => FavDatasource());
  // for user
  sl.registerLazySingleton<UserSharedDatasource>(() => UserSharedDatasource());

  //Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: ApiConstance.baseUrl)),
  );

  //Shop
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSource());
  sl.registerLazySingleton<BaseProductsRepository>(
    () => ProductsRepository(sl<ProductDataSource>()),
  );

  //Home
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasource(sl<Dio>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl<HomeRemoteDatasource>()),
  );

  sl.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(sl<HomeRepository>()),
  );

  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<GetAllProductsUseCase>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<BaseProductDetailsRepository>(
    () => ProductDetailsRepository(sl<ProductDetailsDataSource>()),
  );
  sl.registerLazySingleton<BaseFavRepo>(() => FavRepo(sl<FavDatasource>()));
  sl.registerLazySingleton<BaseUserRepo>(
    () => UserRepo(sl<UserSharedDatasource>()),
  );
}
