import 'dart:async';
import '../models/order.dart';

class OrderRepository {
  Future<Order> placeOrder({
    required String restaurant,
    required List<CartItem> items,
    required double totalAmount,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // Randomly simulate success or failure
    final isSuccess = true;
    if (isSuccess) {
      return Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        restaurant: restaurant,
        items: items,
        totalAmount: totalAmount,
        status: OrderStatus.success,
      );
    } else {
      throw Exception('Failed to place order. Please try again.');
    }
  }
}
