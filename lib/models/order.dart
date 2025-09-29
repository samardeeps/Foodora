import 'package:equatable/equatable.dart';
import 'menu_items.dart';

enum OrderStatus { pending, success, failed }

class CartItem {
  final MenuItem item;
  final int quantity;

  CartItem({required this.item, required this.quantity});
}

class Order extends Equatable {
  final String id;
  final String restaurant;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.restaurant,
    required this.items,
    required this.totalAmount,
    required this.status,
  });

  @override
  List<Object?> get props => [id, restaurant, items, totalAmount, status];
}
