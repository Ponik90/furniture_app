import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  double _balance = 0.0;
  double get balance => _balance;

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  void addBalance(double amount) {
    _balance += amount;
    notifyListeners();
  }

  Future<void> processRazorpayPayment(double amount) async {
    _isProcessing = true;
    notifyListeners();

    // Mocking Razorpay payment process
    await Future.delayed(const Duration(seconds: 2));
    
    // In a real implementation, you would use razorpay_flutter package here
    // and call _razorpay.open(options)
    
    addBalance(amount);
    
    _isProcessing = false;
    notifyListeners();
  }
}
