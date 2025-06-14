import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/usecase/get_product_list_use_case.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());
  int selectedCategory = 0;
  int selectedSortfilter = 0;
  List<String> categories = [
    "All Items",
    "Birthday",
    "Wedding",
    "Custom",
    "Cheesecakes",
    "Cupcakes",
    "Molten Cakes",
  ];
  List<String> filterSortOptions = [
    "Newest First",
    "Price: Low to High",
    "Price: High to Low",
    "Customer Ratings",
  ];
  List<ProductModel> filteredProducts = [];
  var filterbody = {};
  getfilteredProductList() async {
    emit(ProductListLoading());
    try {
      List<ProductModel>? products = await GetProductListUseCase(
        sl<BaseProductsRepository>(),
      ).getfilteredProductList(filterbody);
      if (products != null) {
        filteredProducts = products;
        print('from cubit $products');
        // filterbody = {};
        emit(ProductListLoaded(filteredProducts));
      } else {
        print('in the else statement');
        emit(ProductListError('product list return with null'));
      }
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
