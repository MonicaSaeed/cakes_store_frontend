class PromoCodeModel {
  final String id;
  final String code;
  final int discountPercentage;
  final DateTime validUntil;
  final bool isActive;

  PromoCodeModel({
    required this.id,
    required this.code,
    required this.discountPercentage,
    required this.validUntil,
    required this.isActive,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      id: json['_id'],
      code: json['code'],
      discountPercentage: json['discountPercentage'],
      validUntil: DateTime.parse(json['validUntil']),
      isActive: json['isActive'],
    );
  }
}
