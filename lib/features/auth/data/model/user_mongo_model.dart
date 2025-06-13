class UserMongoModel {
  final String uid;
  final String email;
  final String? username;
  final String? phoneNumber;
  final List<String>? addresses;
  final String? image;

  UserMongoModel({
    required this.uid,
    required this.email,
    this.username,
    this.phoneNumber,
    this.addresses,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'addresses': addresses,
      'image': image,
    };
  }

  factory UserMongoModel.fromJson(Map<String, dynamic> json) {
    return UserMongoModel(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      addresses: List<String>.from(json['addresses'] ?? []),
      image: json['image'],
    );
  }
}
