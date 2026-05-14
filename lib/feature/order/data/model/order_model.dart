import '../../../cart/data/model/cart_model.dart';

class OrderModel {
  final String? id;
  final List<CartModel> items;
  final double totalAmount;
  final DateTime orderDate;
  final String status; // Pending, Processing, Shipped, Delivered, Cancelled
  final String paymentId;

  OrderModel({
    this.id,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.status = "Processing",
    required this.paymentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
      'paymentId': paymentId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      id: id,
      items: List<CartModel>.from(
        (map['items'] as List).map((x) => CartModel.fromMap(x, '')),
      ),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      orderDate: DateTime.parse(map['orderDate']),
      status: map['status'] ?? "Processing",
      paymentId: map['paymentId'] ?? "",
    );
  }
}
