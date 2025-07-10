part of 'cart_cubit.dart';

@immutable
sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String errorMessage;

  const CartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AddCartError extends CartState {
  final String errorMessage;

  const AddCartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class CartEmpty extends CartState {
  const CartEmpty();

  @override
  List<Object?> get props => [];
}
