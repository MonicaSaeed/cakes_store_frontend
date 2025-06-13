import 'package:equatable/equatable.dart';

import '../../../shared_product/data/models/product_model.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object?> get props => [];
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;
  const ProductDetailsLoaded(this.product);
  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final String errorMessage;
  const ProductDetailsError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
