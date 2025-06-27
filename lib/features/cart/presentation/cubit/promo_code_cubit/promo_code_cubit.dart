import 'package:cakes_store_frontend/features/cart/data/model/promo_code_model.dart';
import 'package:cakes_store_frontend/features/cart/presentation/cubit/promo_code_cubit/promo_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../data/datasource/promo_code_data_source.dart';
import '../../../data/repository/promo_code_repository.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  String promoCode;
  PromoCodeCubit({required this.promoCode}) : super(const PromoCodeInitial());

  getPromoCodeByCode() async {
    emit(const PromoCodeLoading());
    try {
      PromoCodeModel promoCodeModel = await PromoCodeRepository(
        sl<PromoCodeDataSource>(),
      ).getPromoCodeByCode(promoCode);
      if (promoCodeModel.code.isEmpty) {
        emit(const PromoCodeNotFound('Promo code not found'));
      } else {
        if (promoCodeModel.isActive) {
          emit(PromoCodeActivated(true));
          emit(PromoCodeFound(promoCodeModel));
        } else {
          emit(PromoCodeActivated(false));
        }
      }
    } on Exception catch (e) {
      if (e.toString().contains('Promo code not found')) {
        emit(const PromoCodeNotFound('Promo code not found'));
      } else {
        emit(PromoCodeError(e.toString()));
      }
    }
  }
}
