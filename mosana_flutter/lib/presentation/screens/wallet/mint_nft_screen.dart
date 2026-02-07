import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/user_avatar.dart';
import '../../../data/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Screen for minting a post as an NFT
class MintNFTScreen extends StatefulWidget {
  final PostModel post;
  
  const MintNFTScreen({
    super.key,
    required this.post,
  });

  @override
  State<MintNFTScreen> createState() => _MintNFTScreenState();
}

class _MintNFTScreenState extends State<MintNFTScreen> {
  bool _isProcessing = false;
  String _selectedNetwork = 'mainnet'; // mainnet or devnet
  
  // NFT minting costs (in SOL)
  static const double _mintCost = 0.01;
  static const double _networkFee = 0.000005;
  static const double _storageFee = 0.002;
  
  double get _totalCost => _mintCost + _networkFee + _storageFee;
  
  Future<void> _mintNFT() async {
    setState(() {
      _isProcessing = true;
    });
    
    try {
      // TODO: Implement actual NFT minting
      // 1. Get connected wallet
      // 2. Upload metadata to IPFS/Arweave
      // 3. Create NFT mint transaction
      // 4. Sign with wallet
      // 5. Send to blockchain
      // 6. Update backend with NFT data
      
      await Future.delayed(const Duration(seconds: 3)); // Simulate minting
      
      if (!mounted) return;
      
      // Show success
      _showSuccess();
      
      // Navigate back
      Navigator.of(context).pop(true);
      
    } catch (e) {
      if (!mounted) return;
      _showError('Minting failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
  
  void _showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✨ NFT minted successfully! Post is now immortal.'),
        backgroundColor: AppColors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Mint as NFT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.gold.withOpacity(0.15),
                    AppColors.pureBlack,
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  
                  const SizedBox(height: 24),
                  
                  // Post preview
                  _buildPostPreview(),
                  
                  const SizedBox(height: 24),
                  
                  // NFT Metadata
                  _buildNFTMetadata(),
                  
                  const SizedBox(height: 24),
                  
                  // Network selection
                  _buildNetworkSelection(),
                  
                  const SizedBox(height: 24),
                  
                  // Cost breakdown
                  _buildCostBreakdown(),
                  
                  const SizedBox(height: 24),
                  
                  // Benefits
                  _buildBenefits(),
                  
                  const SizedBox(height: 32),
                  
                  // Mint button
                  _buildMintButton(),
                  
                  const SizedBox(height: 16),
                  
                  // Info note
                  _buildInfoNote(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.diamond,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Make it Immortal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mint this post as an NFT on Solana',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildPostPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Post Preview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          variant: GlassCardVariant.highlighted,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author
              Row(
                children: [
                  UserAvatar(
                    imageUrl: widget.post.author.avatarUrl,
                    isVerified: widget.post.author.isVerified,
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.post.author.username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            if (widget.post.author.isVerified) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: AppColors.mosanaBlue,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          '@${widget.post.author.username}',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Content
              Text(
                widget.post.content,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.5,
                ),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              
              // Image if exists
              if (widget.post.imageUrl != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.post.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: AppColors.cardSurface,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: AppColors.cardSurface,
                      child: const Icon(Icons.image, color: Colors.white54),
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 16),
              
              // Stats
              Row(
                children: [
                  _buildStatBadge(Icons.favorite, widget.post.likesCount.toString()),
                  const SizedBox(width: 12),
                  _buildStatBadge(Icons.comment, widget.post.commentsCount.toString()),
                  const SizedBox(width: 12),
                  _buildStatBadge(Icons.volunteer_activism, '\$${widget.post.tipsAmount.toStringAsFixed(2)}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatBadge(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNFTMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NFT Metadata',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          child: Column(
            children: [
              _buildMetadataRow('Name', 'Mosana Post #${widget.post.id}'),
              const Divider(height: 24, color: Colors.white24),
              _buildMetadataRow('Creator', '@${widget.post.author.username}'),
              const Divider(height: 24, color: Colors.white24),
              _buildMetadataRow('Blockchain', 'Solana'),
              const Divider(height: 24, color: Colors.white24),
              _buildMetadataRow('Standard', 'Metaplex NFT'),
              const Divider(height: 24, color: Colors.white24),
              _buildMetadataRow('Storage', 'IPFS (Permanent)'),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildMetadataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
  
  Widget _buildNetworkSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Network',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNetworkOption(
                'Mainnet',
                'mainnet',
                'Production network',
                recommended: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildNetworkOption(
                'Devnet',
                'devnet',
                'Testing network',
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildNetworkOption(String label, String value, String description, {bool recommended = false}) {
    final isSelected = _selectedNetwork == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNetwork = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? AppColors.primaryGradient
              : null,
          color: isSelected ? null : AppColors.cardSurface.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.mosanaPurple
                : AppColors.cardSurface,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
                if (recommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '⭐',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: isSelected 
                    ? Colors.white.withOpacity(0.8)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCostBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cost Breakdown',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          variant: GlassCardVariant.highlighted,
          child: Column(
            children: [
              _buildCostRow('Minting Fee', '${_mintCost.toStringAsFixed(4)} SOL'),
              const SizedBox(height: 8),
              _buildCostRow('Network Fee', '${_networkFee.toStringAsFixed(6)} SOL', isSecondary: true),
              const SizedBox(height: 8),
              _buildCostRow('Storage (IPFS)', '${_storageFee.toStringAsFixed(6)} SOL', isSecondary: true),
              const Divider(height: 24, color: Colors.white24),
              _buildCostRow(
                'Total Cost',
                '${_totalCost.toStringAsFixed(4)} SOL',
                isLarge: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildCostRow(String label, String value, {bool isSecondary = false, bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 16 : 14,
            fontWeight: isLarge ? FontWeight.w600 : FontWeight.w400,
            color: isSecondary ? AppColors.textSecondary : Colors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 18 : 14,
            fontWeight: isLarge ? FontWeight.w700 : FontWeight.w500,
            color: isLarge ? AppColors.gold : Colors.white,
          ),
        ),
      ],
    );
  }
  
  Widget _buildBenefits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NFT Benefits',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.lock,
          'Permanent',
          'Your post is stored forever on the blockchain',
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.security,
          'Ownership Proof',
          'Cryptographic proof of creation and ownership',
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.trending_up,
          'Tradeable',
          'Can be bought, sold, or transferred as an asset',
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.star,
          'Exclusive Badge',
          'Get a special "IMMORTAL POST" badge on your post',
        ),
      ],
    );
  }
  
  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildMintButton() {
    return GradientButton(
      text: _isProcessing ? 'Minting...' : 'Mint NFT',
      onPressed: _isProcessing ? null : _mintNFT,
      isLoading: _isProcessing,
      icon: Icons.diamond,
      style: GradientButtonStyle.gold,
    );
  }
  
  Widget _buildInfoNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.gold,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Once minted, this post becomes a permanent NFT on the Solana blockchain. This action cannot be undone.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
