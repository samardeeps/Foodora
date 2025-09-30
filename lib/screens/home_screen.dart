// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:foodora/models/order.dart';
// import 'package:foodora/screens/restaurant_details_screen.dart'
//     show RestaurantDetailsScreen;
// import '../blocs/restaurant/restaurant_bloc.dart';
// import '../blocs/restaurant/restaurant_state.dart';
// import '../blocs/restaurant/restaurant_event.dart';
// import '../widgets/restaurants_card.dart';
// import '../widgets/custom_nav_bar.dart';
// import '../blocs/cart/cart_bloc.dart';
// import 'my_orders_screen.dart';

// class HomeScreen extends StatefulWidget {
//   static final List<Order> confirmedOrders = [];
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   final PageController _pageController = PageController();
//   int _currentAdPage = 0;
//   String _searchQuery = '';

//   final String userName = "John";

//   final List<String> _bannerImages = [
//     'assets/images/banner.png',
//     'assets/images/banner2.png',
//     'assets/images/banner1.png',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), _autoScrollBanners);
//     _searchController.addListener(_onSearchChanged);
//   }

//   void _onSearchChanged() {
//     setState(() {
//       _searchQuery = _searchController.text.toLowerCase().trim();
//     });
//     _performSearch();
//   }

//   void _performSearch() {
//     context.read<RestaurantBloc>().add(SearchRestaurants(_searchQuery));
//   }

//   void _autoScrollBanners() {
//     if (!mounted) return;
//     Future.delayed(const Duration(seconds: 4), () {
//       if (_pageController.hasClients) {
//         int nextPage = (_currentAdPage + 1) % _bannerImages.length;
//         _pageController.animateToPage(
//           nextPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//         _autoScrollBanners();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(120),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Theme.of(context).primaryColor,
//                   Theme.of(context).primaryColor.withOpacity(0.8),
//                 ],
//               ),
//             ),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Logo and Welcome Text
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.restaurant_menu,
//                                 color: Theme.of(context).primaryColor,
//                                 size: 28,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Foodora',
//                                   style: Theme.of(context).textTheme.titleLarge
//                                       ?.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                 ),
//                                 Text(
//                                   'Hi, $userName!',
//                                   style: Theme.of(context).textTheme.bodyMedium
//                                       ?.copyWith(
//                                         color: Colors.white.withOpacity(0.9),
//                                       ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         // Notification Icon
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.notifications_outlined,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               // TODO: Navigate to notifications
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: BlocBuilder<RestaurantBloc, RestaurantState>(
//         builder: (context, state) {
//           switch (state.status) {
//             case RestaurantStatus.initial:
//               return const Center(child: Text('No restaurants to display'));
//             case RestaurantStatus.loading:
//               return Center(
//                 child: Lottie.asset(
//                   'assets/animations/loading.json',
//                   width: 200,
//                   height: 200,
//                   repeat: true,
//                   animate: true,
//                 ),
//               );
//             case RestaurantStatus.loaded:
//               if (state.filteredRestaurants.isEmpty &&
//                   _searchQuery.isNotEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.search_off,
//                         size: 80,
//                         color: Colors.grey.shade400,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'No restaurants found',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Try searching with different keywords',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               if (state.filteredRestaurants.isEmpty) {
//                 return const Center(child: Text('No restaurants available'));
//               }
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   context.read<RestaurantBloc>().add(LoadRestaurants());
//                 },
//                 child: ListView(
//                   children: [
//                     // Enhanced Search Bar
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.08),
//                               blurRadius: 12,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           controller: _searchController,
//                           decoration: InputDecoration(
//                             hintText: 'Search restaurants, cuisines, dishes...',
//                             hintStyle: TextStyle(
//                               color: Colors.grey.shade400,
//                               fontSize: 15,
//                             ),
//                             prefixIcon: Icon(
//                               Icons.search,
//                               color: Theme.of(context).primaryColor,
//                               size: 24,
//                             ),
//                             suffixIcon: _searchController.text.isNotEmpty
//                                 ? Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.clear,
//                                           color: Colors.grey.shade600,
//                                         ),
//                                         onPressed: () {
//                                           _searchController.clear();
//                                         },
//                                       ),
//                                       Container(
//                                         width: 1,
//                                         height: 24,
//                                         color: Colors.grey.shade300,
//                                         margin: const EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.tune,
//                                           color: Theme.of(context).primaryColor,
//                                         ),
//                                         onPressed: () {
//                                           _showFilterBottomSheet(context);
//                                         },
//                                       ),
//                                     ],
//                                   )
//                                 : IconButton(
//                                     icon: Icon(
//                                       Icons.tune,
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                     onPressed: () {
//                                       _showFilterBottomSheet(context);
//                                     },
//                                   ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: BorderSide.none,
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Search Results Info
//                     if (_searchQuery.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Text(
//                           'Found ${state.filteredRestaurants.length} ${state.filteredRestaurants.length == 1 ? 'restaurant' : 'restaurants'}',
//                           style: Theme.of(context).textTheme.bodyMedium
//                               ?.copyWith(
//                                 color: Colors.grey.shade600,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                         ),
//                       ),
//                     if (_searchQuery.isEmpty) ...[
//                       // Banner Carousel
//                       SizedBox(
//                         height: 200,
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: PageView.builder(
//                                 controller: _pageController,
//                                 onPageChanged: (index) {
//                                   setState(() {
//                                     _currentAdPage = index;
//                                   });
//                                 },
//                                 itemCount: _bannerImages.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.1),
//                                           blurRadius: 8,
//                                           offset: const Offset(0, 4),
//                                         ),
//                                       ],
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(16),
//                                       child: Image.asset(
//                                         _bannerImages[index],
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error, stackTrace) {
//                                               return Container(
//                                                 color: Theme.of(
//                                                   context,
//                                                 ).primaryColor.withOpacity(0.1),
//                                                 child: Center(
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(
//                                                         Icons.restaurant_menu,
//                                                         size: 48,
//                                                         color: Theme.of(
//                                                           context,
//                                                         ).primaryColor,
//                                                       ),
//                                                       const SizedBox(height: 8),
//                                                       Text(
//                                                         'Banner ${index + 1}',
//                                                         style: Theme.of(
//                                                           context,
//                                                         ).textTheme.titleMedium,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             // Page Indicator
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: List.generate(
//                                 _bannerImages.length,
//                                 (index) => AnimatedContainer(
//                                   duration: const Duration(milliseconds: 300),
//                                   margin: const EdgeInsets.symmetric(
//                                     horizontal: 4,
//                                   ),
//                                   width: _currentAdPage == index ? 24 : 8,
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                     color: _currentAdPage == index
//                                         ? Theme.of(context).primaryColor
//                                         : Theme.of(
//                                             context,
//                                           ).primaryColor.withOpacity(0.3),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                           ],
//                         ),
//                       ),
//                       // Restaurants Section Header
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Restaurants Near You',
//                               style: Theme.of(context).textTheme.titleLarge
//                                   ?.copyWith(fontWeight: FontWeight.bold),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // TODO: Show all restaurants
//                               },
//                               child: const Text('View All'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ] else
//                       const SizedBox(height: 16),
//                     // Restaurants List
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: state.filteredRestaurants.length,
//                       itemBuilder: (context, index) {
//                         final restaurant = state.filteredRestaurants[index];
//                         return RestaurantCard(
//                           restaurant: restaurant,
//                           onTap: () {
//                             final cartBloc = context.read<CartBloc>();
//                             debugPrint(
//                               'Passing CartBloc to RestaurantDetailsScreen: $cartBloc',
//                             );
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BlocProvider.value(
//                                   value: cartBloc,
//                                   child: RestaurantDetailsScreen(
//                                     restaurant: restaurant,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             case RestaurantStatus.error:
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.error_outline,
//                       size: 64,
//                       color: Theme.of(context).colorScheme.error,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Error: ${state.errorMessage}',
//                       style: TextStyle(
//                         color: Theme.of(context).colorScheme.error,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<RestaurantBloc>().add(LoadRestaurants());
//                       },
//                       child: const Text('Try Again'),
//                     ),
//                   ],
//                 ),
//               );
//           }
//         },
//       ),
//       bottomNavigationBar: CustomNavBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       MyOrdersScreen(orders: HomeScreen.confirmedOrders),
//                 ),
//               );
//             }
//           });
//         },
//       ),
//     );
//   }

//   void _showFilterBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Filter & Sort',
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(Icons.star),
//                 title: const Text('Rating'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   // TODO: Implement rating filter
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.attach_money),
//                 title: const Text('Price Range'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   // TODO: Implement price filter
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.access_time),
//                 title: const Text('Delivery Time'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   // TODO: Implement delivery time filter
//                   Navigator.pop(context);
//                 },
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:foodora/models/order.dart';
import 'package:foodora/screens/restaurant_details_screen.dart'
    show RestaurantDetailsScreen;
import '../blocs/restaurant/restaurant_bloc.dart';
import '../blocs/restaurant/restaurant_state.dart';
import '../blocs/restaurant/restaurant_event.dart';
import '../widgets/restaurants_card.dart';
import '../widgets/custom_nav_bar.dart';
import '../blocs/cart/cart_bloc.dart';
import 'my_orders_screen.dart';

class HomeScreen extends StatefulWidget {
  static final List<Order> confirmedOrders = [];
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  final FocusNode _searchFocusNode = FocusNode();
  int _currentAdPage = 0;
  bool _isSearchExpanded = false;
  AnimationController? _animationController;
  Animation<double>? _searchBarAnimation;

  final String userName = "John";

  final List<String> _bannerImages = [
    'assets/images/banner.png',
    'assets/images/banner2.png',
    'assets/images/banner1.png',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _autoScrollBanners);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _searchBarAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
        _collapseSearch();
      }
    });
  }

  void _expandSearch() {
    setState(() {
      _isSearchExpanded = true;
    });
    _animationController?.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      _searchFocusNode.requestFocus();
    });
  }

  void _collapseSearch() {
    _searchFocusNode.unfocus();
    _animationController?.reverse().then((_) {
      setState(() {
        _isSearchExpanded = false;
      });
    });
  }

  void _onSearchChanged(String value) {
    context.read<RestaurantBloc>().add(SearchRestaurants(value));
  }

  void _autoScrollBanners() {
    if (!mounted) return;
    Future.delayed(const Duration(seconds: 4), () {
      if (_pageController.hasClients) {
        int nextPage = (_currentAdPage + 1) % _bannerImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _autoScrollBanners();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _pageController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isSearchExpanded) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(0),
                                child: Image.asset(
                                  'assets/images/logo1.png',
                                  height: 40,
                                  width: 150,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.restaurant_menu,
                                      color: Theme.of(context).primaryColor,
                                      size: 40,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '   Hi, $userName!',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                        255,
                                        244,
                                        241,
                                        197,
                                      ),
                                    ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onPressed: _expandSearch,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              context.read<RestaurantBloc>().add(
                                const SearchRestaurants(''),
                              );
                              _collapseSearch();
                            },
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                onChanged: _onSearchChanged,
                                decoration: InputDecoration(
                                  hintText: 'Search restaurants, cuisines...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            _searchController.clear();
                                            context.read<RestaurantBloc>().add(
                                              const SearchRestaurants(''),
                                            );
                                          },
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          switch (state.status) {
            case RestaurantStatus.initial:
              return const Center(child: Text('No restaurants to display'));
            case RestaurantStatus.loading:
              return Center(
                child: Lottie.asset(
                  'assets/animations/loading.json',
                  width: 200,
                  height: 200,
                  repeat: true,
                  animate: true,
                ),
              );
            case RestaurantStatus.loaded:
              if (state.filteredRestaurants.isEmpty &&
                  _searchController.text.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No restaurants found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try searching with different keywords',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          _searchController.clear();
                          context.read<RestaurantBloc>().add(
                            SearchRestaurants(''),
                          );
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear Search'),
                      ),
                    ],
                  ),
                );
              }
              if (state.filteredRestaurants.isEmpty) {
                return const Center(child: Text('No restaurants available'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<RestaurantBloc>().add(LoadRestaurants());
                },
                child: ListView(
                  children: [
                    if (_searchController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Found ${state.filteredRestaurants.length} ${state.filteredRestaurants.length == 1 ? 'restaurant' : 'restaurants'}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    if (_searchController.text.isEmpty) ...[
                      SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentAdPage = index;
                                  });
                                },
                                itemCount: _bannerImages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        _bannerImages[index],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Theme.of(
                                              context,
                                            ).primaryColor.withOpacity(0.1),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.restaurant_menu,
                                                    size: 48,
                                                    color: Theme.of(
                                                      context,
                                                    ).primaryColor,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Special Offer ${index + 1}',
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _bannerImages.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: _currentAdPage == index ? 24 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentAdPage == index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(
                                            context,
                                          ).primaryColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Restaurants Near You',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                      ),
                    ] else
                      const SizedBox(height: 8),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = state.filteredRestaurants[index];
                        return RestaurantCard(
                          restaurant: restaurant,
                          onTap: () {
                            final cartBloc = context.read<CartBloc>();
                            debugPrint(
                              'Passing CartBloc to RestaurantDetailsScreen: $cartBloc',
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: cartBloc,
                                  child: RestaurantDetailsScreen(
                                    restaurant: restaurant,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            case RestaurantStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.errorMessage}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RestaurantBloc>().add(LoadRestaurants());
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
          }
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyOrdersScreen(orders: HomeScreen.confirmedOrders),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
