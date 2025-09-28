class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final List<String> cuisineTypes;
  final String address;
  final bool isOpen;
  final String deliveryTime;
  final double minimumOrder;
  final double deliveryFee;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.cuisineTypes,
    required this.address,
    required this.isOpen,
    required this.deliveryTime,
    required this.minimumOrder,
    required this.deliveryFee,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: json['rating'] as double,
      cuisineTypes: List<String>.from(json['cuisineTypes']),
      address: json['address'] as String,
      isOpen: json['isOpen'] as bool,
      deliveryTime: json['deliveryTime'] as String,
      minimumOrder: json['minimumOrder'] as double,
      deliveryFee: json['deliveryFee'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'cuisineTypes': cuisineTypes,
      'address': address,
      'isOpen': isOpen,
      'deliveryTime': deliveryTime,
      'minimumOrder': minimumOrder,
      'deliveryFee': deliveryFee,
    };
  }
}
