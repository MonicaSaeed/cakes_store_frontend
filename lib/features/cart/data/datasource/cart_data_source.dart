import 'dart:convert';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/cart/data/model/cart_model.dart';
import 'package:http/http.dart' as http;

class CartDataSource {
  Future<CartModel> getCartItems() async {
    final String userId =
        '68508f5a0814cbd9ddac2997'; // Replace with actual user ID logic

    final response = await http.get(
      // Should use GET, not POST
      Uri.parse('${ApiConstance.cartUrl}/$userId'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final cartJson = decoded['data'];
      print('Cart JSON: $cartJson'); // Debugging line to check the response
      return CartModel.fromJson(cartJson);
    } else if (response.statusCode == 404) {
      throw Exception('Cart not found');
    } else {
      throw Exception('Failed to get cart items from data source');
    }
  }
}
