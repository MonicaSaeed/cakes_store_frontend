import 'package:flutter/material.dart';

import '../../features/cart/presentation/screen/cart_screen.dart';
import '../../features/favorites/presentation/screen/favorites_screen.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/orders/presentation/screen/orders_screen.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/shop/presentation/screens/shop_product_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          if (currentIndex != 0) {
            setState(() {
              currentIndex = 0;
            });
          } else {
            // If already on Home, exit the app
            return; // This will close the app
          }
        }
      },
      child: Scaffold(
        body:
            [
              const HomeScreen(),
              const FavoritesScreen(),
              const OrdersScreen(),
              const CartScreen(),
              const ShopProductScreen(),
              const ProfileScreen(),
            ][currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
