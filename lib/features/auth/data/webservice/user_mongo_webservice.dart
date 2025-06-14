import 'package:dio/dio.dart';
import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/auth/data/model/user_mongo_model.dart';

class UserMongoWebService {
  final Dio _dio;

  UserMongoWebService({Dio? dio})
    : _dio =
          dio ??
          Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));

  Future<void> saveUserToMongo(UserMongoModel user) async {
    try {
      final response = await _dio.post(
        ApiConstance.usersUrl,
        data: user.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to save user');
      }
    } catch (e) {
      throw Exception('Error saving user to MongoDB: $e');
    }
  }
}
