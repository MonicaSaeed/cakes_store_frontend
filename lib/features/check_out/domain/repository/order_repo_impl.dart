import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/check_out/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/check_out/data/repo/order_repo_base.dart';
import 'package:cakes_store_frontend/features/orders/data/models/order_model.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOutOrderRepositoryImpl implements OrderRepositoryBase {
  final http.Client client;

  CheckOutOrderRepositoryImpl(this.client);

  @override
  Future<OrderEntity> placeOrder(Order order) async {
    final url = Uri.parse(ApiConstance.ordersUrl);

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to place order: ${response.body}');
    }

    final responseBody = jsonDecode(response.body);
    final orderData = responseBody['data'];

    return OrderModel.fromJson(orderData); // You must implement this
  }

  @override
  Future<void> clearCart(String userId) async {
    final url = Uri.parse('${ApiConstance.cartUrl}/$userId');
    final response = await client.delete(url);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to clear cart !! .. : ${response.body}');
    }
  }
}
