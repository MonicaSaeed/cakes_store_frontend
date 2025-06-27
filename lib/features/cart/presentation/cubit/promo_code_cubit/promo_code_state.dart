import 'package:cakes_store_frontend/features/cart/data/model/promo_code_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class PromoCodeState extends Equatable {
  const PromoCodeState();

  @override
  List<Object?> get props => [];
}

class PromoCodeInitial extends PromoCodeState {
  const PromoCodeInitial();
}

class PromoCodeLoading extends PromoCodeState {
  const PromoCodeLoading();
}

class PromoCodeFound extends PromoCodeState {
  final PromoCodeModel promoCode;
  const PromoCodeFound(this.promoCode);
  @override
  List<Object?> get props => [promoCode];
}

class PromoCodeActivated extends PromoCodeState {
  final bool isActive;
  const PromoCodeActivated(this.isActive);
  @override
  List<Object?> get props => [isActive];
}

class PromoCodeNotFound extends PromoCodeState {
  final String errorMessage;
  const PromoCodeNotFound(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class PromoCodeError extends PromoCodeState {
  final String errorMessage;
  const PromoCodeError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
