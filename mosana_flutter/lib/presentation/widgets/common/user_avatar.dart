import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/config/colors.dart';

/// User avatar widget with optional verified badge and gradient border for NFT PFP
class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String username;
  final double size;
  final bool isVerified;
  final bool isNftPfp;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.imageUrl,
    required this.username,
    this.size = 48,
    this.isVerified = false,
    this.isNftPfp = false,
    this.onTap,
  });

  // Named constructors for common sizes
  const UserAvatar.small({
    super.key,
    this.imageUrl,
    required this.username,
    this.isVerified = false,
    this.isNftPfp = false,
    this.onTap,
  }) : size = 32;

  const UserAvatar.medium({
    super.key,
    this.imageUrl,
    required this.username,
    this.isVerified = false,
    this.isNftPfp = false,
    this.onTap,
  }) : size = 48;

  const UserAvatar.large({
    super.key,
    this.imageUrl,
    required this.username,
    this.isVerified = false,
    this.isNftPfp = false,
    this.onTap,
  }) : size = 64;

  const UserAvatar.xl({
    super.key,
    this.imageUrl,
    required this.username,
    this.isVerified = false,
    this.isNftPfp = false,
    this.onTap,
  }) : size = 96;

  String _getInitials() {
    if (username.isEmpty) return '?';
    final names = username.trim().split(' ');
    if (names.length == 1) {
      return names[0].substring(0, 1).toUpperCase();
    }
    return '${names[0].substring(0, 1)}${names[1].substring(0, 1)}'.toUpperCase();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _getInitials(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    Widget avatarWidget;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    } else {
      avatarWidget = _buildPlaceholder();
    }

    // Add gradient border for NFT PFP
    if (isNftPfp) {
      avatarWidget = Container(
        width: size + 4,
        height: size + 4,
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: AppColors.deepPurpleBlack,
              shape: BoxShape.circle,
            ),
            child: Center(child: avatarWidget),
          ),
        ),
      );
    }

    return avatarWidget;
  }

  Widget _buildVerifiedBadge() {
    final badgeSize = size * 0.3;
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: badgeSize,
        height: badgeSize,
        decoration: BoxDecoration(
          color: AppColors.mosanaBlue,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.deepPurpleBlack,
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: badgeSize * 0.7,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        _buildAvatar(),
        if (isVerified) _buildVerifiedBadge(),
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }
}
