import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';

/// ✨ Analytics Dashboard Screen
/// 
/// Displays comprehensive analytics including:
/// - Impact statistics (tips sent, recipients helped, charity donations)
/// - Engagement metrics (likes, comments, shares, mints)
/// - Activity graphs and charts
/// - NFT collection stats
/// - Achievement badges
/// 
/// Features:
/// - Animated stat cards with glassmorphism
/// - Interactive charts (placeholder for now)
/// - Time period filters (Week, Month, Year, All)
/// - Share analytics option
/// - Beautiful gradient accents
class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsDashboardScreen> createState() => _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  String _selectedPeriod = 'Month';
  final List<String> _periods = ['Week', 'Month', 'Year', 'All'];

  // Mock data - will be replaced with real data from analytics repository
  final Map<String, dynamic> _analyticsData = {
    'totalTipsSent': 156.8,
    'totalRecipients': 42,
    'charityDonations': 23.4,
    'totalLikes': 1247,
    'totalComments': 384,
    'totalShares': 156,
    'nftsMinted': 12,
    'nftsOwned': 28,
    'impactScore': 4.7,
    'engagementRate': 8.4,
  };

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
          'Analytics',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: _shareAnalytics,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Period filter
              _buildPeriodFilter(),
              const SizedBox(height: 24),

              // Impact Stats Section
              _buildSectionTitle('💝 Impact Statistics'),
              const SizedBox(height: 12),
              _buildImpactStats(),
              const SizedBox(height: 24),

              // Engagement Metrics Section
              _buildSectionTitle('📊 Engagement Metrics'),
              const SizedBox(height: 12),
              _buildEngagementMetrics(),
              const SizedBox(height: 24),

              // NFT Collection Section
              _buildSectionTitle('🎨 NFT Collection'),
              const SizedBox(height: 12),
              _buildNFTStats(),
              const SizedBox(height: 24),

              // Achievements Section
              _buildSectionTitle('🏆 Achievements'),
              const SizedBox(height: 12),
              _buildAchievements(),
              const SizedBox(height: 24),

              // Activity Chart Placeholder
              _buildSectionTitle('📈 Activity Trend'),
              const SizedBox(height: 12),
              _buildActivityChart(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _periods.map((period) {
          final isSelected = period == _selectedPeriod;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            AppColors.mosanaPurple,
                            AppColors.mosanaPurple.withOpacity(0.8),
                          ],
                        )
                      : null,
                  color: isSelected ? null : AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.mosanaPurple
                        : AppColors.borderDark,
                    width: 1,
                  ),
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildImpactStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.attach_money,
                label: 'Tips Sent',
                value: '${_analyticsData['totalTipsSent']} SOL',
                color: AppColors.mosanaPurple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.people_outline,
                label: 'Recipients',
                value: '${_analyticsData['totalRecipients']}',
                color: AppColors.nftBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.favorite_outline,
                label: 'Charity Donated',
                value: '${_analyticsData['charityDonations']} SOL',
                color: AppColors.nftPink,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.star_outline,
                label: 'Impact Score',
                value: '${_analyticsData['impactScore']}/5.0',
                color: AppColors.nftOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEngagementMetrics() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.favorite_border,
                label: 'Total Likes',
                value: '${_analyticsData['totalLikes']}',
                color: AppColors.nftPink,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.chat_bubble_outline,
                label: 'Comments',
                value: '${_analyticsData['totalComments']}',
                color: AppColors.nftBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.share_outlined,
                label: 'Shares',
                value: '${_analyticsData['totalShares']}',
                color: AppColors.mosanaPurple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up,
                label: 'Engagement',
                value: '${_analyticsData['engagementRate']}%',
                color: AppColors.nftOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNFTStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.auto_awesome,
            label: 'NFTs Minted',
            value: '${_analyticsData['nftsMinted']}',
            color: AppColors.nftPink,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.collections_outlined,
            label: 'NFTs Owned',
            value: '${_analyticsData['nftsOwned']}',
            color: AppColors.nftBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {
        'icon': '🌟',
        'title': 'First Tip',
        'description': 'Sent your first tip',
        'unlocked': true,
      },
      {
        'icon': '💎',
        'title': 'NFT Creator',
        'description': 'Minted 10 NFTs',
        'unlocked': true,
      },
      {
        'icon': '❤️',
        'title': 'Generous Heart',
        'description': 'Donated to 5 charities',
        'unlocked': true,
      },
      {
        'icon': '🚀',
        'title': 'Rising Star',
        'description': 'Reached 1000 likes',
        'unlocked': true,
      },
      {
        'icon': '👥',
        'title': 'Community Builder',
        'description': 'Helped 50 recipients',
        'unlocked': false,
      },
      {
        'icon': '💰',
        'title': 'Whale',
        'description': 'Sent 1000 SOL in tips',
        'unlocked': false,
      },
    ];

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: achievements.map((achievement) {
            final isUnlocked = achievement['unlocked'] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: isUnlocked
                          ? LinearGradient(
                              colors: [
                                AppColors.mosanaPurple,
                                AppColors.nftPink,
                              ],
                            )
                          : null,
                      color: isUnlocked ? null : AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        achievement['icon'] as String,
                        style: TextStyle(
                          fontSize: 24,
                          color: isUnlocked ? Colors.white : Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement['title'] as String,
                          style: TextStyle(
                            color: isUnlocked
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          achievement['description'] as String,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isUnlocked)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.mosanaPurple,
                      size: 20,
                    )
                  else
                    const Icon(
                      Icons.lock_outline,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    // Placeholder for activity chart
    // In production, use fl_chart or similar package
    return GlassCard(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              size: 48,
              color: AppColors.mosanaPurple.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'Activity chart will be displayed here',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Showing $_selectedPeriod data',
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareAnalytics() {
    // TODO: Implement share analytics
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share analytics coming soon!'),
        backgroundColor: AppColors.mosanaPurple,
      ),
    );
  }
}
