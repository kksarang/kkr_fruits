import 'package:santhosh_bakery/data/models/product.dart';

class CartItem {
  final String id;
  final Product product;
  final String selectedSize; // Small, Medium, Large
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.selectedSize,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
