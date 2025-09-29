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

  const OrderScreen({
    super.key,
    required this.restaurant,
    required this.items,
    required this.totalAmount,
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
                            '4${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}',
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Total: 4${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
            ],
          );
        },
      ),
    );
  }
}
