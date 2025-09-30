import '../models/restaurant.dart';

class RestaurantRepository {
  // In a real app, this would come from an API or database
  final List<Restaurant> _mockRestaurants = [
    Restaurant(
      id: '1',
      name: 'Tasty Bites',
      description: 'Delicious Italian cuisine in a cozy atmosphere',
      imageUrl: 'assets/images/restaurant1.jpg',
      rating: 4.5,
      cuisineTypes: ['Italian', 'European'],
      address: '123 Main St, City',
      isOpen: true,
      deliveryTime: '30-45 min',
      minimumOrder: 15.0,
      deliveryFee: 2.99,
    ),
    Restaurant(
      id: '2',
      name: 'Spice Garden',
      description: 'Authentic Indian dishes with rich flavors',
      imageUrl: 'assets/images/restaurant2.jpg',
      rating: 4.3,
      cuisineTypes: ['Indian', 'Asian'],
      address: '456 Oak St, City',
      isOpen: true,
      deliveryTime: '40-55 min',
      minimumOrder: 20.0,
      deliveryFee: 3.99,
    ),
    Restaurant(
      id: '3',
      name: 'Sushi Master',
      description: 'Premium Japanese sushi and rolls',
      imageUrl: 'assets/images/restaurant3.jpg',
      rating: 4.7,
      cuisineTypes: ['Japanese', 'Asian'],
      address: '789 Pine St, City',
      isOpen: false,
      deliveryTime: '35-50 min',
      minimumOrder: 25.0,
      deliveryFee: 4.99,
    ),
  ];

  Future<List<Restaurant>> getRestaurants() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 5));
    return _mockRestaurants;
  }

  Future<Restaurant?> getRestaurantById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockRestaurants.firstWhere(
      (restaurant) => restaurant.id == id,
      orElse: () => throw Exception('Restaurant not found'),
    );
  }
}
