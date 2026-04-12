import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/dashboard_screen.dart';
import '../screens/main/favorites_screen.dart';
// Note: Placeholder for ProfileScreen if exists, currently we can map to Dashboard.

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Player Screen Placeholder', style: TextStyle(color: Colors.white))),
    const FavoritesScreen(),
    const DashboardScreen(), // Mapping profile icon to Dashboard since dashboard has user stats
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Current Tab
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          
          // Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(48)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 32, left: 24, right: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131315).withOpacity(0.6),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(0, Icons.home, 'Home'),
                      _buildNavItem(1, Icons.play_circle_outline, 'Player'),
                      _buildNavItem(2, Icons.favorite_outline, 'Favorites'),
                      _buildNavItem(3, Icons.person_outline, 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        padding: const EdgeInsets.all(12),
        decoration: isSelected
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: AppColors.primaryContainer.withOpacity(0.5), blurRadius: 10),
                ],
              )
            : const BoxDecoration(
                color: Colors.transparent,
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.onPrimaryFixed : Colors.grey[500],
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                letterSpacing: 2,
                color: isSelected ? AppColors.onPrimaryFixed : Colors.grey[500],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
