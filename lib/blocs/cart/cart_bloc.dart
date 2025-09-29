import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../models/menu_items.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({double deliveryFee = 2.99, double handlingFee = 1.00})
    : super(CartState(deliveryFee: deliveryFee, handlingFee: handlingFee)) {
    on<AddItemToCart>(_onAddItem);
    on<RemoveItemFromCart>(_onRemoveItem);
    on<ChangeItemQuantity>(_onChangeQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddItem(AddItemToCart event, Emitter<CartState> emit) {
    final items = Map<MenuItem, int>.from(state.items);
    items[event.item] = (items[event.item] ?? 0) + 1;
    emit(_calculateTotal(items));
  }

  void _onRemoveItem(RemoveItemFromCart event, Emitter<CartState> emit) {
    final items = Map<MenuItem, int>.from(state.items);
    if (items.containsKey(event.item)) {
      items.remove(event.item);
    }
    emit(_calculateTotal(items));
  }

  void _onChangeQuantity(ChangeItemQuantity event, Emitter<CartState> emit) {
    final items = Map<MenuItem, int>.from(state.items);
    if (event.quantity <= 0) {
      items.remove(event.item);
    } else {
      items[event.item] = event.quantity;
    }
    emit(_calculateTotal(items));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(items: {}, total: 0.0));
  }

  CartState _calculateTotal(Map<MenuItem, int> items) {
    double subtotal = 0.0;
    items.forEach((item, qty) {
      subtotal += item.price * qty;
    });
    double total = subtotal + state.deliveryFee + state.handlingFee;
    return state.copyWith(items: items, total: total);
  }
}
