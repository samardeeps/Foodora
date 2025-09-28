import 'package:equatable/equatable.dart';
import '../../models/restaurant.dart';

enum RestaurantStatus { initial, loading, loaded, error }

class RestaurantState extends Equatable {
  final List<Restaurant> restaurants;
  final RestaurantStatus status;
  final String? errorMessage;
  final List<Restaurant> filteredRestaurants;
  final String? selectedCuisine;
  final bool? filterByOpen;
  final double? minRating;

  const RestaurantState({
    this.restaurants = const [],
    this.status = RestaurantStatus.initial,
    this.errorMessage,
    this.filteredRestaurants = const [],
    this.selectedCuisine,
    this.filterByOpen,
    this.minRating,
  });

  RestaurantState copyWith({
    List<Restaurant>? restaurants,
    RestaurantStatus? status,
    String? errorMessage,
    List<Restaurant>? filteredRestaurants,
    String? selectedCuisine,
    bool? filterByOpen,
    double? minRating,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
      selectedCuisine: selectedCuisine ?? this.selectedCuisine,
      filterByOpen: filterByOpen ?? this.filterByOpen,
      minRating: minRating ?? this.minRating,
    );
  }

  @override
  List<Object?> get props => [
    restaurants,
    status,
    errorMessage,
    filteredRestaurants,
    selectedCuisine,
    filterByOpen,
    minRating,
  ];
}
