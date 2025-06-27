class UserReviewsDataModel {
  final String id;
  final String username;
  final String? image;

  UserReviewsDataModel({required this.id, required this.username, this.image});

  factory UserReviewsDataModel.fromJson(Map<String, dynamic> json) {
    return UserReviewsDataModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      image: json['image'] as String?,
    );
  }
}
