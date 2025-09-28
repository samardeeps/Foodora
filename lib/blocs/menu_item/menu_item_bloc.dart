import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/menu_item_repository.dart';
import 'menu_item_event.dart';
import 'menu_item_state.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  final MenuItemRepository _menuItemRepository;

  MenuItemBloc({required MenuItemRepository menuItemRepository})
    : _menuItemRepository = menuItemRepository,
      super(const MenuItemState()) {
    on<LoadMenuItems>(_onLoadMenuItems);
    on<FilterMenuItems>(_onFilterMenuItems);
    on<SearchMenuItems>(_onSearchMenuItems);
  }

  Future<void> _onLoadMenuItems(
    LoadMenuItems event,
    Emitter<MenuItemState> emit,
  ) async {
    emit(state.copyWith(status: MenuItemStatus.loading));

    try {
      final menuItems = await _menuItemRepository.getMenuItemsByRestaurant(
        event.restaurantId,
      );
      final categories = await _menuItemRepository.getCategories(
        event.restaurantId,
      );

      emit(
        state.copyWith(
          status: MenuItemStatus.loaded,
          menuItems: menuItems,
          filteredMenuItems: menuItems,
          categories: categories,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: MenuItemStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onFilterMenuItems(
    FilterMenuItems event,
    Emitter<MenuItemState> emit,
  ) async {
    var filteredItems = state.menuItems;

    // Filter by category
    if (event.category != null) {
      filteredItems = await _menuItemRepository.getMenuItemsByCategory(
        event.restaurantId,
        event.category!,
      );
    }

    // Filter vegetarian items
    if (event.vegetarianOnly == true) {
      filteredItems = await _menuItemRepository.getVegetarianItems(
        event.restaurantId,
      );
    }

    // Apply search query if exists
    if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
      filteredItems = await _menuItemRepository.searchMenuItems(
        event.restaurantId,
        event.searchQuery!,
      );
    }

    emit(
      state.copyWith(
        filteredMenuItems: filteredItems,
        selectedCategory: event.category,
        vegetarianOnly: event.vegetarianOnly,
        searchQuery: event.searchQuery,
      ),
    );
  }

  Future<void> _onSearchMenuItems(
    SearchMenuItems event,
    Emitter<MenuItemState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(filteredMenuItems: state.menuItems, searchQuery: null),
      );
      return;
    }

    final searchResults = await _menuItemRepository.searchMenuItems(
      event.restaurantId,
      event.query,
    );

    emit(
      state.copyWith(
        filteredMenuItems: searchResults,
        searchQuery: event.query,
      ),
    );
  }
}
