import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object?> get props => [];
}

class FavInitial extends FavState {
  const FavInitial();
}

class FavLoading extends FavState {}

class FavError extends FavState {
  final String errorMessage;

  const FavError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FavLoaded extends FavState {
  final List<ProductModel> favProducts;

  const FavLoaded({required  this.favProducts });

  @override
  List<Object?> get props => [favProducts];
}
