import 'dart:convert';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';
import 'package:http/http.dart' as http;

class CartDataSource {
  Future<CartModel> getCartItems(String? userId) async {
    final response = await http.get(
      // Should use GET, not POST
      Uri.parse('${ApiConstance.cartUrl}/$userId'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final cartJson = decoded['data'];
      return CartModel.fromJson(cartJson);
    } else if (response.statusCode == 404) {
      throw Exception('Cart not found');
    } else {
      throw Exception('Failed to get cart items from data source');
    }
  }

  Future<Map<String, dynamic>> addCartItem(
    String userId,
    String productId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstance.cartUrl}/$userId/add/$productId'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        if (errorResponse.containsKey('message')) {
          throw Exception(errorResponse['message']);
        } else {
          throw Exception('Failed to add cart item');
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
