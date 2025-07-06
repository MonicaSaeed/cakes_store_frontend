import 'dart:convert';

import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class ProfileService {
  
  ProfileService._internal();
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }


  Future<ProfileModel?> getProfileFromMongo() async {
    try {
      User? _user = await getCurrentUser();
      String? uid = _user?.uid;

      print("Current User ID: $uid");

      final response = await http.get(Uri.parse('${ApiConstance.usersUrl}/uid/$uid'));

      print("Response: ${response.body}");

      if (response.statusCode == 200)
       {
        
final Map<String, dynamic> responseData = json.decode(response.body);
final Map<String, dynamic> userData = responseData['data'];
print("Decoded Data: $userData");
return ProfileModel.fromJson(userData); 

      } 
      else
       {
        throw Exception('Failed to fetch profile');
      }
    } catch (e) {
      print('Profile fetch error: $e');
      rethrow;
    }
  }

 Future<ProfileModel?> UpdateProfile(ProfileModel profile) async {

  String? uid;
  User? _user = await getCurrentUser();
  uid = _user?.uid;

  try
  {
    print("📤 Sent body: ${json.encode(profile.toJson())}");
    print("Updating profile for user ID: $uid");

    final response = await http.put(
  Uri.parse('${ApiConstance.usersUrl}/uid/$uid'),
  headers: {"Content-Type": "application/json"},
  body: json.encode(profile.toJson()),
);


    if (response.statusCode != 200) {
      throw Exception("Failed to update profile"+ " ${response.statusCode}");
    }}
    catch (e) {
      print("Error updating profile: $e");
      throw e;
    }
  }

Future<void> uploadImage(XFile file) async {
  final user = await getCurrentUser();
  final uid = user?.uid;
  if (uid == null) throw Exception('User not authenticated');

  final uri = Uri.parse("${ApiConstance.usersUrl}/uid/$uid/image");
  final request = http.MultipartRequest('PUT', uri);

  final fileName = file.name;

  // Must match multer field name: 'image'
  request.files.add(await http.MultipartFile.fromPath(
    'image',
    file.path,
    filename: fileName, // original name
  ));

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode != 200) {
    throw Exception('Failed to upload image: ${response.statusCode} \n${response.body}');
  } 
}
}


