import 'package:cakes_store_frontend/features/user_shared_feature/data/model/user_model.dart';

abstract class BaseUserRepo {
  Future<UserModel> getUserByUid(String userId);
}
