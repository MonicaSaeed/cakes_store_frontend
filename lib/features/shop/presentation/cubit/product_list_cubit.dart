import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/usecase/get_product_list_use_case.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListLoading());

  ProductDataSource _dataSource = ProductDataSource();
  List<String> categories = [
    "All Items",
    "Birthday",
    "Wedding",
    "Custom",
    "Cheesecakes",
    "Cupcakes",
    "Molten Cakes",
  ];
  getProductList() async {
    try {
      final BaseProductsRepository _repo = ProductsRepository(_dataSource);
      List<ProductModel>? products =
          await GetProductListUseCase(_repo).getProductList();
      if (products != null) {
        print('from cubit $products');
        emit(ProductListLoaded(products));
      } else {
        print('in the else statement');
        emit(ProductListError('product list return with null'));
      }
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
