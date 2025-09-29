import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodora/screens/restaurant_details_screen.dart'
    show RestaurantDetailsScreen;
import '../blocs/restaurant/restaurant_bloc.dart';
import '../blocs/restaurant/restaurant_state.dart';
import '../blocs/restaurant/restaurant_event.dart';
import '../widgets/restaurants_card.dart';
import '../widgets/custom_nav_bar.dart';
import '../blocs/cart/cart_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodora'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          switch (state.status) {
            case RestaurantStatus.initial:
              return const Center(child: Text('No restaurants to display'));

            case RestaurantStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case RestaurantStatus.loaded:
              if (state.filteredRestaurants.isEmpty) {
                return const Center(child: Text('No restaurants found'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<RestaurantBloc>().add(LoadRestaurants());
                },
                child: ListView.builder(
                  itemCount: state.filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.filteredRestaurants[index];
                    return RestaurantCard(
                      restaurant: restaurant,
                      onTap: () {
                        final cartBloc = context.read<CartBloc>();
                        debugPrint(
                          'Passing CartBloc to RestaurantDetailsScreen: $cartBloc',
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: cartBloc,
                              child: RestaurantDetailsScreen(
                                restaurant: restaurant,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );

            case RestaurantStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RestaurantBloc>().add(LoadRestaurants());
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
          }
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // TODO: Implement navigation to different screens
        },
      ),
    );
  }
}
