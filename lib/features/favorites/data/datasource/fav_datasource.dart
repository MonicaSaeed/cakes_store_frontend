import 'dart:convert';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/shared_product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class FavDatasource {
  Future<void> addToFav(String productId, String userId) async {
    final response = await http.post(
      // :userId/add/:productId
      Uri.parse('${ApiConstance.favsUrl}/$userId/add/$productId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userId",
      },
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to add product to favorites');
    }
  }

  Future<void> removeFromFav(String productId, String userId) async {
    final response = await http.delete(
      // :userId/remove/:productId
      Uri.parse('${ApiConstance.favsUrl}/$userId/remove/$productId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userId",
      },
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to remove product from favorites');
    }
  }

  Future<List<ProductModel>> getAllFavs(String userId) async {
    final response = await http.get(
      // :userId
      Uri.parse('${ApiConstance.favsUrl}/$userId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userId",
      },
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<ProductModel>.from(
        (decoded['data'] as List).map((e) => ProductModel.fromJson(e)),
      );
    } else {
      print(response.body);
      throw Exception('Failed to get favorites from datasource');
    }
  }
}
