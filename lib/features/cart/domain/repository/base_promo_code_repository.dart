import 'package:cakes_store_frontend/features/cart/data/model/promo_code_model.dart';

abstract class BasePromoCodeRepository {
  Future<PromoCodeModel> getPromoCodeByCode(String code);
}
