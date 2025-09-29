import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrder extends OrderEvent {
  final String restaurant;
  final List<CartItem> items;
  final double totalAmount;

  const PlaceOrder({
    required this.restaurant,
    required this.items,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [restaurant, items, totalAmount];
}
