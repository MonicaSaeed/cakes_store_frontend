import 'package:cakes_store_frontend/features/user_shared_feature/data/model/user_model.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/repository/user_repo.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/domain/repository/base_user_repo.dart';

class GetUserByUidUsecase {
  final BaseUserRepo _userRepository;

  GetUserByUidUsecase(this._userRepository);

  Future<UserModel> getUserByUid(String userId) async {
    return await _userRepository.getUserByUid(userId);
  }
}
