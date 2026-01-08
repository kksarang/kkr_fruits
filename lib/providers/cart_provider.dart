import 'package:flutter/material.dart';
import 'package:santhosh_bakery/data/models/cart_item.dart';
import 'package:santhosh_bakery/data/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items]; // Return copy

  int get itemCount => _items.length; // Number of unique items

  double get totalAmount {
    var total = 0.0;
    for (var item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  void addItem(Product product, String size, int quantity) {
    // Check if item already exists with same size
    final index = _items.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size,
    );

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          id: DateTime.now().toString(),
          product: product,
          selectedSize: size,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String cartId) {
    _items.removeWhere((item) => item.id == cartId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void updateQuantity(String cartId, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == cartId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        removeItem(cartId);
      } else {
        _items[index].quantity = newQuantity;
        notifyListeners();
      }
    }
  }
}
