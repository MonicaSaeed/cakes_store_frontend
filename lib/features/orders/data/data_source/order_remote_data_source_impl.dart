import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:cakes_store_frontend/features/orders/data/models/order_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImpl(this.client);

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    final response = await client.get(Uri.parse(ApiConstance.ordersUrl));
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        final List data = jsonResponse['data'];
        return data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        throw Exception("Server responded with failure");
      }
    
  }
}
