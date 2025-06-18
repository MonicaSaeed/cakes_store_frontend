class UserEntity {
  final String uid;
  final String? id;
  final String email;
  final String? username;
  final String? phoneNumber;
  final List<String>? addresses;
  final String? image;

  UserEntity({
    this.id,
    required this.uid,
    required this.email,
    this.username,
    this.phoneNumber,
    this.addresses,
    this.image,
  });
}
