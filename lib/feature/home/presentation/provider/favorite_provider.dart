import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => _favorites;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();

      _favorites = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint("Error fetching favorites: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(ProductModel product) {
    return _favorites.any((item) => item.id == product.id || item.name == product.name);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final existingIndex = _favorites.indexWhere((item) => item.id == product.id || item.name == product.name);

    try {
      if (existingIndex != -1) {
        final docId = _favorites[existingIndex].id;
        if (docId != null) {
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('favorites')
              .doc(docId)
              .delete();
        }
        _favorites.removeAt(existingIndex);
      } else {
        final docRef = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .add(product.toMap());
        
        // Add locally with the new ID
        _favorites.add(ProductModel(
          id: docRef.id,
          name: product.name,
          image: product.image,
          price: product.price,
          rating: product.rating,
          category: product.category,
          description: product.description,
        ));
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error toggling favorite: $e");
    }
  }
}
