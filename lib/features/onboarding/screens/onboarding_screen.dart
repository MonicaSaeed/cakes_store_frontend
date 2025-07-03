import 'package:cakes_store_frontend/features/onboarding/data/model/onboarding_model.dart';
import 'package:cakes_store_frontend/features/onboarding/widget/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  Timer? _timer;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/images/cake5.jpg',
      title: 'Discover delightful cakes',
      subtitle: 'Browse our freshly baked cakes made with love and quality ingredients — ready for every occasion.',
    ),
    OnboardingData(
      image: 'assets/images/cake7.jpg',
      title: 'Get it delivered fresh',
      subtitle: 'Order with ease and enjoy fast, fresh delivery right to your doorstep.',
    ),
  ];

  void startAutoSlide() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 4), () {
      if (currentPage < onboardingPages.length - 1) {
        _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
      }
    });
  }


  @override
  void initState() {
    super.initState();
    startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingPages.length,
        onPageChanged: (index) {
          setState(() => currentPage = index);
          startAutoSlide();
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            data: onboardingPages[index],
            currentPage: index,
            totalPages: onboardingPages.length,
          );
        },
      ),
    );
  }
}

