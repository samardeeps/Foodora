import 'package:equatable/equatable.dart';
import '../../models/menu_items.dart';

enum MenuItemStatus { initial, loading, loaded, error }

class MenuItemState extends Equatable {
  final List<MenuItem> menuItems;
  final List<MenuItem> filteredMenuItems;
  final List<String> categories;
  final MenuItemStatus status;
  final String? selectedCategory;
  final bool? vegetarianOnly;
  final String? searchQuery;
  final String? errorMessage;

  const MenuItemState({
    this.menuItems = const [],
    this.filteredMenuItems = const [],
    this.categories = const [],
    this.status = MenuItemStatus.initial,
    this.selectedCategory,
    this.vegetarianOnly,
    this.searchQuery,
    this.errorMessage,
  });

  MenuItemState copyWith({
    List<MenuItem>? menuItems,
    List<MenuItem>? filteredMenuItems,
    List<String>? categories,
    MenuItemStatus? status,
    String? selectedCategory,
    bool? vegetarianOnly,
    String? searchQuery,
    String? errorMessage,
  }) {
    return MenuItemState(
      menuItems: menuItems ?? this.menuItems,
      filteredMenuItems: filteredMenuItems ?? this.filteredMenuItems,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      vegetarianOnly: vegetarianOnly ?? this.vegetarianOnly,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    menuItems,
    filteredMenuItems,
    categories,
    status,
    selectedCategory,
    vegetarianOnly,
    searchQuery,
    errorMessage,
  ];
}
