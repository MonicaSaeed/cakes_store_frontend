import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';

abstract class ProductStates {}

class ProductInitial extends ProductStates {}

class ProductLoading extends ProductStates {}

class ProductLoaded extends ProductStates {
  final ProductEntity product;
  ProductLoaded(this.product);
}

class ProductError extends ProductStates {
  final String message;
  ProductError(this.message);
}
