class UserMongoModel {
  final String uid;
  final String? id;
  final String email;
  final String? username;
  final String? phoneNumber;
  final List<String>? addresses;
  final String? image;

  UserMongoModel({
    this.id,
    required this.uid,
    required this.email,
    this.username,
    this.phoneNumber,
    this.addresses,
    this.image,
  });

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

  factory UserMongoModel.fromJson(Map<String, dynamic> json) {
    return UserMongoModel(
      id: json['_id'].toString(),
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      addresses: List<String>.from(json['addresses'] ?? []),
      image: json['image'],
    );
  }
}
