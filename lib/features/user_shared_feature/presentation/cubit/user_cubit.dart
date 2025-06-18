import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/data/model/user_model.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/domain/repository/base_user_repo.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/domain/usecases/get_user_by_id_usecase.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  UserModel? get currentUser =>
      (state is UserLoaded) ? (state as UserLoaded).user : null;

  Future<void> getUserByUid(String userId) async {
    emit(UserLoading());
    try {
      final user = await GetUserByUidUsecase(
        sl<BaseUserRepo>(),
      ).getUserByUid(userId);
      print('User fetched SUCCESS: $user');
      emit(UserLoaded(user));
    } catch (e) {
      print('Error fetching user: $e');
      emit(UserError(e.toString()));
    }
  }
}
