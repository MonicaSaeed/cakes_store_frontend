import 'package:cakes_store_frontend/core/components/custom_card.dart';
import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_state.dart';
import 'package:cakes_store_frontend/features/home/presentation/components/category_list.dart';
import 'package:cakes_store_frontend/features/home/presentation/components/image_slide_show.dart';
import 'package:cakes_store_frontend/features/home/presentation/components/shimmer_home_loader.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ScreenUtilInit(
      designSize: const Size(
        360,
        690,
      ), // Default design size, All responsive calculations are based on this reference size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (_) => sl<HomeCubit>()..fetchProducts(),
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                "YumSlice Store",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: colorScheme.primary,
                    size: 18.w,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: colorScheme.primary,
                    size: 18.w,
                  ),
                  onPressed: () async {
                    await context.read<AuthCubit>().logoutUser();
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const ShimmerHomeLoader();
                } else if (state is HomeLoaded) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate responsive values based on screen size
                      final isSmallScreen = constraints.maxWidth < 350;
                      final gridCrossAxisCount = isSmallScreen ? 2 : 2;
                      final gridChildAspectRatio = isSmallScreen ? 0.6 : 0.55;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 240.h,
                              child: ImageSlideShow(
                                latestProduct:
                                    context.read<HomeCubit>().latestProduct,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Text(
                                "Categories",
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 110.h,
                              child: const CategoryList(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Freshly Baked",
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.primary,
                                          fontSize: 14.sp,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "See all",
                                      style: theme.textTheme.headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.primary,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                theme.colorScheme.primary,
                                            // fontSize: 14.sp,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.products.take(10).length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridCrossAxisCount,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 10.h,
                                      childAspectRatio: gridChildAspectRatio,
                                    ),
                                itemBuilder: (_, index) {
                                  final product = state.products[index];

                                  return BlocBuilder<FavCubit, FavState>(
                                    builder: (context, favState) {
                                      // final isFav =
                                      //     favState is FavLoaded &&
                                      //     favState.favProducts.any(
                                      //       (fav) => fav.id == product.id,
                                      //     );
                                      return CustomCard(
                                        cardtitle: product.name!,
                                        price: '${product.price}',
                                        rating: product.totalRating!,
                                        imageUrl: product.imageUrl!,
                                        favicon:
                                            context
                                                    .read<FavCubit>()
                                                    .favouritesProducts
                                                    .any(
                                                      (favProduct) =>
                                                          favProduct.id ==
                                                          product.id,
                                                    )
                                                ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                                : const Icon(
                                                  Icons.favorite_border,
                                                ),
                                        addcartIcon: const Icon(
                                          Icons.shopping_cart_outlined,
                                        ),
                                        onPressedFav: () {
                                          context
                                              .read<FavCubit>()
                                              .toggleFavourite(
                                                productId: product.id!,
                                              );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.h), // Extra bottom padding
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.w,
                            color: theme.colorScheme.error,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Oops! Something went wrong",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed:
                                () => context.read<HomeCubit>().fetchProducts(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                            ),
                            child: Text(
                              "Try Again",
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
