import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:santhosh_bakery/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to KKR Fruits',
      'description':
          'KKR Fruits is your one-stop shop for fresh, seasonal fruits and high-quality stationery items.',
      'image':
          'assets/images/onboarding_1.png', // Placeholder, will handle missing asset gracefully
      'icon': 'bakery_dining',
    },
    {
      'title': 'What We Offer',
      'description':
          'Fresh Seasonal Fruits\nDaily Essentials\nStationery Items',
      'image': 'assets/images/onboarding_2.png',
      'icon': 'category',
    },
    {
      'title': 'Fresh & Local',
      'description':
          'Quality checked fresh fruits delivered to your home in Coimbatore.',
      'image': 'assets/images/onboarding_3.png',
      'icon': 'location_on',
    },
  ];

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'bakery_dining':
        return Icons.storefront;
      case 'category':
        return Icons.category;
      case 'location_on':
        return Icons.location_on;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(
                    title: _pages[index]['title']!,
                    description: _pages[index]['description']!,
                    icon: _getIconData(_pages[index]['icon']!),
                  );
                },
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFFFAB91).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 100, color: const Color(0xFFFFAB91)),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4E342E),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 18,
              color: const Color(0xFF8D8D8D),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFD84315)
                      : const Color(0xFFFFAB91).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == _pages.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD84315),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                _currentPage == _pages.length - 1 ? 'Start' : 'Next',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
