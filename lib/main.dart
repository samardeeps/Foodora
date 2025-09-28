import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodora/blocs/menu_item/menu_item_bloc.dart';
import 'package:foodora/blocs/menu_item/menu_item_event.dart';
import 'package:foodora/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodora/blocs/restaurant/restaurant_event.dart'
    show LoadRestaurants;
import 'package:foodora/repositories/menu_item_repository.dart'
    show MenuItemRepository;
import 'package:foodora/utils/app_theme.dart';
import 'package:foodora/repositories/restaurant_repositories.dart';
import 'package:foodora/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Foodora',
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<RestaurantRepository>(
            create: (context) => RestaurantRepository(),
          ),
          RepositoryProvider<MenuItemRepository>(
            create: (context) => MenuItemRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RestaurantBloc>(
              create: (context) => RestaurantBloc(
                restaurantRepository: context.read<RestaurantRepository>(),
              )..add(LoadRestaurants()),
            ),
            BlocProvider<MenuItemBloc>(
              create: (context) => MenuItemBloc(
                menuItemRepository: context.read<MenuItemRepository>(),
              ),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
