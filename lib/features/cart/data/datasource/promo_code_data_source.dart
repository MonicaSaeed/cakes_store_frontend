import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../model/promo_code_model.dart';

class PromoCodeDataSource {
  Future<PromoCodeModel> getPromoCodeByCode(String code) async {
    final response = await http.get(
      Uri.parse('${ApiConstance.promocodesUrl}/code/$code'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final promoCodeJson = decoded['data'];
      return PromoCodeModel.fromJson(promoCodeJson);
    } else if (response.statusCode == 404) {
      throw Exception('Promo code not found');
    } else {
      throw Exception('Failed to apply promo code');
    }
  }
}
