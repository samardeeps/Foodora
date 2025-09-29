import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/menu_item/menu_item_bloc.dart';
import '../blocs/menu_item/menu_item_event.dart';
import '../blocs/menu_item/menu_item_state.dart';
import '../models/restaurant.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/menu_items_title.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load menu items for this restaurant using the existing MenuItemBloc
    context.read<MenuItemBloc>().add(LoadMenuItems(widget.restaurant.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Restaurant Image and Info
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
              title: Text(widget.restaurant.name),
            ),
          ),
          // Restaurant Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and Open/Closed status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.starYellow,
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: widget.restaurant.isOpen
                              ? AppColors.success
                              : AppColors.error,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.restaurant.isOpen ? 'Open' : 'Closed',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Cuisine types
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.restaurant.cuisineTypes
                        .map(
                          (cuisine) => Chip(
                            label: Text(cuisine),
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            labelStyle: const TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    widget.restaurant.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  // Info rows
                  _buildInfoRow(
                    Icons.access_time,
                    'Delivery Time: ${widget.restaurant.deliveryTime}',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.motorcycle,
                    'Delivery Fee: \$${widget.restaurant.deliveryFee.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.shopping_bag,
                    'Minimum Order: \$${widget.restaurant.minimumOrder.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.location_on, widget.restaurant.address),
                  const SizedBox(height: 24),
                  // Menu Section
                  const MenuItemsTitle(title: 'Menu'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Menu Items List
          SliverToBoxAdapter(
            child: BlocBuilder<MenuItemBloc, MenuItemState>(
              builder: (context, state) {
                if (state.status == MenuItemStatus.loading) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state.status == MenuItemStatus.error) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else if (state.filteredMenuItems.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text('No menu items found')),
                  );
                }

                return BlocBuilder<CartBloc, CartState>(
                  builder: (context, cartState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // Menu items list
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.filteredMenuItems.length,
                            itemBuilder: (context, index) {
                              final item = state.filteredMenuItems[index];
                              final quantity = cartState.items[item] ?? 0;
                              return MenuItemCard(
                                item: item,
                                quantity: quantity,
                              );
                            },
                          ),
                          // View Cart button (only show if cart has items)
                          if (cartState.items.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            '${cartState.items.length}',
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Text(
                                          'View Cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${cartState.total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // TODO: Implement navigation based on index
          // 0: Home, 1: Search, 2: Orders, 3: Profile
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
