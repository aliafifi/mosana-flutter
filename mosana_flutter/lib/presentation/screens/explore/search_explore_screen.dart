import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/user_avatar.dart';
import '../../widgets/post/post_card.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/post_model.dart';
import '../../../data/mock_data.dart';

/// Search and explore screen
class SearchExploreScreen extends StatefulWidget {
  const SearchExploreScreen({super.key});

  @override
  State<SearchExploreScreen> createState() => _SearchExploreScreenState();
}

class _SearchExploreScreenState extends State<SearchExploreScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;
  
  String _searchQuery = '';
  bool _isSearching = false;
  
  // Trending topics (mock data)
  final List<TrendingTopic> _trendingTopics = [
    TrendingTopic(
      tag: 'CharityForGood',
      posts: 1234,
      trend: TrendStatus.up,
    ),
    TrendingTopic(
      tag: 'NFTForCharity',
      posts: 892,
      trend: TrendStatus.up,
    ),
    TrendingTopic(
      tag: 'SolanaImpact',
      posts: 678,
      trend: TrendStatus.hot,
    ),
    TrendingTopic(
      tag: 'CryptoGiving',
      posts: 456,
      trend: TrendStatus.up,
    ),
    TrendingTopic(
      tag: 'Web3Good',
      posts: 234,
      trend: TrendStatus.stable,
    ),
  ];
  
  // Charity leaderboard (mock data)
  final List<CharityLeader> _charityLeaders = [
    CharityLeader(
      rank: 1,
      name: 'Red Cross',
      icon: '🏥',
      totalRaised: 45678.90,
      donors: 1234,
    ),
    CharityLeader(
      rank: 2,
      name: 'Water.org',
      icon: '💧',
      totalRaised: 34567.80,
      donors: 987,
    ),
    CharityLeader(
      rank: 3,
      name: 'UNICEF',
      icon: '👶',
      totalRaised: 23456.70,
      donors: 765,
    ),
    CharityLeader(
      rank: 4,
      name: 'Doctors Without Borders',
      icon: '⚕️',
      totalRaised: 12345.60,
      donors: 543,
    ),
    CharityLeader(
      rank: 5,
      name: 'World Wildlife Fund',
      icon: '🐼',
      totalRaised: 9876.50,
      donors: 321,
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
  
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _isSearching = query.isNotEmpty;
    });
  }
  
  List<Map<String, dynamic>> get _filteredUsers {
    if (_searchQuery.isEmpty) return MockData.users;
    return MockData.users
        .where((user) => (user['username'] as String? ?? '').toLowerCase().contains(_searchQuery))
        .toList();
  }
  
  List<Map<String, dynamic>> get _filteredPosts {
    if (_searchQuery.isEmpty) return MockData.posts;
    return MockData.posts
        .where((post) {
          final content = (post['content'] as String? ?? '').toLowerCase();
          final username = (post['author']?['username'] as String? ?? '').toLowerCase();
          return content.contains(_searchQuery) || username.contains(_searchQuery);
        })
        .toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.pureBlack,
      child: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.mosanaPurple.withOpacity(0.15),
                    AppColors.pureBlack,
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            bottom: false, // Don't add padding at bottom
            child: Column(
              children: [
                // Search bar
                _buildSearchBar(),
                
                // Tabs (only show when not searching)
                if (!_isSearching) _buildTabs(),
                
                // Content
                Expanded(
                  child: _isSearching
                      ? _buildSearchResults()
                      : _buildExploreContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GlassCard(
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Search users, posts, topics...',
            hintStyle: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.mosanaPurple,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.mosanaPurple,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Trending'),
          Tab(text: 'Top Users'),
          Tab(text: 'Charities'),
        ],
      ),
    );
  }
  
  Widget _buildSearchResults() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: AppColors.mosanaPurple,
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: const [
              Tab(text: 'Users'),
              Tab(text: 'Posts'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildUserResults(),
                _buildPostResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserResults() {
    if (_filteredUsers.isEmpty) {
      return _buildEmptyState('No users found');
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _filteredUsers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildUserCard(_filteredUsers[index]),
        );
      },
    );
  }
  
  Widget _buildPostResults() {
    if (_filteredPosts.isEmpty) {
      return _buildEmptyState('No posts found');
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _filteredPosts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PostCard(
            post: _filteredPosts[index],
            onLike: () {},
            onComment: () {},
            onTip: () {},
            onShare: () {},
            onMint: () {},
            onTap: () {},
          ),
        );
      },
    );
  }
  
  Widget _buildExploreContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTrendingTab(),
        _buildTopUsersTab(),
        _buildCharitiesTab(),
      ],
    );
  }
  
  Widget _buildTrendingTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _trendingTopics.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildTrendingCard(_trendingTopics[index]),
        );
      },
    );
  }
  
  Widget _buildTopUsersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: MockData.users.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildUserCard(MockData.users[index]),
        );
      },
    );
  }
  
  Widget _buildCharitiesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _charityLeaders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCharityCard(_charityLeaders[index]),
        );
      },
    );
  }
  
  Widget _buildTrendingCard(TrendingTopic topic) {
    return GlassCard(
      child: InkWell(
        onTap: () {
          // Navigate to topic posts
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              // Trend indicator
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: _getTrendGradient(topic.trend),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getTrendIcon(topic.trend),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Topic info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${topic.tag}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${topic.posts} posts',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Trend badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _getTrendColor(topic.trend).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getTrendLabel(topic.trend),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getTrendColor(topic.trend),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildUserCard(Map<String, dynamic> user) {
    return GlassCard(
      child: Row(
        children: [
          UserAvatar(
            imageUrl: user['avatar'],
            username: user['username'] ?? 'User',
            isVerified: user['verified'] ?? false,
            size: 56,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user['username'] ?? 'User',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (user['verified'] == true) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: AppColors.mosanaBlue,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user['bio'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildStatBadge(
                      '${user['followersCount'] ?? 0}',
                      'followers',
                    ),
                    const SizedBox(width: 12),
                    _buildStatBadge(
                      '${user['posts'] ?? 0}',
                      'posts',
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Follow button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Follow',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCharityCard(CharityLeader charity) {
    return GlassCard(
      variant: charity.rank <= 3 ? GlassCardVariant.highlighted : GlassCardVariant.standard,
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: _getRankGradient(charity.rank),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '#${charity.rank}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Charity icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                charity.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  charity.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${charity.totalRaised.toStringAsFixed(0)} raised',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${charity.donors} donors',
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
    );
  }
  
  Widget _buildStatBadge(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
  
  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Gradient _getTrendGradient(TrendStatus status) {
    switch (status) {
      case TrendStatus.hot:
        return AppColors.goldGradient;
      case TrendStatus.up:
        return LinearGradient(
          colors: [AppColors.green, Colors.teal],
        );
      case TrendStatus.stable:
        return LinearGradient(
          colors: [AppColors.mosanaPurple, AppColors.mosanaBlue],
        );
    }
  }
  
  IconData _getTrendIcon(TrendStatus status) {
    switch (status) {
      case TrendStatus.hot:
        return Icons.local_fire_department;
      case TrendStatus.up:
        return Icons.trending_up;
      case TrendStatus.stable:
        return Icons.remove;
    }
  }
  
  Color _getTrendColor(TrendStatus status) {
    switch (status) {
      case TrendStatus.hot:
        return AppColors.gold;
      case TrendStatus.up:
        return AppColors.green;
      case TrendStatus.stable:
        return AppColors.textSecondary;
    }
  }
  
  String _getTrendLabel(TrendStatus status) {
    switch (status) {
      case TrendStatus.hot:
        return 'HOT 🔥';
      case TrendStatus.up:
        return 'TRENDING';
      case TrendStatus.stable:
        return 'STABLE';
    }
  }
  
  Gradient _getRankGradient(int rank) {
    switch (rank) {
      case 1:
        return AppColors.goldGradient;
      case 2:
        return LinearGradient(
          colors: [Colors.grey.shade400, Colors.grey.shade600],
        );
      case 3:
        return LinearGradient(
          colors: [Colors.brown.shade300, Colors.brown.shade500],
        );
      default:
        return LinearGradient(
          colors: [AppColors.mosanaPurple, AppColors.mosanaBlue],
        );
    }
  }
}

/// Trending topic model
class TrendingTopic {
  final String tag;
  final int posts;
  final TrendStatus trend;
  
  const TrendingTopic({
    required this.tag,
    required this.posts,
    required this.trend,
  });
}

enum TrendStatus { hot, up, stable }

/// Charity leaderboard model
class CharityLeader {
  final int rank;
  final String name;
  final String icon;
  final double totalRaised;
  final int donors;
  
  const CharityLeader({
    required this.rank,
    required this.name,
    required this.icon,
    required this.totalRaised,
    required this.donors,
  });
}
