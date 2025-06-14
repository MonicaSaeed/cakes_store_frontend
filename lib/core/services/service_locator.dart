import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/home/data/repositories/home_repository.dart';
import 'package:cakes_store_frontend/features/home/domain/repositories/base_home_repository.dart';
import 'package:dio/dio.dart';
import 'package:cakes_store_frontend/features/home/data/datasource/home_remote_datasource.dart';
import 'package:cakes_store_frontend/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/data/webservice/auth_webservice.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Auth
  sl.registerLazySingleton<AuthWebservice>(() => AuthWebservice());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));

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
}
