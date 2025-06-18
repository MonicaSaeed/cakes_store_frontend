import 'package:cakes_store_frontend/core/components/navigation_index_notifier.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_router.dart';

class NavigationBarScreen extends StatefulWidget {
  NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  final List<String> _routes = [
    AppRouter.home,
    AppRouter.favorites,
    AppRouter.orders,
    // AppRouter.cart,
    AppRouter.shop,
    AppRouter.profile,
  ];

  // Maintain a navigator key for each tab
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[navIndexNotifier.value].currentState!
                  .maybePop();
          if (isFirstRouteInCurrentTab) {
            return;
          }
        }
      },
      child: ValueListenableBuilder<int>(
        valueListenable: navIndexNotifier,
        builder: (context, currentIndex, _) {
          return Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: List.generate(
                _routes.length,
                (index) => _buildNavigator(index),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == currentIndex) {
                  _navigatorKeys[index].currentState?.popUntil(
                    (route) => route.isFirst,
                  );
                }
                navIndexNotifier.value = index;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: 'Shop',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return AppRouter().generateRoute(
          RouteSettings(name: _routes[index], arguments: settings.arguments),
        );
      },
    );
  }
}
