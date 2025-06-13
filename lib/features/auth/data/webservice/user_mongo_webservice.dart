import 'package:dio/dio.dart';
import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/auth/data/model/user_mongo_model.dart';

class UserMongoWebService {
  final Dio _dio;

  UserMongoWebService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstance.baseUrl, // Add this to your ApiConstance
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Content-Type': 'application/json'},
            ),
          ) {
    // Add interceptors for better logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Sending request to ${options.uri}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print('Error occurred: ${e.message}');
          print('Response: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<void> saveUserToMongo(UserMongoModel user) async {
    try {
      print('Attempting to store user in MongoDB: ${user.uid}');

      final response = await _dio.post(
        ApiConstance.usersUrl, // Changed from usersUrl to usersEndpoint
        data: user.toJson(),
      );

      print('MongoDB storage successful: ${response.data}');

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw _parseError(response);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Exception _parseError(Response response) {
    final errorData = response.data;
    final message =
        errorData is Map
            ? errorData['message'] ?? 'Failed to save user to MongoDB'
            : 'Server responded with status ${response.statusCode}';

    return Exception(message);
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection to server timed out');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('Server response timed out');
    } else if (e.response != null) {
      return _parseError(e.response!);
    } else {
      return Exception('Network error occurred: ${e.message}');
    }
  }
}
