class OrderEntity {
  final String id;
  final String userId;
  final List<OrderItemEntity> orderItems;
  final String orderStatus;
  final double totalPrice;
  final String promoCodeApplied;
  final double discountApplied;
  final String shippingAddress;
  final DateTime? deliveryDate;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.orderStatus,
    required this.totalPrice,
    required this.promoCodeApplied,
    required this.discountApplied,
    required this.shippingAddress,
    this.deliveryDate,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });
}

class OrderItemEntity {
  final String productId;
  final int quantity;
  final double unitPrice;

  OrderItemEntity({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });
}
