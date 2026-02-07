import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../../data/mock_data.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/post_model.dart';
import '../../widgets/common/user_avatar.dart';
import '../../widgets/post/post_card.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../wallet/send_tip_screen.dart';
import '../wallet/mint_nft_screen.dart';
import '../wallet/transaction_history_screen.dart';
import '../wallet/wallet_settings_screen.dart';
import '../explore/search_explore_screen.dart';
import '../settings/settings_screen.dart';
import '../analytics/analytics_dashboard_screen.dart';
import '../interactions/advanced_interactions_screen.dart';

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
      drawer: _buildNavigationDrawer(context),
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
          // Menu button
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          const SizedBox(width: 8),
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

  Widget _buildNavigationDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.deepPurpleBlack,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/mosana-logo.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'mosana',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Social good meets Web3',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerSection('CORE'),
                  _buildDrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildDrawerItem(
                    icon: Icons.search,
                    title: 'Search & Explore',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchExploreScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(color: AppColors.borderDark, height: 24),

                  _buildDrawerSection('WALLET'),
                  _buildDrawerItem(
                    icon: Icons.attach_money,
                    title: 'Send Tips',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SendTipScreen(
                            recipient: UserModel(
                              walletAddress: '7xKXtg2CW5UL2n8T9Fzs3hY1qP9vR8mK4jL6nB3cD5eF',
                              username: '@mosana_user',
                              profileImage: 'https://i.pravatar.cc/150?img=1',
                              isVerified: true,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.auto_awesome,
                    title: 'Mint NFT',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MintNFTScreen(
                            post: PostModel(
                              id: 'demo_post_1',
                              content: 'This is a demo post that can be minted as an NFT!',
                              authorId: 'user_1',
                              createdAt: DateTime.now(),
                              likesCount: 42,
                              commentsCount: 12,
                              tipsCount: 5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.history,
                    title: 'Transaction History',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TransactionHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Wallet Settings',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WalletSettingsScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(color: AppColors.borderDark, height: 24),

                  _buildDrawerSection('ADVANCED'),
                  _buildDrawerItem(
                    icon: Icons.bar_chart,
                    title: 'Analytics',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AnalyticsDashboardScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Interactions',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdvancedInteractionsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.borderDark,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'v1.0.0 • Phase 4 Complete',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.textPrimary,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
