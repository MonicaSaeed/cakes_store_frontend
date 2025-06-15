import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../shared_product/domain/entities/product.dart';
import '../../domain/usecases/get_all_products_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  HomeCubit(this.getAllProductsUseCase) : super(HomeInitial());

  late final Product? latestProduct;

  void fetchProducts() async {
    if (!isClosed) emit(HomeLoading());
    try {
      final products = await getAllProductsUseCase();
      final sortedProdcts = List<Product>.from(products)
        ..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      latestProduct = sortedProdcts.isNotEmpty ? sortedProdcts.first : null;
      if (!isClosed) emit(HomeLoaded(sortedProdcts));
    } catch (e) {
      if (!isClosed) emit(HomeError(e.toString()));
    }
  }
}
