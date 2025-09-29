import 'package:equatable/equatable.dart';
import '../../models/menu_items.dart';

class CartState extends Equatable {
  final Map<MenuItem, int> items;
  final double deliveryFee;
  final double handlingFee;
  final double total;

  const CartState({
    this.items = const {},
    this.deliveryFee = 0.0,
    this.handlingFee = 0.0,
    this.total = 0.0,
  });

  CartState copyWith({
    Map<MenuItem, int>? items,
    double? deliveryFee,
    double? handlingFee,
    double? total,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      handlingFee: handlingFee ?? this.handlingFee,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [items, deliveryFee, handlingFee, total];
}
