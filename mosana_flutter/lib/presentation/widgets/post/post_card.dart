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
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.5,
                decoration: TextDecoration.none,
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.mosanaBlue,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
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
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Comment (Twitter-style)
          _TwitterActionButton(
            icon: Icons.chat_bubble_outline,
            count: post['commentsCount'] as int,
            onTap: onComment,
          ),

          // Tip (Mosana identity - replaces retweet)
          _TwitterActionButton(
            icon: Icons.volunteer_activism_outlined,
            count: post['tipsCount'] as int,
            activeColor: AppColors.gold,
            subtitle: '\$${(post['tipAmount'] as num).toStringAsFixed(2)}',
            onTap: onTip,
          ),

          // Like (Twitter-style with Mosana touch)
          _TwitterActionButton(
            icon: liked ? Icons.favorite : Icons.favorite_border,
            count: post['likesCount'] as int,
            isActive: liked,
            activeColor: Colors.red,
            onTap: onLike,
          ),

          // Mint (Mosana unique feature)
          if (!isMinted)
            _TwitterActionButton(
              icon: Icons.auto_awesome,
              label: 'Mint',
              activeColor: AppColors.mosanaBlue,
              showGradient: true,
              onTap: onMint,
            )
          else
            _TwitterActionButton(
              icon: Icons.auto_awesome,
              label: 'Minted',
              isActive: true,
              activeColor: AppColors.gold,
              onTap: null, // Disabled when already minted
            ),

          // Share (Twitter-style)
          _TwitterActionButton(
            icon: Icons.share_outlined,
            onTap: onShare,
          ),
        ],
      ),
    );
  }

}

/// Twitter-style action button with Mosana identity
class _TwitterActionButton extends StatefulWidget {
  final IconData icon;
  final int? count;
  final String? label;
  final String? subtitle;
  final bool isActive;
  final Color? activeColor;
  final bool showGradient;
  final VoidCallback? onTap;

  const _TwitterActionButton({
    required this.icon,
    this.count,
    this.label,
    this.subtitle,
    this.isActive = false,
    this.activeColor,
    this.showGradient = false,
    this.onTap,
  });

  @override
  State<_TwitterActionButton> createState() => _TwitterActionButtonState();
}

class _TwitterActionButtonState extends State<_TwitterActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive && widget.activeColor != null
        ? widget.activeColor!
        : AppColors.textSecondary;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _controller.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _controller.reverse();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _controller.reverse();
        },
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: _isPressed
                ? AppColors.cardSurface.withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with optional gradient
              widget.showGradient && !widget.isActive
                  ? ShaderMask(
                      shaderCallback: (bounds) => AppColors.primaryGradient
                          .createShader(bounds),
                      child: Icon(
                        widget.icon,
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      widget.icon,
                      size: 20,
                      color: color,
                    ),

              // Count or Label
              if (widget.count != null || widget.label != null) ...[
                const SizedBox(width: 6),
                Text(
                  widget.count != null
                      ? _formatCount(widget.count!)
                      : widget.label!,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              // Optional subtitle (e.g., tip amount)
              if (widget.subtitle != null) ...[
                const SizedBox(width: 4),
                Text(
                  widget.subtitle!,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
