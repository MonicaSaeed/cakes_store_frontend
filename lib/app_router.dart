import 'dart:developer';

import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/get_orders_cubit.dart';
import 'package:cakes_store_frontend/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:cakes_store_frontend/features/shop/presentation/screens/shop_product_screen.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:cakes_store_frontend/features/home/presentation/screen/category_screen.dart';
import 'package:cakes_store_frontend/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  static const String home = '/home';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String favorites = '/favorites';
  static const String cart = '/cart';
  static const String login = '/login';
  static const String register = '/register';
  static const String notFound = '/not-found';
  static const String shop = '/shop';
  static const String productList = '/product-list';
  static const String productDetails = '/product-details';
  static const String category = '/category-products';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => const AuthGate());
      case home:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return CupertinoPageRoute(builder: (_) => const ProfileScreen());
      case orders:
      log('into ordewrsssssssssss');
        return CupertinoPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => GetOrdersCubit()..getOrders(context.read<UserCubit>().currentUser?.id),
                child: OrdersScreen(),
              ),
        );
      case favorites:
        return CupertinoPageRoute(builder: (_) => const FavoritesScreen());
      case cart:
        return CupertinoPageRoute(builder: (_) => CartScreen());
      case login:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case register:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      case shop:
        return CupertinoPageRoute(builder: (_) => const ShopProductScreen());
      case productDetails:
        return CupertinoPageRoute(
          builder:
              (_) =>
                  ProductDetailsScreen(productId: settings.arguments as String),
        );
      case category:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryName = args['categoryName'] as String;
        final homeCubit = args['homeCubit'] as HomeCubit;
        final favCubit = args['favCubit'] as FavCubit;

        return CupertinoPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: homeCubit),
                  BlocProvider.value(value: favCubit),
                ],
                child: CategoryScreen(categoryName: categoryName),
              ),
        );
      default:
        return CupertinoPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
