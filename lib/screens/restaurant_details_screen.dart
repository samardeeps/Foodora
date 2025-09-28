import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/menu_item/menu_item_bloc.dart';
import '../blocs/menu_item/menu_item_event.dart';
import '../blocs/menu_item/menu_item_state.dart';
import '../repositories/menu_item_repository.dart';
import '../models/restaurant.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/menu_items_title.dart';

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
    // Dispatch LoadMenuItems when the screen loads
    Future.microtask(() {
      final menuItemBloc = context.read<MenuItemBloc?>();
      if (menuItemBloc != null) {
        menuItemBloc.add(LoadMenuItems(widget.restaurant.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MenuItemBloc(menuItemRepository: MenuItemRepository())
            ..add(LoadMenuItems(widget.restaurant.id)),
      child: Scaffold(
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
                    // ...existing code for restaurant info...
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.restaurant.cuisineTypes
                          .map(
                            (cuisine) => Chip(
                              label: Text(cuisine),
                              backgroundColor: AppColors.primary.withOpacity(
                                0.1,
                              ),
                              labelStyle: const TextStyle(
                                color: AppColors.primary,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.restaurant.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
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
                    BlocBuilder<MenuItemBloc, MenuItemState>(
                      builder: (context, state) {
                        if (state.status == MenuItemStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.status == MenuItemStatus.error) {
                          return Center(
                            child: Text(
                              'Error: \\${state.errorMessage}',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (state.filteredMenuItems.isEmpty) {
                          return const Center(
                            child: Text('No menu items found'),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.filteredMenuItems.length,
                          itemBuilder: (context, index) {
                            final item = state.filteredMenuItems[index];
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
                                trailing: Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
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
            // TODO: Implement navigation
          },
        ),
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
