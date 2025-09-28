import 'package:equatable/equatable.dart';

abstract class MenuItemEvent extends Equatable {
  const MenuItemEvent();

  @override
  List<Object?> get props => [];
}

class LoadMenuItems extends MenuItemEvent {
  final String restaurantId;

  const LoadMenuItems(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}

class FilterMenuItems extends MenuItemEvent {
  final String restaurantId;
  final String? category;
  final bool? vegetarianOnly;
  final String? searchQuery;

  const FilterMenuItems({
    required this.restaurantId,
    this.category,
    this.vegetarianOnly,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [
    restaurantId,
    category,
    vegetarianOnly,
    searchQuery,
  ];
}

class SearchMenuItems extends MenuItemEvent {
  final String restaurantId;
  final String query;

  const SearchMenuItems({required this.restaurantId, required this.query});

  @override
  List<Object?> get props => [restaurantId, query];
}
