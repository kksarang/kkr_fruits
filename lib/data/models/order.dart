import 'package:santhosh_bakery/data/models/cart_item.dart';

enum OrderStatus { placed, preparing, outForDelivery, delivered, cancelled }

class Order {
  final String id;
  final DateTime dateTime;
  final List<CartItem> items;
  final double totalAmount;
  final String status; // Stored as string for flexibility, mapped to UI
  final String deliveryType; // 'Home Delivery' or 'Pickup'
  final String paymentMethod;
  final String address;
  final double deliveryCharge;
  final double tax;

  Order({
    required this.id,
    required this.dateTime,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.deliveryType,
    required this.paymentMethod,
    required this.address,
    this.deliveryCharge = 0.0,
    this.tax = 0.0,
  });

  // Helper to get OrderStatus enum if needed
  OrderStatus get orderStatus {
    switch (status.toLowerCase()) {
      case 'preparing':
        return OrderStatus.preparing;
      case 'out for delivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.placed;
    }
  }
}
