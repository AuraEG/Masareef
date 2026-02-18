import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/features/home/home_screen.dart';
import '../models/onboarding_data_model.dart';
import 'widgets/next_button.dart';
import 'widgets/onboarding_content.dart';
import 'widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingDataModel> _pages = [
    OnboardingDataModel(
      title: 'Smart Expense Tracking',
      description:
          'Monitor your spending with clear insights and detailed financial reports.',
      icon: Icons.insights_rounded,
    ),
    OnboardingDataModel(
      title: 'Fast & Easy Notification',
      description:
          'Send and receive money instantly with real-time transaction updates.',
      icon: Icons.notifications_active_rounded,
    ),
    OnboardingDataModel(
      title: 'Fully Secured',
      description:
          'Keep your savings safe with advanced protection and full control over your finances.',
      icon: Icons.shield_rounded,
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onSkip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (_currentPage == _pages.length - 1) {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.08,
              child: _currentPage < _pages.length - 1
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                        child: TextButton(
                          onPressed: _onSkip,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 0.5.h,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingContent(data: _pages[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: screenHeight * 0.04,
              ),
              child: Column(
                children: [
                  PageIndicator(
                    currentPage: _currentPage,
                    pageCount: _pages.length,
                  ),
                  SizedBox(height: screenHeight * 0.035),
                  NextButton(onPressed: _onNext, isLastPage: isLastPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
