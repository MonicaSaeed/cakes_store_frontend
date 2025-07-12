import 'package:cakes_store_frontend/core/components/navigation_index_notifier.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/get_orders_cubit.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/presentation/screen/cart_screen.dart';
import '../../features/favorites/presentation/screen/favorites_screen.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/orders/presentation/screen/orders_screen.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/shop/presentation/screens/shop_product_screen.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          if (navIndexNotifier.value != 0) {
            navIndexNotifier.value = 0;
          } else {
            return;
          }
        }
      },
      child: ValueListenableBuilder<int>(
        valueListenable: navIndexNotifier,
        builder: (context, currentIndex, _) {
          return Scaffold(
            body:
                [
                  const HomeScreen(),
                  const FavoritesScreen(),
                  BlocProvider(
                    create:
                        (_) =>
                            GetOrdersCubit()..getOrders(
                              context.read<UserCubit>().currentUser?.id,
                            ),
                    child: const OrdersScreen(),
                  ),
                  CartScreen(),
                  const ShopProductScreen(),
                  const ProfileScreen(),
                ][currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
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
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: 'Cart',
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
}
