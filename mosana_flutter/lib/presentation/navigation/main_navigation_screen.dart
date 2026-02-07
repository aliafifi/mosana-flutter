import 'package:flutter/material.dart';
import '../../core/config/colors.dart';
import '../screens/home/home_screen.dart';
import '../screens/explore/search_explore_screen.dart';
import '../screens/wallet/wallet_main_screen.dart';

/// Main navigation container that holds all primary screens
/// Uses indexed stack to preserve state across tab switches
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Main screens that appear in bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchExploreScreen(),
    const Center(child: Text('DAO Coming Soon', style: TextStyle(color: Colors.white))), // Placeholder
    const WalletMainScreen(),
  ];

  void _onBottomNavTap(int index) {
    // Skip the middle button (FAB)
    if (index == 2) {
      _showCreatePost();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void _showCreatePost() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Create Post feature coming soon!'),
        backgroundColor: AppColors.mosanaPurple,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      extendBody: false,
      resizeToAvoidBottomInset: false, // Prevent keyboard from pushing up nav
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePost,
        backgroundColor: AppColors.mosanaPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.deepPurpleBlack,
        border: Border(
          top: BorderSide(
            color: AppColors.textSecondary.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.mosanaPurple,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 24, height: 24), // Spacer for FAB
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            activeIcon: Icon(Icons.account_balance),
            label: 'DAO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
        ],
      ),
    );
  }
}
