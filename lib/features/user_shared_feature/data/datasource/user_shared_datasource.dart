import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/model/user_model.dart';
import 'package:dio/dio.dart';

class UserSharedDatasource {
  final Dio _dio;

  UserSharedDatasource({Dio? dio})
    : _dio =
          dio ??
          Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));

  Future<UserModel> getUserByUid(String userId) async {
    try {
      // print('Fetching user with ID: $userId');
      final response = await _dio.get('${ApiConstance.usersUrl}/uid/$userId');

      if (response.statusCode == 200) {
        // print('User fetched successfully: ${response.data}');
        final userData = response.data['data'];
        print('User fetched: $userData');
        ;
        return UserModel.fromJson(userData);
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      throw Exception('Error fetching user from MongoDB: $e');
    }
  }
}
