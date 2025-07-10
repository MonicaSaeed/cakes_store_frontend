import 'package:cakes_store_frontend/features/check_out/data/models/order_item.dart';

class Order {
  final String userId;
  final List<OrderItem> orderItems;
  final double totalPrice;
  final String? promoCodeApplied;
  final double? discountApplied;
  final String shippingAddress;

  Order({
    required this.userId,
    required this.orderItems,
    required this.totalPrice,
    required this.shippingAddress,
    this.promoCodeApplied,
    this.discountApplied,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "orderItems": orderItems.map((item) => item.toJson()).toList(),
      "totalPrice": totalPrice,
      "promoCodeApplied": promoCodeApplied,
      "discountApplied": discountApplied,
      "shippingAddress": shippingAddress,
    };
  }
}
