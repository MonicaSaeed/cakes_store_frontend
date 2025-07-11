import 'package:cakes_store_frontend/features/check_out/data/repo/order_repo_base.dart';
import 'package:cakes_store_frontend/features/check_out/domain/place_order_use_case.dart';
import 'package:cakes_store_frontend/features/check_out/domain/repository/order_repo_impl.dart';
import 'package:cakes_store_frontend/features/favorites/data/datasource/fav_datasource.dart';
import 'package:cakes_store_frontend/features/favorites/data/repository/fav_repo.dart';
import 'package:cakes_store_frontend/features/favorites/domain/repository/base_fav_repo.dart';
import 'package:cakes_store_frontend/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:cakes_store_frontend/features/orders/data/data_source/order_remote_data_source_impl.dart';
import 'package:cakes_store_frontend/features/orders/data/repositories/order_repository.dart';
import 'package:cakes_store_frontend/features/orders/domain/repos/base_order_repository.dart';
import 'package:cakes_store_frontend/features/product_details/data/datasource/product_details_data_source.dart';
import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/cart/data/datasource/cart_data_source.dart';
import 'package:cakes_store_frontend/features/cart/data/datasource/promo_code_data_source.dart';
import 'package:cakes_store_frontend/features/home/data/datasource/home_remote_datasource.dart';
import 'package:cakes_store_frontend/features/home/data/repositories/home_repository.dart';
import 'package:cakes_store_frontend/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:cakes_store_frontend/features/reviews/data/datasource/reviews_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/datasource/user_shared_datasource.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/repository/user_repo.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/domain/repository/base_user_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/data/webservice/auth_webservice.dart';
import '../../features/cart/data/repository/cart_repository.dart';
import '../../features/cart/data/repository/promo_code_repository.dart';
import '../../features/cart/domain/repository/base_cart_repository.dart';
import '../../features/cart/domain/repository/base_promo_code_repository.dart';
import '../../features/product_details/data/repository/product_details_repository.dart';
import '../../features/product_details/domain/repository/base_product_details_repository.dart';
import '../../features/reviews/data/repository/reviews_repository.dart';
import '../../features/reviews/domain/repository/base_reviews_repository.dart';

final sl = GetIt.instance;

void setupLocator() {
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
  sl.registerLazySingleton<CartDataSource>(() => CartDataSource());
  sl.registerLazySingleton<ReviewsDataSource>(() => ReviewsDataSource());
  sl.registerLazySingleton<PromoCodeDataSource>(() => PromoCodeDataSource());

  // Repository
  sl.registerLazySingleton<BaseProductsRepository>(
    () => ProductsRepository(sl<ProductDataSource>()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<BaseProductDetailsRepository>(
    () => ProductDetailsRepository(sl<ProductDetailsDataSource>()),
  );
  sl.registerLazySingleton<BaseFavRepo>(() => FavRepo(sl<FavDatasource>()));
  sl.registerLazySingleton<BaseUserRepo>(
    () => UserRepo(sl<UserSharedDatasource>()),
  );

  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl<http.Client>()),
  );
  sl.registerLazySingleton<BaseOrderRepository>(
    () => OrderRepositoryImpl(sl<OrderRemoteDataSource>()),);
  sl.registerLazySingleton<BaseCardRepository>(
    () => CartRepository(sl<CartDataSource>()),
  );
  sl.registerLazySingleton<BasePromoCodeRepository>(
    () => PromoCodeRepository(sl<PromoCodeDataSource>()),
  );

  //Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: ApiConstance.baseUrl)),
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
  sl.registerLazySingleton<BaseReviewsRepository>(
    () => ReviewsRepository(sl<ReviewsDataSource>()),
  );

  sl.registerLazySingleton<OrderRepositoryBase>(
    () => CheckOutOrderRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
}

