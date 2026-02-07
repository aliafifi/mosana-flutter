import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/feed_provider.dart';
import '../../widgets/post/post_card.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

      // Load more when near bottom
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        ref.read(feedProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    if (index == 2) {
      // Center FAB - Create post
      // TODO: Navigate to create post screen
      return;
    }

    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state
    final authState = ref.watch(authStateProvider);
    final currentUser = authState is _AuthStateAuthenticated ? authState.username : null;

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
                _buildHeader(currentUser),

                // Body (Feed, Explore, Notifications, Profile)
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      _buildFeed(), // Home Feed
                      _buildExplore(), // Explore (placeholder)
                      const SizedBox.shrink(), // Center FAB placeholder
                      const NotificationsScreen(), // Notifications
                      const ProfileScreen(), // Profile
                    ],
                  ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create post feature coming soon!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: AppColors.mosanaPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader(String? username) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _isHeaderScrolled
            ? AppColors.cardSurface.withOpacity(0.8)
            : Colors.transparent,
        border: Border(
          bottom: _isHeaderScrolled
              ? BorderSide(color: AppColors.borderColor.withOpacity(0.5))
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          // Logo
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              '✨ mosana',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),

          const Spacer(),

          // Username (if available)
          if (username != null) ...[
            Text(
              '@$username',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Settings
          IconButton(
            icon: Icon(Icons.settings_outlined, color: AppColors.textSecondary),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    final feedState = ref.watch(feedProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(feedProvider.notifier).refresh(),
      color: AppColors.mosanaPurple,
      backgroundColor: AppColors.cardSurface,
      child: switch (feedState) {
        // Initial loading
        _FeedStateInitial() || _FeedStateLoading(isRefresh: false) => _buildLoading(),

        // Loaded with posts
        _FeedStateLoaded(posts: final posts) ||
        _FeedStateLoadingMore(posts: final posts) =>
          _buildPostsList(posts, feedState is _FeedStateLoadingMore),

        // Refreshing (show current posts)
        _FeedStateLoading(isRefresh: true) => _buildLoading(),

        // Error
        _FeedStateError(message: final error) => _buildError(error),
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.mosanaPurple),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading feed...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList(List<Map<String, dynamic>> posts, bool isLoadingMore) {
    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.post_add,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No posts yet',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first to share something!',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: posts.length + (isLoadingMore ? 1 : 0),
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
        // Show loading indicator at bottom
        if (index == posts.length) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.mosanaPurple),
              ),
            ),
          );
        }

        final post = posts[index];
        final postId = post['id'] as String;

        return PostCard(
          post: post,
          onLike: () => ref.read(postActionProvider(postId)).toggleLike(),
          onComment: () {
            // TODO: Navigate to post detail/comments
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Comments feature coming soon!')),
            );
          },
          onTip: () {
            // TODO: Show tip dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tip feature coming soon!')),
            );
          },
          onMint: () {
            // TODO: Show mint confirmation
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mint feature coming soon!')),
            );
          },
          onShare: () {
            // TODO: Native share
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share feature coming soon!')),
            );
          },
          onTap: () {
            // TODO: Navigate to post detail
          },
        );
      },
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(feedProvider.notifier).loadFeed(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mosanaPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExplore() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Explore',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming soon!',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        border: Border(
          top: BorderSide(color: AppColors.borderColor.withOpacity(0.3)),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex == 2 ? 0 : _selectedIndex,
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
            icon: SizedBox(height: 24), // Spacer for FAB
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
