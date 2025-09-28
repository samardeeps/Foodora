import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object?> get props => [];
}

class LoadRestaurants extends RestaurantEvent {}

class FilterRestaurants extends RestaurantEvent {
  final String? cuisine;
  final bool? isOpen;
  final double? minRating;

  const FilterRestaurants({this.cuisine, this.isOpen, this.minRating});

  @override
  List<Object?> get props => [cuisine, isOpen, minRating];
}

class SearchRestaurants extends RestaurantEvent {
  final String query;

  const SearchRestaurants(this.query);

  @override
  List<Object?> get props => [query];
}
