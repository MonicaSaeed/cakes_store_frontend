import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:cakes_store_frontend/features/profile/data/webservice/profile_mongoservice.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepository {
  final ProfileService _service = ProfileService();

  Future<ProfileModel?> getProfile() async {
   try {
      final profile = await _service.getProfileFromMongo();
      print("repo: $profile");
      return profile;
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<ProfileModel?> updateProfile(ProfileModel profile) async {

     try {
      final updateprofile = await _service.UpdateProfile(profile);
      print("updatedrepo: $profile");
     return updateprofile;

    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<void> uploadImage(XFile file) async {
    try {
      await _service.uploadImage(file);
      print("Image uploaded successfully from repo.");
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}


