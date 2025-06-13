import 'package:cakes_store_frontend/features/shop/presentation/screens/shop_product_screen.dart';
import 'package:flutter/cupertino.dart';

import 'core/components/not_found_screen.dart';
import 'features/auth/presentation/screen/login_screen.dart';
import 'features/auth/presentation/screen/register_screen.dart';
import 'features/cart/presentation/screen/cart_screen.dart';
import 'features/favorites/presentation/screen/favorites_screen.dart';
import 'features/home/presentation/screen/home_screen.dart';
import 'features/orders/presentation/screen/orders_screen.dart';
import 'features/profile/presentation/screen/profile_screen.dart';

class AppRouter {
  // Define your routes here
  static const String home = '/';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String favorites = '/favorites';
  static const String cart = '/cart';
  static const String productDetails = '/product-details';
  static const String login = '/login';
  static const String register = '/register';
  static const String notFound = '/not-found';
  static const String shop = '/shop';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return CupertinoPageRoute(builder: (_) => const ProfileScreen());
      case orders:
        return CupertinoPageRoute(builder: (_) => const OrdersScreen());
      case favorites:
        return CupertinoPageRoute(builder: (_) => const FavoritesScreen());
      case cart:
        return CupertinoPageRoute(builder: (_) => const CartScreen());
      case login:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case register:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      case shop:
        return CupertinoPageRoute(builder: (_) => const ShopProductScreen());

      default:
        return CupertinoPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
