import 'package:cakes_store_frontend/core/services/preference_manager.dart';
import 'package:cakes_store_frontend/features/onboarding/data/model/onboarding_model.dart';
import 'package:cakes_store_frontend/features/onboarding/widget/onboarding_widget.dart';
import 'package:cakes_store_frontend/main.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/images/cake40.jpg',
      title: 'Discover delightful cakes',
      subtitle:
          'Browse our freshly baked cakes made with love and quality ingredients — ready for every occasion.',
    ),
    OnboardingData(
      image: 'assets/images/cake37.jpg',
      title: 'Get it delivered fresh',
      subtitle:
          'Order with ease and enjoy fast, fresh delivery right to your doorstep.',
    ),
    OnboardingData(
      image: 'assets/images/cake31.jpg',
      title: 'Celebrate Every Moment',
      subtitle:
          'From birthdays to sweet cravings, find the perfect cake to make every moment special.',
    ),
  ];

  void onNext() {
    if (currentPage < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (currentPage == (onboardingPages.length - 1)) {
      PreferencesManager().setBool('isFirstTime', false);
      Navigator.push(context, MaterialPageRoute(builder: (_) => AuthGate()));
    } else {}
  }

  void onSkip() {
    _controller.jumpToPage(onboardingPages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingPages.length,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            data: onboardingPages[index],
            currentPage: index,
            totalPages: onboardingPages.length,
            onNext: onNext,
            onSkip: onSkip,
          );
        },
      ),
    );
  }
}
