import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/shop/data/datasource/product_data_source.dart';
import 'package:cakes_store_frontend/features/shop/data/repository/products_repository.dart';
import 'package:cakes_store_frontend/features/shop/domain/repository/base_products_repository.dart';
import 'package:cakes_store_frontend/features/favorites/domain/usecases/add_to_fav_usecase.dart'
    show AddToFavUsecase;
import 'package:cakes_store_frontend/features/favorites/domain/usecases/get_all_favs_usecase.dart';
import 'package:cakes_store_frontend/features/shop/domain/usecase/get_product_list_use_case.dart';
import 'package:cakes_store_frontend/features/favorites/domain/usecases/remove_from_fav_usecase.dart';
import 'package:cakes_store_frontend/features/shop/presentation/cubit/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  // for pagination
  int _page = 1;
  bool _isFetching = false;
  final int _pageSize = 10;

  final String? userId;
  ProductListCubit({this.userId}) : super(ProductListInitial());
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

  String _searchQuery = '';

  // Add this getter
  String get searchQuery => _searchQuery;

  // Add this method
  void setSearchQuery(String query) {
    _searchQuery = query;
    filterbody['search'] = query; // Add to filter body
    getfilteredProductList();
  }

  void clearSearch() {
    _searchQuery = '';
    filterbody.remove('search');
    getfilteredProductList();
  }

  List<ProductModel> _allProducts = [];

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
        print('from cubit ${products}');
        // filterbody = {};
        emit(
          ProductListLoaded(
            products: filteredProducts,
            categories: categories,
            filterSortOptions: filterSortOptions,
          ),
        );
      } else {
        print('in the else statement');
        emit(ProductListError('product list return with null'));
      }
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }

  // int _currentPage = 1;
  // final int _itemsPerPage = 10;
  // int _totalItems = 0;
  // int get currentPage => _currentPage;
  // int get totalPages => (_totalItems / _itemsPerPage).ceil();

  // Future<void> goToPage(int page) async {
  //   if (page == _currentPage) return;
  //   _currentPage = page;
  //   await getfilteredProductList();
  // }
}
