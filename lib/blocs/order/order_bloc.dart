import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_event.dart';
import 'order_state.dart';
import '../../repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final order = await orderRepository.placeOrder(
        restaurant: event.restaurant,
        items: event.items,
        totalAmount: event.totalAmount,
      );
      emit(OrderSuccess(order));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
