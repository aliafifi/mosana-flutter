import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';

/// ✨ Advanced Interactions Screen
/// 
/// Displays all user interactions organized by type:
/// - Replies: All replies to posts
/// - Reposts: Posts you've reposted
/// - Bookmarks: Saved posts for later
/// - Mentions: Posts where you were mentioned
/// 
/// Features:
/// - Tab navigation for different interaction types
/// - Post cards with glassmorphism
/// - Quick actions (like, comment, tip, mint, share)
/// - User avatars and verified badges
/// - Empty states with helpful messages
/// - Pull to refresh
class AdvancedInteractionsScreen extends StatefulWidget {
  const AdvancedInteractionsScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedInteractionsScreen> createState() =>
      _AdvancedInteractionsScreenState();
}

class _AdvancedInteractionsScreenState
    extends State<AdvancedInteractionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data - will be replaced with real data
  final List<Map<String, dynamic>> _replies = [
    {
      'id': '1',
      'user': {
        'username': '@you',
        'avatar': 'https://i.pravatar.cc/150?img=1',
        'verified': true,
      },
      'content': 'Great post! I totally agree with your perspective on this.',
      'timestamp': '2h ago',
      'originalPost': {
        'user': '@crypto_guru',
        'content': 'The future of Web3 is looking bright...',
      },
      'likes': 12,
      'replies': 3,
    },
    {
      'id': '2',
      'user': {
        'username': '@you',
        'avatar': 'https://i.pravatar.cc/150?img=1',
        'verified': true,
      },
      'content': 'Thanks for sharing this! Very insightful.',
      'timestamp': '5h ago',
      'originalPost': {
        'user': '@defi_queen',
        'content': 'New DeFi protocols are changing the game...',
      },
      'likes': 8,
      'replies': 1,
    },
  ];

  final List<Map<String, dynamic>> _reposts = [
    {
      'id': '3',
      'repostedBy': '@you',
      'timestamp': '1h ago',
      'originalPost': {
        'user': {
          'username': '@nft_artist',
          'avatar': 'https://i.pravatar.cc/150?img=3',
          'verified': true,
        },
        'content': 'Just dropped my new NFT collection! 🎨 Check it out!',
        'image': 'https://picsum.photos/400/300?random=3',
        'likes': 234,
        'comments': 45,
        'tips': 12,
      },
    },
  ];

  final List<Map<String, dynamic>> _bookmarks = [
    {
      'id': '4',
      'user': {
        'username': '@web3_dev',
        'avatar': 'https://i.pravatar.cc/150?img=4',
        'verified': true,
      },
      'content': 'Building the future of decentralized applications 🚀',
      'image': 'https://picsum.photos/400/300?random=4',
      'timestamp': '1d ago',
      'likes': 567,
      'comments': 89,
      'tips': 23,
      'bookmarkedAt': '3h ago',
    },
    {
      'id': '5',
      'user': {
        'username': '@solana_fan',
        'avatar': 'https://i.pravatar.cc/150?img=5',
        'verified': false,
      },
      'content': 'Solana is the fastest blockchain out there! ⚡',
      'timestamp': '2d ago',
      'likes': 423,
      'comments': 67,
      'tips': 18,
      'bookmarkedAt': '1d ago',
    },
  ];

  final List<Map<String, dynamic>> _mentions = [
    {
      'id': '6',
      'user': {
        'username': '@crypto_friend',
        'avatar': 'https://i.pravatar.cc/150?img=6',
        'verified': false,
      },
      'content': 'Hey @you, what do you think about this new project?',
      'timestamp': '4h ago',
      'likes': 15,
      'comments': 5,
      'tips': 2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Interactions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.mosanaPurple,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'Replies'),
            Tab(text: 'Reposts'),
            Tab(text: 'Bookmarks'),
            Tab(text: 'Mentions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRepliesTab(),
          _buildRepostsTab(),
          _buildBookmarksTab(),
          _buildMentionsTab(),
        ],
      ),
    );
  }

  Widget _buildRepliesTab() {
    if (_replies.isEmpty) {
      return _buildEmptyState(
        icon: Icons.chat_bubble_outline,
        title: 'No Replies Yet',
        message: 'Start conversations by replying to posts!',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshReplies,
      color: AppColors.mosanaPurple,
      backgroundColor: AppColors.surfaceDark,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _replies.length,
        itemBuilder: (context, index) {
          final reply = _replies[index];
          return _buildReplyCard(reply);
        },
      ),
    );
  }

  Widget _buildRepostsTab() {
    if (_reposts.isEmpty) {
      return _buildEmptyState(
        icon: Icons.repeat,
        title: 'No Reposts Yet',
        message: 'Share interesting posts with your followers!',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshReposts,
      color: AppColors.mosanaPurple,
      backgroundColor: AppColors.surfaceDark,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _reposts.length,
        itemBuilder: (context, index) {
          final repost = _reposts[index];
          return _buildRepostCard(repost);
        },
      ),
    );
  }

  Widget _buildBookmarksTab() {
    if (_bookmarks.isEmpty) {
      return _buildEmptyState(
        icon: Icons.bookmark_outline,
        title: 'No Bookmarks Yet',
        message: 'Save posts to read them later!',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshBookmarks,
      color: AppColors.mosanaPurple,
      backgroundColor: AppColors.surfaceDark,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = _bookmarks[index];
          return _buildBookmarkCard(bookmark);
        },
      ),
    );
  }

  Widget _buildMentionsTab() {
    if (_mentions.isEmpty) {
      return _buildEmptyState(
        icon: Icons.alternate_email,
        title: 'No Mentions Yet',
        message: 'When someone mentions you, it will appear here!',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshMentions,
      color: AppColors.mosanaPurple,
      backgroundColor: AppColors.surfaceDark,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mentions.length,
        itemBuilder: (context, index) {
          final mention = _mentions[index];
          return _buildPostCard(mention);
        },
      ),
    );
  }

  Widget _buildReplyCard(Map<String, dynamic> reply) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Original post reference
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.borderDark,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.reply,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Replying to ${reply['originalPost']['user']}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // User info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(reply['user']['avatar']),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              reply['user']['username'],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (reply['user']['verified'])
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: AppColors.mosanaPurple,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          reply['timestamp'],
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Reply content
              Text(
                reply['content'],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              // Stats
              Row(
                children: [
                  _buildStatItem(Icons.favorite_border, '${reply['likes']}'),
                  const SizedBox(width: 16),
                  _buildStatItem(Icons.chat_bubble_outline, '${reply['replies']}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRepostCard(Map<String, dynamic> repost) {
    final post = repost['originalPost'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Repost indicator
              Row(
                children: [
                  Icon(
                    Icons.repeat,
                    size: 16,
                    color: AppColors.mosanaPurple,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'You reposted · ${repost['timestamp']}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Original post
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(post['user']['avatar']),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post['user']['username'],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (post['user']['verified'])
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: AppColors.mosanaPurple,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post['content'],
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        if (post['image'] != null) ...[
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              post['image'],
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildStatItem(Icons.favorite_border, '${post['likes']}'),
                            const SizedBox(width: 16),
                            _buildStatItem(Icons.chat_bubble_outline, '${post['comments']}'),
                            const SizedBox(width: 16),
                            _buildStatItem(Icons.attach_money, '${post['tips']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkCard(Map<String, dynamic> bookmark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bookmarked indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        size: 16,
                        color: AppColors.mosanaPurple,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Saved ${bookmark['bookmarkedAt']}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_remove, size: 20),
                    color: AppColors.textSecondary,
                    onPressed: () => _removeBookmark(bookmark['id']),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Post content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(bookmark['user']['avatar']),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              bookmark['user']['username'],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (bookmark['user']['verified'])
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: AppColors.mosanaPurple,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Text(
                              '· ${bookmark['timestamp']}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bookmark['content'],
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        if (bookmark['image'] != null) ...[
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              bookmark['image'],
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildStatItem(Icons.favorite_border, '${bookmark['likes']}'),
                            const SizedBox(width: 16),
                            _buildStatItem(Icons.chat_bubble_outline, '${bookmark['comments']}'),
                            const SizedBox(width: 16),
                            _buildStatItem(Icons.attach_money, '${bookmark['tips']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(post['user']['avatar']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post['user']['username'],
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (post['user']['verified'])
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.verified,
                              size: 16,
                              color: AppColors.mosanaPurple,
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          '· ${post['timestamp']}',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post['content'],
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildStatItem(Icons.favorite_border, '${post['likes']}'),
                        const SizedBox(width: 16),
                        _buildStatItem(Icons.chat_bubble_outline, '${post['comments']}'),
                        const SizedBox(width: 16),
                        _buildStatItem(Icons.attach_money, '${post['tips']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mosanaPurple.withOpacity(0.3),
                    AppColors.mosanaPurple.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: AppColors.mosanaPurple,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshReplies() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _refreshReposts() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _refreshBookmarks() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _refreshMentions() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
  }

  void _removeBookmark(String id) {
    setState(() {
      _bookmarks.removeWhere((bookmark) => bookmark['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bookmark removed'),
        backgroundColor: AppColors.mosanaPurple,
      ),
    );
  }
}
