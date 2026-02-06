import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../../data/mock_data.dart';
import '../../widgets/common/user_avatar.dart';
import '../../widgets/post/post_card.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 20 && !_isHeaderScrolled) {
        setState(() => _isHeaderScrolled = true);
      } else if (_scrollController.offset <= 20 && _isHeaderScrolled) {
        setState(() => _isHeaderScrolled = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: [
                    AppColors.mosanaPurple.withOpacity(0.1),
                    AppColors.pureBlack,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Feed
                Expanded(
                  child: _buildFeed(),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNav(),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create post
        },
        backgroundColor: AppColors.mosanaPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _isHeaderScrolled
            ? AppColors.deepPurpleBlack.withOpacity(0.95)
            : Colors.transparent,
        border: _isHeaderScrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.textSecondary.withOpacity(0.1),
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // Logo
          Image.asset(
            'assets/images/mosana-logo.png',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 8),
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              'mosana',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          const Spacer(),

          // Notifications bell
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              // Notification badge
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 4),

          // Profile avatar
          UserAvatar.small(
            imageUrl: MockData.users[0]['profileImage'] as String?,
            username: 'You',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      color: AppColors.mosanaPurple,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: MockData.posts.length,
        itemBuilder: (context, index) {
          final post = MockData.posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: PostCard(
              post: post,
              onLike: () {
                // TODO: Like post
                print('Like post ${post['_id']}');
              },
              onComment: () {
                // TODO: Open comments
                print('Comment on post ${post['_id']}');
              },
              onTip: () {
                // TODO: Send tip
                print('Tip post ${post['_id']}');
              },
              onShare: () {
                // TODO: Share post
                print('Share post ${post['_id']}');
              },
              onMint: () {
                // TODO: Mint as NFT
                print('Mint post ${post['_id']}');
              },
              onTap: () {
                // TODO: Open post detail
                print('Open post ${post['_id']}');
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.deepPurpleBlack,
        border: Border(
          top: BorderSide(
            color: AppColors.textSecondary.withOpacity(0.1),
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
            icon: SizedBox(width: 24), // Spacer for FAB
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
