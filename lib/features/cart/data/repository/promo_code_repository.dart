import 'package:cakes_store_frontend/features/cart/data/model/promo_code_model.dart';
import 'package:cakes_store_frontend/features/cart/domain/repository/base_promo_code_repository.dart';

import '../datasource/promo_code_data_source.dart';

class PromoCodeRepository extends BasePromoCodeRepository {
  final PromoCodeDataSource _promoCodeDataSource;
  PromoCodeRepository(this._promoCodeDataSource);
  @override
  Future<PromoCodeModel> getPromoCodeByCode(String code) async {
    try {
      return await _promoCodeDataSource.getPromoCodeByCode(code);
    } on Exception catch (e) {
      if (e.toString().contains('Promo code not found')) {
        throw Exception('Promo code not found');
      } else {
        throw Exception('Failed to get promo code: ${e.toString()}');
      }
    }
  }
}
