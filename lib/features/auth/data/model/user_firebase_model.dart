class UserFirebaseModel {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String password;

  UserFirebaseModel({
    this.uid = '',
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    this.password = '',
  });

  factory UserFirebaseModel.fromJson(Map<String, dynamic> json) {
    return UserFirebaseModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      password: json['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'password': password,
    };
  }

  UserFirebaseModel copyWith({
    String? uid,
    String? email,
    String? phone,
    String? name,
    String? password,
    String? address,
  }) {
    return UserFirebaseModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      password: password ?? this.password,
    );
  }
}
