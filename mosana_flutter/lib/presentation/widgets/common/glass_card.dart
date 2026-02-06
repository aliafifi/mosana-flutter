import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';

/// Glassmorphism card widget with blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final GlassCardVariant variant;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.variant = GlassCardVariant.standard,
    this.onTap,
    this.width,
    this.height,
  });

  Color _getBackgroundColor() {
    switch (variant) {
      case GlassCardVariant.standard:
        return AppColors.cardSurface.withOpacity(0.7);
      case GlassCardVariant.highlighted:
        return AppColors.mosanaPurple.withOpacity(0.15);
      case GlassCardVariant.minted:
        return AppColors.gold.withOpacity(0.1);
    }
  }

  List<Color> _getBorderGradientColors() {
    switch (variant) {
      case GlassCardVariant.standard:
        return [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ];
      case GlassCardVariant.highlighted:
        return [
          AppColors.mosanaPurple.withOpacity(0.3),
          AppColors.mosanaBlue.withOpacity(0.3),
        ];
      case GlassCardVariant.minted:
        return [
          AppColors.gold.withOpacity(0.6),
          const Color(0xFFD97706).withOpacity(0.6),
        ];
    }
  }

  List<BoxShadow>? _getShadow() {
    if (variant == GlassCardVariant.minted) {
      return [
        BoxShadow(
          color: AppColors.gold.withOpacity(0.2),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];
    }
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: 1,
              color: Colors.transparent,
            ),
            boxShadow: _getShadow(),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius - 1),
              border: Border.all(
                width: 1,
                color: Colors.transparent,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getBorderGradientColors(),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius - 2),
              child: Container(
                padding: const EdgeInsets.all(1),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}

enum GlassCardVariant {
  /// Standard card with subtle border
  standard,

  /// Highlighted card with purple/blue gradient border
  highlighted,

  /// Minted NFT card with gold gradient border and glow
  minted,
}
