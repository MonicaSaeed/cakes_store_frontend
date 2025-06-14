import 'dart:convert';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

class ProductDataSource {
  Future<List<ProductModel>> getfilteredProductList(filterbody) async {
    final response = await http.post(
      Uri.parse('${ApiConstance.productsUrl}/filter'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(filterbody),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<ProductModel>.from(
        (decoded['data'] as List).map((e) => ProductModel.fromJson(e)),
      );
    } else {
      print(response.body);
      throw Exception('Failed to get products from datasource ');
    }
  }
}
