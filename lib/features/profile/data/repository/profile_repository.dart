import '../webservice/profile_mongoservice.dart';
import '../model/profile_mongo_model.dart';

class ProfileRepository {
  final ProfileService _service = ProfileService();

  Future<ProfileModel?> getProfile() => _service.getProfileFromMongo();
  Future<void> updateProfile(ProfileModel profile) => _service.UpdateProfile(profile);
}
