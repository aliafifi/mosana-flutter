import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../data/mock_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(20),
                children: [
                  _buildTrendingSection(),
                  const SizedBox(height: 16),
                  _buildDailyRewards(),
                  const SizedBox(height: 24),
                  ...MockData.posts.map((post) => _buildPostCard(post)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.mosanaPurple.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => print('Create post tapped'),
            borderRadius: BorderRadius.circular(28),
            child: const Center(
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: _isHeaderScrolled ? Colors.black.withOpacity(0.85) : Colors.transparent,
        border: _isHeaderScrolled ? const Border(bottom: BorderSide(color: Color(0x14FFFFFF))) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/mosana-logo.png', width: 32, height: 32),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: const Text('mosana', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.search, color: Colors.white, size: 20), onPressed: () => print('Search')),
              Stack(
                children: [
                  IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20), onPressed: () => print('Notifications')),
                  Positioned(
                    right: 8, top: 8,
                    child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2))),
                  ),
                ],
              ),
              IconButton(icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 20), onPressed: () => print('Wallet')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.trending_up, color: AppColors.mosanaPurple, size: 20),
            const SizedBox(width: 8),
            const Text('Trending Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: MockData.trendingTopics.length,
            itemBuilder: (context, index) {
              final topic = MockData.trendingTopics[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(topic['tag']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('${topic['count']} posts', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDailyRewards() {
    final rewards = MockData.dailyRewards;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.card_giftcard, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text('Daily Rewards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(rewards['amount'].toString(), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(width: 8),
              Text(rewards['currency'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text('${rewards['multiplier']}× Multiplier Active', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => print('Claim rewards'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.mosanaPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.card_giftcard, size: 20),
                  SizedBox(width: 8),
                  Text('Claim Rewards', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    final isMinted = post['isMinted'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMinted ? AppColors.gold : const Color(0x14FFFFFF),
          width: isMinted ? 2 : 1,
        ),
        boxShadow: isMinted ? [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Minted Badge (if minted)
          if (isMinted) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'IMMORTAL POST',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  gradient: isMinted ? AppColors.goldGradient : AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(post['initials'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(post['author'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                        if (post['verified']) ...[const SizedBox(width: 4), const Icon(Icons.verified, size: 16, color: Color(0xFFF59E0B))],
                      ],
                    ),
                    Row(
                      children: [
                        Text('${post['time']} ago', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                        const Text(' • ', style: TextStyle(color: Colors.grey)),
                        _buildReputationBadge(post['badge']),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.more_vert, color: Colors.white, size: 20), onPressed: () => print('Menu')),
            ],
          ),
          const SizedBox(height: 12),
          Text(post['content'], style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.white)),
          if (post['hasImage']) ...[
            const SizedBox(height: 12),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isMinted 
                    ? [AppColors.gold.withOpacity(0.3), const Color(0xFFD97706).withOpacity(0.3)]
                    : [AppColors.mosanaPurple.withOpacity(0.3), AppColors.mosanaBlue.withOpacity(0.3)],
                ),
              ),
              child: const Center(child: Icon(Icons.image_outlined, color: Colors.white, size: 48)),
            ),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0x14FFFFFF)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(Icons.favorite_border, post['likes'].toString(), () => print('Like')),
                _buildActionButton(Icons.auto_awesome, isMinted ? 'Minted' : 'Mint', () => print('Mint'), isMint: !isMinted, isMinted: isMinted),
                _buildActionButton(Icons.toll, 'Tip', () => print('Tip')),
                _buildActionButton(Icons.chat_bubble_outline, post['comments'].toString(), () => print('Comment')),
                _buildActionButton(Icons.share_outlined, '', () => print('Share')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReputationBadge(String badge) {
    Color badgeColor;
    switch (badge.toLowerCase()) {
      case 'legend': badgeColor = AppColors.gold; break;
      case 'elite': badgeColor = const Color(0xFF8B5CF6); break;
      case 'champion': badgeColor = AppColors.green; break;
      default: badgeColor = AppColors.mosanaBlue;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: badgeColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Text(badge, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: badgeColor)),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap, {bool isMint = false, bool isMinted = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: isMint ? BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ) : (isMinted ? BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.gold.withOpacity(0.3)),
        ) : null),
        child: Row(
          children: [
            Icon(icon, size: 16, color: (isMint || isMinted) ? Colors.white : AppColors.textSecondary),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(label, style: TextStyle(fontSize: 13, color: (isMint || isMinted) ? Colors.white : AppColors.textSecondary)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
      ),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
            print('Tab $index');
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.mosanaPurple,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 24),
              activeIcon: Icon(Icons.home, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 24),
              activeIcon: Icon(Icons.explore, size: 24),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined, size: 24),
              activeIcon: Icon(Icons.group, size: 24),
              label: 'DAO',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined, size: 24),
              activeIcon: Icon(Icons.account_balance_wallet, size: 24),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 24),
              activeIcon: Icon(Icons.person, size: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
