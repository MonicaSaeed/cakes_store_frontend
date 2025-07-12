import 'package:cakes_store_frontend/app_router.dart';
import 'package:cakes_store_frontend/core/components/navigation_index_notifier.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/home/presentation/cubit/home_cubit.dart';
import 'package:cakes_store_frontend/features/shared_product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlideShow extends StatefulWidget {
  final Product? latestProduct;
    final String? userId;

  const ImageSlideShow({super.key, this.latestProduct, this.userId});

  @override
  State<ImageSlideShow> createState() => _ImageSlideShowState();
}

class _ImageSlideShowState extends State<ImageSlideShow> {
  int _currentIndex = 0;

  List<Map<String, dynamic>> getSlides(BuildContext context) {
    final slides = <Map<String, dynamic>>[];

    if (widget.latestProduct != null) {
      slides.add({
        'imageUrl': widget.latestProduct!.imageUrl,
        'title': 'Try Our New ${widget.latestProduct!.name}!',
        'buttonTitle': 'View Details',
        'discount': widget.latestProduct!.discountPercentage,
        'onButtonPressed': (context) {
           Navigator.pushNamed(
          context,
          AppRouter.productDetails,
          arguments: {'productId': widget.latestProduct!.id, 'userId':  widget.userId},
        );
        },
      });
    }

    slides.addAll([
      {
        'imageUrl': 'assets/images/chocolate_cake.jpg',
        'title': 'Chocolate Cakes',
        'buttonTitle': 'Shop Now',
        'onButtonPressed': (context) {
          navIndexNotifier.value = 4;
        },
      },
      {
        'imageUrl': 'assets/images/cupcakes.jpg',
        'title': 'Cupcakes Collection',
        'buttonTitle': 'Show Collection',
        'onButtonPressed': (BuildContext outerContext) {
          Navigator.pushNamed(
              context,
              AppRouter.category,
              arguments: {
                'categoryName': 'Cupcakes',
                'homeCubit': context.read<HomeCubit>(),
                'favCubit': context.read<FavCubit>(),
              },
            );
        },
      },
    ]);

    return slides;
  }

  @override
  Widget build(BuildContext context) {
    final slides = getSlides(context);

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220.h, // Responsive height
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items:
              slides.map((slide) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          slide['imageUrl'].toString().startsWith('http')
                              ? NetworkImage(slide['imageUrl']) as ImageProvider
                              : AssetImage(slide['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                            stops: [0.2, 0.6],
                          ),
                        ),
                      ),

                      // Discount
                      if (slide['discount'] != null)
                        Positioned(
                          top: 16.h,
                          right: 16.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '${slide['discount']}% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),

                      // Bottom Content
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slide['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 6,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              ElevatedButton(
                                onPressed:
                                    () => slide['onButtonPressed'](context),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                ),
                                child: Text(
                                  slide['buttonTitle'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),

        // Indicator Dots
        Positioned(
          left: 0,
          right: 0,
          bottom: 28.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                slides.asMap().entries.map((entry) {
                  return Container(
                    width: 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == entry.key
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
