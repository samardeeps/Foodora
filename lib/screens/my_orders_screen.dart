import 'package:flutter/material.dart';
import '../models/order.dart';

class MyOrdersScreen extends StatelessWidget {
  final List<Order> orders;

  const MyOrdersScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No confirmed orders yet.'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text('Order #${order.id}'),
                    subtitle: Text(
                      'Restaurant: ${order.restaurant}\nTotal: \u0024${order.totalAmount.toStringAsFixed(2)}',
                    ),
                    trailing: Icon(
                      order.status == OrderStatus.success
                          ? Icons.check_circle
                          : Icons.error,
                      color: order.status == OrderStatus.success
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
