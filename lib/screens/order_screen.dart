import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order/order_bloc.dart';
import '../blocs/order/order_event.dart';
import '../blocs/order/order_state.dart';
import '../models/order.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';

class OrderScreen extends StatelessWidget {
  final String restaurant;
  final List<CartItem> items;
  final double totalAmount;
  final double deliveryFee;
  final double handlingFee;

  const OrderScreen({
    super.key,
    required this.restaurant,
    required this.items,
    required this.totalAmount,
    required this.deliveryFee,
    required this.handlingFee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Order')),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            // Clear cart before navigating
            context.read<CartBloc>().add(ClearCart());
            Navigator.pushReplacementNamed(
              context,
              '/order-confirmation',
              arguments: state.order,
            );
          } else if (state is OrderFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: items
                      .map(
                        (cartItem) => ListTile(
                          title: Text(cartItem.item.name),
                          subtitle: Text('Qty: ${cartItem.quantity}'),
                          trailing: Text(
                            '₹${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}',
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                        Text(
                          '₹${_getSubtotal(items).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Fee:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '₹${deliveryFee.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Handling Fee:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '₹${handlingFee.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<OrderBloc>().add(
                          PlaceOrder(
                            restaurant: restaurant,
                            items: items,
                            totalAmount: totalAmount,
                          ),
                        );
                      },
                      child: const Text('Confirm Order'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 46),
            ],
          );
        },
      ),
    );
  }

  double _getSubtotal(List<CartItem> items) {
    return items.fold(
      0.0,
      (sum, item) => sum + item.item.price * item.quantity,
    );
  }

  // deliveryFee and handlingFee now come from CartState
}
