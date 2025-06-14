import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import '../../../shared_product/data/models/product_model.dart';

abstract class BaseHomeRemoteDatasource {
  Future<List<ProductModel>> getAllProducts();
}

class HomeRemoteDatasource implements BaseHomeRemoteDatasource {
  final Dio dio;

  HomeRemoteDatasource(this.dio);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get('${ApiConstance.productsUrl}/');

      final data = response.data['data'] as List;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to get products: $e");
    }
  }
}
