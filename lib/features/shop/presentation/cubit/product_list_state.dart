import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

class ProductListLoaded extends ProductListState {
  final List<ProductModel> products;
  const ProductListLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductListError extends ProductListState {
  final String errorMessage;
  const ProductListError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
