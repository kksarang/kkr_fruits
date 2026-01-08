import 'package:flutter/material.dart';
import 'package:santhosh_bakery/data/models/cart_item.dart';
import 'package:santhosh_bakery/data/models/order.dart';
import 'package:santhosh_bakery/data/models/product.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _orders = [
    // Dummy Data for History
    Order(
      id: 'ORD-2026-003',
      dateTime: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
      items: [
        CartItem(
          id: 'item1',
          product: Product(
            id: 'c1',
            name: 'Black Forest Cake',
            description: 'Delicious cake',
            price: 550.0,
            imageUrl:
                'https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
            category: 'Cakes',
            rating: 4.8,
            reviewCount: 120,
          ),
          selectedSize: '1 kg',
          quantity: 1,
        ),
      ],
      totalAmount: 550.0,
      status: 'Delivered',
      deliveryType: 'Home Delivery',
      paymentMethod: 'UPI',
      address: '123, Gandhi Street, Coimbatore - 641012',
      deliveryCharge: 40.0,
    ),
    Order(
      id: 'ORD-2026-002',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      items: [
        CartItem(
          id: 'item2',
          product: Product(
            id: 's1',
            name: 'Kerala Puffs',
            description: 'Spicy chicken puffs',
            price: 25.0,
            imageUrl:
                'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
            category: 'Snacks',
            rating: 4.5,
            reviewCount: 50,
          ),
          selectedSize: 'Medium',
          quantity: 4,
        ),
      ],
      totalAmount: 100.0,
      status: 'Cancelled',
      deliveryType: 'Pickup',
      paymentMethod: 'Cash',
      address: 'Pickup from RS Puram Branch',
    ),
  ];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
  }
}
