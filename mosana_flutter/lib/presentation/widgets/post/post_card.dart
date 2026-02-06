import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/config/colors.dart';
import '../common/glass_card.dart';
import '../common/user_avatar.dart';

/// Post card widget for displaying posts in feed
class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onTip;
  final VoidCallback? onShare;
  final VoidCallback? onMint;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onTip,
    this.onShare,
    this.onMint,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final author = post['author'] as Map<String, dynamic>;
    final isMinted = post['isMinted'] as bool? ?? false;
    final liked = post['liked'] as bool? ?? false;

    return GlassCard(
      variant: isMinted ? GlassCardVariant.minted : GlassCardVariant.standard,
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(author, post['createdAt'], isMinted),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post['content'] as String,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),

          // Image
          if (post['imageUrl'] != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post['imageUrl'] as String,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: AppColors.cardSurface,
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],

          // Tags
          if (post['tags'] != null && (post['tags'] as List).isNotEmpty) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: (post['tags'] as List).map((tag) {
                  return Text(
                    '#$tag',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mosanaBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Stats & Actions
          _buildActions(post, liked, isMinted),
        ],
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> author, DateTime createdAt, bool isMinted) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          UserAvatar.medium(
            imageUrl: author['profileImage'] as String?,
            username: author['username'] as String,
            isVerified: author['verified'] as bool? ?? false,
            isNftPfp: author['nftProfilePicture'] != null,
          ),

          const SizedBox(width: 12),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '@${author['username']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (author['verified'] as bool? ?? false) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: AppColors.mosanaBlue,
                      ),
                    ],
                    if (isMinted) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.goldGradient,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '🔥 IMMORTAL',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  timeago.format(createdAt),
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // More menu
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              // TODO: Show menu
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActions(Map<String, dynamic> post, bool liked, bool isMinted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Stats row
          Row(
            children: [
              _buildStat(Icons.favorite, post['likesCount'] as int),
              const SizedBox(width: 16),
              _buildStat(Icons.chat_bubble_outline, post['commentsCount'] as int),
              const SizedBox(width: 16),
              _buildStat(
                Icons.account_balance_wallet,
                post['tipsCount'] as int,
                subtitle: '\$${(post['tipAmount'] as num).toStringAsFixed(2)}',
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: liked ? Icons.favorite : Icons.favorite_border,
                  label: 'Like',
                  color: liked ? Colors.red : AppColors.textSecondary,
                  onTap: onLike,
                ),
              ),
              Expanded(
                child: _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comment',
                  onTap: onComment,
                ),
              ),
              Expanded(
                child: _ActionButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Tip',
                  color: AppColors.gold,
                  onTap: onTip,
                ),
              ),
              if (!isMinted)
                Expanded(
                  child: _ActionButton(
                    icon: Icons.auto_awesome,
                    label: 'Mint',
                    onTap: onMint,
                  ),
                ),
              Expanded(
                child: _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: onShare,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, int count, {String? subtitle}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(width: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: color ?? AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color ?? AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
