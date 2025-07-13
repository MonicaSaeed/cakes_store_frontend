import 'package:cakes_store_frontend/app_router.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  static final List<Map<String, String>> _categories = [
    {'name': 'Birthday', 'svgIcon': 'assets/svg/birthday.svg'},
    {'name': 'Wedding', 'svgIcon': 'assets/svg/wedding.svg'},
    {'name': 'Cheesecakes', 'svgIcon': 'assets/svg/cheesecake.svg'},
    {'name': 'Cupcakes', 'svgIcon': 'assets/svg/cupcakes.svg'},
    {'name': 'Molten Cakes', 'svgIcon': 'assets/svg/molten.svg'},
  ];

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        // calculate a safe height that works in both portrait and landscape
        final double maxAvailableHeight = constraints.maxHeight;
        final double safeHeight =
            maxAvailableHeight > 140
                ? 140
                : maxAvailableHeight * 0.9; // fallback if too small

        return SizedBox(
          height: safeHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, index) {
              final category = _categories[index];
              final isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pushNamed(
                    context,
                    AppRouter.category,
                    arguments: {
                      'categoryName': category['name'],
                      'homeCubit': context.read<HomeCubit>(),
                      'favCubit': context.read<FavCubit>(),
                    },
                  ).then((_) {
                    setState(() {
                      _selectedIndex = -1;
                    });
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 150),
                      scale: isSelected ? 1.08 : 1.0,
                      child: Container(
                        width: 60.w.clamp(40.0, 70.0),
                        height: 60.w.clamp(40.0, 70.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primary,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(
                                isSelected ? 0.4 : 0.3,
                              ),
                              blurRadius: isSelected ? 10 : 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            category['svgIcon']!,
                            width: 28.w.clamp(20.0, 36.0),
                            height: 28.w.clamp(20.0, 36.0),
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? Colors.white
                                  : isDarkMode
                                  ? colorScheme.surfaceTint
                                  : LightThemeColors.iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.only(top: isSelected ? 1.h : 0),
                      child: SizedBox(
                        width: 70.w.clamp(50.0, 90.0),
                        child: Tooltip(
                          message: category['name']!,
                          child: Text(
                            category['name']!,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color:
                                  isDarkMode
                                      ? colorScheme.surfaceTint
                                      : colorScheme.primary,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                              fontSize:
                                  isLandscape ? 7.sp : 11.sp.clamp(9.sp, 13.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
