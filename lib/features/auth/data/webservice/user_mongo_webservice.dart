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

  Future<UserMongoModel> getUserByUid(String userId) async {
    try {
      print('Fetching user with ID: $userId');
      final response = await _dio.get('${ApiConstance.usersUrl}/uid/$userId');

      if (response.statusCode == 200) {
        print('User fetched successfully: ${response.data}');
        final userData = response.data['data'];
        return UserMongoModel.fromJson(userData);
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      throw Exception('Error fetching user from MongoDB: $e');
    }
  }
}
