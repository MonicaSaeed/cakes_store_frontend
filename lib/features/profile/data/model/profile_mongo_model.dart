class ProfileModel {
  final String uid;
  final String email;
  final String? username;
  final String? phoneNumber;
  final List<String>? addresses;
  final String? image;

  ProfileModel({
    required this.uid,
    required this.email,
    this.username,
    this.phoneNumber,
    this.addresses,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phoneNumber': phoneNumber,
      'addresses': addresses,
      'image': image,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      image: json['image'] as String?,
    );
  }

  ProfileModel copyWith({
    String? username,
    String? email,
    String? phoneNumber,
    List<String>? addresses,
    String? image,
  }) {
    return ProfileModel(
      uid: uid,
     email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addresses: addresses ?? this.addresses,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [uid, email, username, phoneNumber, addresses, image];


    @override
  String toString() {
    return 'ProfileModel(username: $username, email: $email, phoneNumber: $phoneNumber, addresses: $addresses)';
  }
}