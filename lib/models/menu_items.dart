class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final List<String> customizations;
  final String category;
  final bool isSpicy;
  final bool isVegetarian;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
    required this.customizations,
    required this.category,
    this.isSpicy = false,
    this.isVegetarian = false,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      isAvailable: json['isAvailable'] as bool,
      customizations: List<String>.from(json['customizations']),
      category: json['category'] as String,
      isSpicy: json['isSpicy'] as bool? ?? false,
      isVegetarian: json['isVegetarian'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'customizations': customizations,
      'category': category,
      'isSpicy': isSpicy,
      'isVegetarian': isVegetarian,
    };
  }
}
