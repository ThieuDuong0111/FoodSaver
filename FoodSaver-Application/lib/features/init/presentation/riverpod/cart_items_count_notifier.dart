import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemsCountNotifier extends ChangeNotifier {
  CartItemsCountNotifier();

  static final provider = ChangeNotifierProvider<CartItemsCountNotifier>((ref) {
    return CartItemsCountNotifier();
  });
  int _cartItemsCount = 0;
  int get cartItemsCount => _cartItemsCount;

  Future<void> setCartItemsCount(int cartItemsCount) async {
    _cartItemsCount = cartItemsCount;
    notifyListeners();
  }
}
