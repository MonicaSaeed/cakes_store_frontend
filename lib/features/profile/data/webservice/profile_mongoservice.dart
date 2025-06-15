import 'dart:convert';

import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ProfileService {

  User? currentuser;
  List<ProfileModel>? allusers;

  
  ProfileService._internal();
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


    Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }


Future<ProfileModel?> getProfileFromMongo() async {
  
  String? uid;
  User? _user = await getCurrentUser();
  uid = _user?.uid;

 try
 { 
  final response = await http.get(Uri.parse('http://localhost:1000/users/$uid'));

   if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return ProfileModel.fromJson(data);
  } 
  else 
  {
    throw Exception("Profile not found");
  }
  }catch (e) {
    print("Error fetching profile: $e");
    return null;
  }

}

 Future<void> UpdateProfile(ProfileModel profile) async {

  try
  {
   final response = await http.put(Uri.parse("http://localhost:1000/users/uid/${profile.uid}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(profile.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update profile");
    }}
    catch (e) {
      print("Error updating profile: $e");
      throw e;
    }
  }

}