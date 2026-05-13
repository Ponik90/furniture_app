import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/cart_model.dart';
import '../../../home/data/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CartModel> _items = [];
  List<CartModel> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double get subTotal => _items.fold(0, (total, item) => total + item.totalPrice);
  double get shippingFee => _items.isEmpty ? 0 : 10.0;
  double get total => subTotal + shippingFee;

  Future<void> fetchCartItems() async {
    final user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();

      _items = snapshot.docs
          .map((doc) => CartModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint("Error fetching cart items: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(ProductModel product) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final existingIndex = _items.indexWhere((item) => item.product.id == product.id || item.product.name == product.name);

    try {
      if (existingIndex != -1) {
        _items[existingIndex].quantity++;
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .doc(_items[existingIndex].id)
            .update({'quantity': _items[existingIndex].quantity});
      } else {
        final newCartItem = CartModel(product: product);
        final docRef = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .add(newCartItem.toMap());
        
        _items.add(CartModel(
          id: docRef.id,
          product: product,
          quantity: 1,
        ));
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding to cart: $e");
    }
  }

  Future<void> removeFromCart(CartModel cartItem) async {
    final user = _auth.currentUser;
    if (user == null || cartItem.id == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItem.id)
          .delete();
      _items.removeWhere((item) => item.id == cartItem.id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error removing from cart: $e");
    }
  }

  Future<void> updateQuantity(CartModel cartItem, int newQuantity) async {
    final user = _auth.currentUser;
    if (user == null || cartItem.id == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItem.id)
          .update({'quantity': newQuantity});
      cartItem.quantity = newQuantity;
      notifyListeners();
    } catch (e) {
      debugPrint("Error updating quantity: $e");
    }
  }

  void incrementQuantity(CartModel cartItem) {
    updateQuantity(cartItem, cartItem.quantity + 1);
  }

  void decrementQuantity(CartModel cartItem) {
    if (cartItem.quantity > 1) {
      updateQuantity(cartItem, cartItem.quantity - 1);
    }
  }

  Future<void> clearCart() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();
      
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      
      _items.clear();
      notifyListeners();
    } catch (e) {
      debugPrint("Error clearing cart: $e");
    }
  }
}
