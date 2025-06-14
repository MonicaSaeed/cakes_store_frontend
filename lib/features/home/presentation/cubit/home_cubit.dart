import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../shared_product/domain/entities/product.dart';
import '../../domain/usecases/get_all_products_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  HomeCubit(this.getAllProductsUseCase) : super(HomeInitial());

  void fetchProducts() async {
    emit(HomeLoading());
    try {
      final products = await getAllProductsUseCase();
      emit(HomeLoaded(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
