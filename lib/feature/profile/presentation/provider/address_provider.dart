import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/address_model.dart';

class AddressProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<AddressModel> _addresses = [];
  List<AddressModel> get addresses => _addresses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchAddresses() async {
    final user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .get();

      _addresses = snapshot.docs
          .map((doc) => AddressModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint("Error fetching addresses: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAddress(AddressModel address) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .add(address.toMap());
      await fetchAddresses();
    } catch (e) {
      debugPrint("Error adding address: $e");
      rethrow;
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    final user = _auth.currentUser;
    if (user == null || address.id == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .doc(address.id)
          .update(address.toMap());
      await fetchAddresses();
    } catch (e) {
      debugPrint("Error updating address: $e");
      rethrow;
    }
  }

  Future<void> deleteAddress(String id) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .doc(id)
          .delete();
      await fetchAddresses();
    } catch (e) {
      debugPrint("Error deleting address: $e");
    }
  }
}
