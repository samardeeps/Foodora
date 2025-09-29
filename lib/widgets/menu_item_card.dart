import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_items.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final int quantity;
  const MenuItemCard({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(
          item.imageUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: SizedBox(
          width: 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (quantity > 0) {
                      final cartBloc = BlocProvider.of<CartBloc>(context);
                      cartBloc.add(
                        ChangeItemQuantity(item: item, quantity: quantity - 1),
                      );
                    }
                  },
                ),
                Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    final cartBloc = BlocProvider.of<CartBloc>(context);
                    cartBloc.add(
                      ChangeItemQuantity(item: item, quantity: quantity + 1),
                    );
                  },
                ),
                const SizedBox(width: 4),
                Text('4${item.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
