import '../models/menu_items.dart';

class MenuItemRepository {
  // Mock data for menu items categorized by restaurant ID
  final Map<String, List<MenuItem>> _mockMenuItems = {
    '1': [
      MenuItem(
        id: '1_1',
        name: 'Margherita Pizza',
        description: 'Classic tomato sauce, mozzarella, and basil',
        price: 12.99,
        imageUrl: 'assets/images/margherita.jpg',
        isAvailable: true,
        customizations: ['Extra cheese', 'Thin crust', 'Gluten-free'],
        category: 'Pizza',
        isVegetarian: true,
      ),
      MenuItem(
        id: '1_2',
        name: 'Pepperoni Pizza',
        description: 'Tomato sauce, mozzarella, and pepperoni',
        price: 14.99,
        imageUrl: 'assets/images/pepperoni.jpg',
        isAvailable: true,
        customizations: ['Extra cheese', 'Thin crust', 'Extra pepperoni'],
        category: 'Pizza',
      ),
      MenuItem(
        id: '1_3',
        name: 'Caesar Salad',
        description: 'Romaine lettuce, croutons, parmesan, and Caesar dressing',
        price: 8.99,
        imageUrl: 'assets/images/caesar_salad.jpg',
        isAvailable: true,
        customizations: ['No croutons', 'Extra dressing', 'Add chicken'],
        category: 'Salads',
        isVegetarian: true,
      ),
    ],
    '2': [
      MenuItem(
        id: '2_1',
        name: 'Butter Chicken',
        description: 'Tender chicken in rich tomato-butter sauce',
        price: 15.99,
        imageUrl: 'assets/images/butter_chicken.jpg',
        isAvailable: true,
        customizations: ['Spice level', 'Extra sauce', 'Add naan'],
        category: 'Main Course',
      ),
      MenuItem(
        id: '2_2',
        name: 'Palak Paneer',
        description: 'Cottage cheese cubes in spinach gravy',
        price: 13.99,
        imageUrl: 'assets/images/palak_paneer.jpg',
        isAvailable: true,
        customizations: ['Spice level', 'Extra paneer'],
        category: 'Main Course',
        isVegetarian: true,
      ),
      MenuItem(
        id: '2_3',
        name: 'Garlic Naan',
        description: 'Freshly baked bread with garlic and butter',
        price: 3.99,
        imageUrl: 'assets/images/garlic_naan.jpg',
        isAvailable: true,
        customizations: ['Extra butter', 'Plain'],
        category: 'Breads',
        isVegetarian: true,
      ),
    ],
    '3': [
      MenuItem(
        id: '3_1',
        name: 'California Roll',
        description: 'Crab, avocado, and cucumber',
        price: 9.99,
        imageUrl: 'assets/images/california_roll.jpg',
        isAvailable: true,
        customizations: ['Extra wasabi', 'Extra ginger', 'Soy sauce'],
        category: 'Sushi Rolls',
      ),
      MenuItem(
        id: '3_2',
        name: 'Salmon Nigiri',
        description: 'Fresh salmon on vinegared rice',
        price: 6.99,
        imageUrl: 'assets/images/salmon_nigiri.jpg',
        isAvailable: true,
        customizations: ['Extra wasabi', 'Soy sauce'],
        category: 'Nigiri',
      ),
      MenuItem(
        id: '3_3',
        name: 'Miso Soup',
        description: 'Traditional Japanese soup with tofu and seaweed',
        price: 4.99,
        imageUrl: 'assets/images/miso_soup.jpg',
        isAvailable: true,
        customizations: ['Extra tofu', 'No seaweed'],
        category: 'Soups',
        isVegetarian: true,
      ),
    ],
  };

  // Get menu items for a specific restaurant
  Future<List<MenuItem>> getMenuItemsByRestaurant(String restaurantId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockMenuItems[restaurantId] ?? [];
  }

  // Get menu items by category for a specific restaurant
  Future<List<MenuItem>> getMenuItemsByCategory(
    String restaurantId,
    String category,
  ) async {
    final items = _mockMenuItems[restaurantId] ?? [];
    return items.where((item) => item.category == category).toList();
  }

  // Get available categories for a restaurant
  Future<List<String>> getCategories(String restaurantId) async {
    final items = _mockMenuItems[restaurantId] ?? [];
    return items.map((item) => item.category).toSet().toList();
  }

  // Search menu items in a restaurant
  Future<List<MenuItem>> searchMenuItems(
    String restaurantId,
    String query,
  ) async {
    final items = _mockMenuItems[restaurantId] ?? [];
    return items
        .where(
          (item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) ||
              item.description.toLowerCase().contains(query.toLowerCase()) ||
              item.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Get vegetarian menu items
  Future<List<MenuItem>> getVegetarianItems(String restaurantId) async {
    final items = _mockMenuItems[restaurantId] ?? [];
    return items.where((item) => item.isVegetarian).toList();
  }

  // Get item by ID
  Future<MenuItem?> getMenuItemById(String restaurantId, String itemId) async {
    final items = _mockMenuItems[restaurantId] ?? [];
    try {
      return items.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }
}
