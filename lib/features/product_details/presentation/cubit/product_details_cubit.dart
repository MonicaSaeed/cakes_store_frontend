import 'package:cakes_store_frontend/features/product_details/domain/usecase/get_product_details_use_case.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../shared_product/data/models/product_model.dart';
import '../../domain/repository/base_product_details_repository.dart';

class ProductListCubit extends Cubit<ProductDetailsState> {
  ProductListCubit({required userId}) : super(const ProductDetailsLoading());

  getProduct(String productId) async {
    try {
      emit(const ProductDetailsLoading());
      ProductModel? product = await GetProductDetailsUseCase(
        sl<BaseProductDetailsRepository>(),
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
