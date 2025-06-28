import 'dart:convert';

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

      final response = await http.get(Uri.parse('http://192.168.126.44:1000/users/uid/$uid'));

      print("Response: ${response.body}");

      if (response.statusCode == 200)
       {
        
        // final Map<String, dynamic> data = json.decode(response.body);
        // print("Decoded Data: $data");
        // return ProfileModel.fromJson(data);

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

 Future<void> UpdateProfile(ProfileModel profile) async {

  String? uid;
  User? _user = await getCurrentUser();
  uid = _user?.uid;

  try
  {
   final response = await http.put(Uri.parse("http://192.168.126.44:1000/users/uid/$uid"),
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

//  Future<void> getOrdersByUserId(String userId) async {

//   String? userid;
//     User? _user = await getCurrentUser();
//     userid = _user?.id;


//     try{
//       final response = await http.get(Uri.parse('http://http://192.168.126.44:1000/user/$userId'));
//       }
//       catch (e) {
//         print('Error fetching orders: $e');
//         throw e;

//       }
//      }


Future<void> uploadImage(XFile file) async {
   String? uid;
  User? _user = await getCurrentUser();
  uid = _user?.uid;
  if (uid == null) throw Exception('User not authenticated');

  final request = http.MultipartRequest(
    'PUT',
    Uri.parse("http://192.168.126.44:1000/users/uid/$uid/image"),
  );

  request.files.add(await http.MultipartFile.fromPath('image', file.path));

  final response = await request.send();
  if (response.statusCode != 200) {
    throw Exception('Failed to upload image: ${response.statusCode}');
  }
}





}
