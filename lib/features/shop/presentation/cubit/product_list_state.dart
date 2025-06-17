import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {}

class ProductListError extends ProductListState {
  final String errorMessage;
  const ProductListError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class ProductListLoaded extends ProductListState {
  final List<ProductModel> products;
  final List<String> categories;
  final List<String> filterSortOptions;
  final bool hasMore;
  final bool isLoadingMore;
  const ProductListLoaded({
    required this.products,
    required this.categories,
    required this.filterSortOptions,
    required this.hasMore,
    required this.isLoadingMore,
  });

  ProductListLoaded copyWith({
    List<ProductModel>? products,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      categories: this.categories,
      filterSortOptions: this.filterSortOptions,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [products, categories, filterSortOptions];
}
