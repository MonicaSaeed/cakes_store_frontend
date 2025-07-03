import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/features/onboarding/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int currentPage;
  final int totalPages;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    data.image,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: currentPage == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? colorScheme.primary
                          : colorScheme.tertiary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const Spacer(),
              if(currentPage == totalPages - 1)
                  CustomElevatedButton(textdata: 'START',
                   onPressed: () { 
                   },),
            
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
