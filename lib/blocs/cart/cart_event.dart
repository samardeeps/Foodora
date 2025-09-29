import 'package:equatable/equatable.dart';
import '../../models/menu_items.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddItemToCart extends CartEvent {
  final MenuItem item;
  const AddItemToCart(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final MenuItem item;
  const RemoveItemFromCart(this.item);
  @override
  List<Object?> get props => [item];
}

class ChangeItemQuantity extends CartEvent {
  final MenuItem item;
  final int quantity;
  const ChangeItemQuantity({required this.item, required this.quantity});
  @override
  List<Object?> get props => [item, quantity];
}

class ClearCart extends CartEvent {}
