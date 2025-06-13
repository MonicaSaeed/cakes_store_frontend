import 'dart:convert';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../../shared_product/data/models/product_model.dart';

class ProductDetailsDataSource {
  Future<ProductModel> getProduct(String productId) async {
    final response = await http.get(
      Uri.parse('${ApiConstance.productsUrl}/$productId'),
    );
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ProductModel.fromJson(decoded['data']);
      print('Product details: ${decoded['data'].name}');
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to get product from datasource');
    }
  }
}
