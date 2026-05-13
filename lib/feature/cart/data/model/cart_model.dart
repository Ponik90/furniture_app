import '../../../home/data/model/product_model.dart';

class CartModel {
  final String? id;
  final ProductModel product;
  int quantity;

  CartModel({
    this.id,
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'productId': product.id,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map, String id) {
    return CartModel(
      id: id,
      product: ProductModel.fromMap(map['product'], map['productId'] ?? ''),
      quantity: map['quantity'] ?? 1,
    );
  }
}
