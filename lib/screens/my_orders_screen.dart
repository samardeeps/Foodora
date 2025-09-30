import 'package:flutter/material.dart';
import 'package:foodora/widgets/custom_nav_bar.dart';
import '../models/order.dart';

class MyOrdersScreen extends StatefulWidget {
  final List<Order> orders;

  const MyOrdersScreen({super.key, required this.orders});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: widget.orders.isEmpty
          ? const Center(child: Text('No confirmed orders yet.'))
          : ListView.builder(
              itemCount: widget.orders.length,
              itemBuilder: (context, index) {
                final order = widget.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text('Order #${order.id}'),
                    subtitle: Text(
                      'Restaurant: ${order.restaurant}\nTotal: ₹${order.totalAmount.toStringAsFixed(2)}',
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
