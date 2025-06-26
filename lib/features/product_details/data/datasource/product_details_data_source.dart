import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

import '../../../shared_product/data/models/product_model.dart';

class ProductDetailsDataSource {
  final Dio _dio;

  ProductDetailsDataSource({Dio? dio})
    : _dio =
          dio ??
          Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));

  Future<ProductModel> getProduct(String productId, String? userId) async {
    final response = await _dio.get(
      '${ApiConstance.productsUrl}/$productId',
      data: {'userId': userId},
    );

    if (response.statusCode == 200) {
      final decoded = response.data;
      return ProductModel.fromJson(decoded['data']);
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to get product from datasource');
    }
  }
}
