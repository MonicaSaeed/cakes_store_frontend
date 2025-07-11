import 'dart:convert';
import 'dart:developer';
import 'package:cakes_store_frontend/features/orders/data/models/product_model.dart';
import 'package:cakes_store_frontend/features/orders/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:cakes_store_frontend/features/orders/data/models/order_model.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImpl(this.client);

  @override
  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final response = await client.get(
        Uri.parse("${ApiConstance.ordersUrl}/user/$userId"),
      );
      log("${ApiConstance.ordersUrl}/user/$userId");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          final List data = jsonResponse['data'];
          return data.map((e) => OrderModel.fromJson(e)).toList();
        } else {
          throw Exception(
            "Failed to fetch user orders: ${jsonResponse['message'] ?? 'Unknown error'}",
          );
        }
      } else {
        throw Exception(
          "Failed to fetch user orders: Server responded with status code ${response.statusCode} and body: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("An error occurred while fetching user orders: $e");
    }
  }

  @override
  Future<ProductEntity> getProductById(String productId) async {
    final response = await client.get(
      Uri.parse("${ApiConstance.productsUrl}/$productId"),
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<void> cancelOrder(String orderId) async {
    final response = await client.patch(
      Uri.parse("${ApiConstance.ordersUrl}/orderStatus/$orderId"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"orderStatus": "Canceled"}),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to Cancel Order');
    }
  }
}
