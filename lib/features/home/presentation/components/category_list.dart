import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView.separated(
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
            // Navigator.pushNamed(context, AppRouter.productList, arguments: category['name']);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 150),
                scale: isSelected ? 1.08 : 1.0,
                child: Container(
                  width: 66.w,
                  height: 66.h,
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
                      width: 32.w,
                      height: 32.h,
                      colorFilter: ColorFilter.mode(
                        isSelected ? Colors.white : LightThemeColors.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.only(top: isSelected ? 2.h : 0),
                child: SizedBox(
                  width: 80.w,
                  child: Tooltip(
                    message: category['name']!,
                    child: Text(
                      category['name']!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
