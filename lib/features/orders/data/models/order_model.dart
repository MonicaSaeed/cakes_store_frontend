import 'package:cakes_store_frontend/features/orders/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.userId,
    required super.orderItems,
    required super.orderStatus,
    required super.totalPrice,
    required super.promoCodeApplied,
    required super.discountApplied,
    required super.shippingAddress,
    super.deliveryDate,
    required super.paymentStatus,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      userId: json['userId'],
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      orderStatus: json['orderStatus'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      promoCodeApplied: json['promoCodeApplied'],
      discountApplied: json['discountApplied'] != null
    ? (json['discountApplied'] as num).toDouble()
    : null,
      shippingAddress: json['shippingAddress'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.tryParse(json['deliveryDate'])
          : null,
      paymentStatus: json['paymentStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    required super.productId,
    required super.quantity,
    required super.unitPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );
  }
}
