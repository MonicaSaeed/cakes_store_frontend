import 'package:cakes_store_frontend/features/product_details/domain/usecase/get_product_details_use_case.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared_product/data/models/product_model.dart';
import '../../data/datasource/product_details_data_source.dart';
import '../../data/repository/product_details_repository.dart';
import '../../domain/repository/base_product_details_repository.dart';

class ProductListCubit extends Cubit<ProductDetailsState> {
  ProductListCubit() : super(const ProductDetailsLoading());

  ProductDetailsDataSource _dataSource = ProductDetailsDataSource();
  getProduct(String productId) async {
    try {
      emit(const ProductDetailsLoading());
      final BaseProductDetailsRepository _repo = ProductDetailsRepository(
        _dataSource,
      );
      ProductModel? product = await GetProductDetailsUseCase(
        _repo,
      ).getProduct(productId);

      if (product != null) {
        emit(ProductDetailsLoaded(product));
      } else {
        emit(ProductDetailsError('Product details returned null'));
      }
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
