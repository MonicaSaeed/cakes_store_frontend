import 'package:cakes_store_frontend/core/components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlideShow extends StatefulWidget {
  ImageSlideShow({super.key});

  final List<Map<String, dynamic>> slides = [
    {
      'imageUrl': 'assets/images/wedding_cake.jpg',
      'title': 'Wedding Cakes',
      'buttonTitle': 'Show Collection',
      "onButtonPressed": (context) {
        //  Navigator.pushNamed(context, AppRouter.categoryList, arguments: 'wedding');
      },
    },
    {
      'imageUrl': 'assets/images/chocolate_cake.jpg',
      'title': 'Chocolate Cakes',
      'buttonTitle': 'Shop Now',
      "onButtonPressed": (context) {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => NavigationBarScreen(currentIndex: 3),
          ),
          // (route) => false,
        );
      },
    },
    {
      'imageUrl': 'assets/images/cupcakes.jpg',
      'title': 'Cupcakes Collection',
      'buttonTitle': 'Show Collection',
      "onButtonPressed": (context) {
        //  Navigator.pushNamed(context, AppRouter.categoryList, arguments: 'cupcakes');
      },
    },
  ];

  @override
  State<ImageSlideShow> createState() => _ImageSlideShowState();
}

class _ImageSlideShowState extends State<ImageSlideShow> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 240,
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
              widget.slides.map((slide) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(slide['imageUrl']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
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
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              slide['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 6,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed:
                                  () => slide['onButtonPressed'](context),
                              child: Text(
                                slide['buttonTitle']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        // Dot indicators
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                widget.slides.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
