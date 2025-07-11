import 'package:cakes_store_frontend/features/orders/domain/repos/base_order_repository.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/products_cubit/products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  final BaseOrderRepository orderRepository;

  ProductCubit(this.orderRepository) : super(ProductInitial());

  Future<void> fetchProduct(String productId) async {
    try {
      emit(ProductLoading());
      final product = await orderRepository.getProductById(productId);
      //log('from ProductCubit :$product');
      if (!isClosed) {
        emit(ProductLoaded(product));
      }
    } catch (e) {
      //log('From ProductCubit error : $e , productID : $productId');
      if (!isClosed) {
        emit(ProductError('Failed to load product'));
      }
    }
  }
}
