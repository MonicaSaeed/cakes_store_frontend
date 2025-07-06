import 'package:bloc/bloc.dart';
import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:cakes_store_frontend/features/profile/data/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final ProfileRepository _repository;

  UserProfileCubit(this._repository) : super(UserProfileInitial());
  
  Future<void> fetchProfile() async {
    try {
      emit(UserProfileLoading());
      final profile = await _repository.getProfile();
      print("Fetched Profile: $profile");
      if (profile != null) {
        emit(UserProfileLoaded(profile));
      } else {
        emit(UserProfileError("No profile found"));
      }
    } catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    try {
      emit(UserProfileLoading());
      await _repository.updateProfile(profile);
      emit(UserProfileUpdated());
      await fetchProfile(); // Refresh data
    } 
    catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }

   Future<void> uploadImage(XFile file) async {
    try {
      emit(UserProfileLoading());
      await _repository.uploadImage(file);
      final profile = await _repository.getProfile();
      emit(UserProfileLoaded(profile!));
    } catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }



}