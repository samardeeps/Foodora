import 'package:flutter/material.dart';
import '../models/order.dart';
import 'home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Order order;
  final String? errorMessage;

  const OrderConfirmationScreen({
    super.key,
    required this.order,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = order.status == OrderStatus.success;
    if (isSuccess && !HomeScreen.confirmedOrders.contains(order)) {
      HomeScreen.confirmedOrders.add(order);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Center(
        child: isSuccess
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'Thank you for your order!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Order ID: ${order.id}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(ClearCart());
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Continue'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage ?? 'Order failed',
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
      ),
    );
  }
}
