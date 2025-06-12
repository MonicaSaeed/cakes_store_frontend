import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';

class ProductDataSource {
  Future<List<ProductModel>> getProductList() async {
    final response = await http.get(
      Uri.parse('http://localhost:1000/products'),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<ProductModel>.from(
        (decoded['data'] as List).map((e) => ProductModel.fromJson(e)),
      );
    } else {
      throw Exception('Failed to get products');
    }
  }
}
