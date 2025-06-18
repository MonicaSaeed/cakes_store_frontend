import 'package:cakes_store_frontend/features/user_shared_feature/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    String? id,
    required String uid,
    required String email,
    String? username,
    String? phoneNumber,
    List<String>? addresses,
    String? image,
  }) : super(
         id: id,
         uid: uid,
         email: email,
         username: username,
         phoneNumber: phoneNumber,
         addresses: addresses,
         image: image,
       );

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'addresses': addresses,
      'image': image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'].toString(),
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      addresses: List<String>.from(json['addresses'] ?? []),
      image: json['image'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, uid: $uid, email: $email, username: $username, phoneNumber: $phoneNumber, addresses: $addresses, image: $image)';
  }
}
