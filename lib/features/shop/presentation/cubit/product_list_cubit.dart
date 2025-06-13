import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/usecase/get_product_list_use_case.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListLoading());

  // ProductDataSource _dataSource = ProductDataSource();
  getProductList() async {
    try {
      // final BaseProductsRepository _repo = ProductsRepository(_dataSource);
      List<ProductModel>? products =
          await GetProductListUseCase(
            sl<BaseProductsRepository>(),
          ).getProductList();

      if (products != null) {
        print('from cubit $products');
        emit(ProductListLoaded(products));
      } else {
        emit(ProductListError('product list return with null'));
      }
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
