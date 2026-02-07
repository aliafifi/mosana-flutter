import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/colors.dart';
import '../../widgets/post/post_card.dart';
import '../../providers/feed_provider.dart';
import '../notifications/notifications_screen.dart';

/// Home screen with real-time feed from backend API
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderScrolled = false;

  @override
  void initState() {
    super.initState();
    
    // Header scroll listener
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 20 && !_isHeaderScrolled) {
      setState(() => _isHeaderScrolled = true);
    } else if (_scrollController.offset <= 20 && _isHeaderScrolled) {
      setState(() => _isHeaderScrolled = false);
    }

    // Load more when near bottom
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(feedProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await ref.read(feedProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedProvider);

    return Material(
      color: AppColors.pureBlack,
      child: Stack(
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

          // Content - No SafeArea needed here (MainNavigationScreen handles it)
          Column(
            children: [
              // Header
              _buildHeader(),

              // Feed
              Expanded(
                child: _buildFeed(feedState),
              ),
            ],
          ),
        ],
      ),
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
              // TODO: Add notification badge from API
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeed(FeedState state) {
    // Handle different feed states with type checking
    if (state is FeedStateInitial) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.mosanaPurple),
        ),
      );
    } else if (state is FeedStateLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.mosanaPurple),
        ),
      );
    } else if (state is FeedStateLoaded) {
      if (state.posts.isEmpty) {
        return _buildEmptyState();
      }

      return RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.mosanaPurple,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: state.posts.length + (state.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            // Loading indicator at bottom
            if (index >= state.posts.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.mosanaPurple),
                  ),
                ),
              );
            }

            final post = state.posts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PostCard(
                post: post,
                onLike: () => _handleLike(post),
                onComment: () => _handleComment(post),
                onTip: () => _handleTip(post),
                onShare: () => _handleShare(post),
                onMint: () => _handleMint(post),
                onTap: () => _handlePostTap(post),
              ),
            );
          },
        ),
      );
    } else if (state is FeedStateLoadingMore) {
      return RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.mosanaPurple,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: state.posts.length + 1,
          itemBuilder: (context, index) {
            if (index >= state.posts.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.mosanaPurple),
                  ),
                ),
              );
            }

            final post = state.posts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PostCard(
                post: post,
                onLike: () => _handleLike(post),
                onComment: () => _handleComment(post),
                onTip: () => _handleTip(post),
                onShare: () => _handleShare(post),
                onMint: () => _handleMint(post),
                onTap: () => _handlePostTap(post),
              ),
            );
          },
        ),
      );
    } else if (state is FeedStateError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load feed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(feedProvider.notifier).refresh(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mosanaPurple,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    // Fallback (should never reach here)
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.mosanaPurple),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.feed_outlined,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No posts yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Be the first to post something!',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to create post
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tap the + button to create a post'),
                  backgroundColor: AppColors.mosanaPurple,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mosanaPurple,
            ),
            child: const Text('Create Post'),
          ),
        ],
      ),
    );
  }

  // ===================== ACTION HANDLERS =====================

  void _handleLike(Map<String, dynamic> post) {
    final postId = post['_id'] as String;
    ref.read(feedProvider.notifier).toggleLike(postId);
  }

  void _handleComment(Map<String, dynamic> post) {
    // TODO: Open comments screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comments feature coming soon!'),
        backgroundColor: AppColors.mosanaPurple,
      ),
    );
  }

  void _handleTip(Map<String, dynamic> post) {
    // TODO: Open tip screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tipping feature coming soon!'),
        backgroundColor: AppColors.mosanaPurple,
      ),
    );
  }

  void _handleShare(Map<String, dynamic> post) {
    // TODO: Share post
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing feature coming soon!'),
        backgroundColor: AppColors.mosanaPurple,
      ),
    );
  }

  void _handleMint(Map<String, dynamic> post) {
    // TODO: Mint as NFT
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('NFT minting feature coming soon!'),
        backgroundColor: AppColors.mosanaPurple,
      ),
    );
  }

  void _handlePostTap(Map<String, dynamic> post) {
    // TODO: Navigate to post detail screen
    print('Post tapped: ${post['_id']}');
  }
}
