import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final Order order;
  const OrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderFailure extends OrderState {
  final String errorMessage;
  const OrderFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
