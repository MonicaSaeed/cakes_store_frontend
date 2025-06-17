import 'package:cakes_store_frontend/features/user_shared_feature/data/datasource/user_shared_datasource.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/model/user_model.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/domain/repository/base_user_repo.dart';

class UserRepo extends BaseUserRepo {
  final UserSharedDatasource _userSharedDatasource;
  UserRepo(this._userSharedDatasource);

  @override
  Future<UserModel> getUserByUid(String userId) {
    return _userSharedDatasource.getUserByUid(userId);
  }
}
