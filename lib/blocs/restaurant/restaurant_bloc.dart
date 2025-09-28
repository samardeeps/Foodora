import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/restaurant_repositories.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;

  RestaurantBloc({required RestaurantRepository restaurantRepository})
    : _restaurantRepository = restaurantRepository,
      super(const RestaurantState()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<FilterRestaurants>(_onFilterRestaurants);
    on<SearchRestaurants>(_onSearchRestaurants);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(state.copyWith(status: RestaurantStatus.loading));
    try {
      final restaurants = await _restaurantRepository.getRestaurants();
      emit(
        state.copyWith(
          status: RestaurantStatus.loaded,
          restaurants: restaurants,
          filteredRestaurants: restaurants,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: RestaurantStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onFilterRestaurants(
    FilterRestaurants event,
    Emitter<RestaurantState> emit,
  ) {
    final filteredList = state.restaurants.where((restaurant) {
      if (event.cuisine != null &&
          !restaurant.cuisineTypes.contains(event.cuisine)) {
        return false;
      }
      if (event.isOpen != null && restaurant.isOpen != event.isOpen) {
        return false;
      }
      if (event.minRating != null && restaurant.rating < event.minRating!) {
        return false;
      }
      return true;
    }).toList();

    emit(
      state.copyWith(
        filteredRestaurants: filteredList,
        selectedCuisine: event.cuisine,
        filterByOpen: event.isOpen,
        minRating: event.minRating,
      ),
    );
  }

  void _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<RestaurantState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(state.copyWith(filteredRestaurants: state.restaurants));
      return;
    }

    final searchResults = state.restaurants.where((restaurant) {
      return restaurant.name.toLowerCase().contains(
            event.query.toLowerCase(),
          ) ||
          restaurant.cuisineTypes.any(
            (cuisine) =>
                cuisine.toLowerCase().contains(event.query.toLowerCase()),
          );
    }).toList();

    emit(state.copyWith(filteredRestaurants: searchResults));
  }
}
