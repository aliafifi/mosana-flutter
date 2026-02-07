import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/user_avatar.dart';
import '../../widgets/post/post_card.dart';
import '../../../data/models/post_model.dart';

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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  bool _isProcessing = false;
  int _selectedEdition = 1; // 1 = Single Edition, 10 = Limited (10), 0 = Unlimited
  
  final List<NFTEdition> _editions = [
    NFTEdition(
      value: 1,
      name: 'Single Edition',
      description: '1 of 1 - Unique NFT',
      icon: '💎',
      mintCost: 0.5,
    ),
    NFTEdition(
      value: 10,
      name: 'Limited Edition',
      description: 'Limited to 10 copies',
      icon: '🎨',
      mintCost: 0.3,
    ),
    NFTEdition(
      value: 0,
      name: 'Open Edition',
      description: 'Unlimited minting',
      icon: '♾️',
      mintCost: 0.1,
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    // Pre-fill with post content
    _titleController.text = '${widget.post.author.username}\'s Post';
    _descriptionController.text = widget.post.content.length > 100 
        ? widget.post.content.substring(0, 100) + '...'
        : widget.post.content;
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  Future<void> _mintNFT() async {
    if (_titleController.text.trim().isEmpty) {
      _showError('Please enter an NFT title');
      return;
    }
    
    setState(() {
      _isProcessing = true;
    });
    
    try {
      // TODO: Implement actual NFT minting
      // 1. Get connected wallet
      // 2. Upload metadata to IPFS/Arweave
      // 3. Create NFT on Solana (Metaplex)
      // 4. Sign transaction with wallet
      // 5. Confirm on blockchain
      // 6. Update backend with NFT details
      
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
        content: const Text('✨ NFT minted successfully! Your post is now immortal.'),
        backgroundColor: AppColors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedEdition = _editions.firstWhere((e) => e.value == _selectedEdition);
    final gasFee = 0.000005; // SOL
    final totalCost = selectedEdition.mintCost + gasFee;
    
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
                  
                  // NFT metadata
                  _buildNFTMetadata(),
                  
                  const SizedBox(height: 24),
                  
                  // Edition selection
                  _buildEditionSelection(),
                  
                  const SizedBox(height: 24),
                  
                  // Minting details
                  _buildMintingDetails(selectedEdition, gasFee, totalCost),
                  
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '✨',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                'IMMORTALIZE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Mint this post as an NFT',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Turn this moment into a permanent piece of digital art on the Solana blockchain.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
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
                    imageUrl: widget.post.authorAvatar,
                    username: widget.post.authorName,
                    isVerified: widget.post.authorIsVerified,
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.authorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.post.author.walletAddress.substring(0, 8) + '...',
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
              const SizedBox(height: 12),
              // Content
              Text(
                widget.post.content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.5,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              // Image if present
              if (widget.post.imageUrl != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.post.imageUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 150,
                      color: AppColors.cardSurface,
                      child: Icon(
                        Icons.image_not_supported,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              // Stats
              Row(
                children: [
                  _buildStatChip('❤️', widget.post.likesCount.toString()),
                  const SizedBox(width: 8),
                  _buildStatChip('💬', widget.post.commentsCount.toString()),
                  const SizedBox(width: 8),
                  _buildStatChip('💸', '\$${widget.post.tipsAmount.toStringAsFixed(0)}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatChip(String icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
              // Title
              TextField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'NFT Title',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                  hintText: 'Give your NFT a name',
                  hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                maxLength: 50,
              ),
              const Divider(height: 16, color: Colors.white24),
              // Description
              TextField(
                controller: _descriptionController,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                  hintText: 'Describe this moment...',
                  hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                maxLines: 3,
                maxLength: 200,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildEditionSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edition Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          _editions.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildEditionOption(_editions[index]),
          ),
        ),
      ],
    );
  }
  
  Widget _buildEditionOption(NFTEdition edition) {
    final isSelected = _selectedEdition == edition.value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEdition = edition.value;
        });
      },
      child: GlassCard(
        variant: isSelected ? GlassCardVariant.highlighted : GlassCardVariant.standard,
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.goldGradient : null,
                color: !isSelected ? AppColors.cardSurface : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  edition.icon,
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
                    edition.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    edition.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Cost
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${edition.mintCost} SOL',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Radio
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.gold : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMintingDetails(NFTEdition edition, double fee, double total) {
    return GlassCard(
      variant: GlassCardVariant.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Minting Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Edition', edition.name),
          const SizedBox(height: 8),
          _buildDetailRow('Mint Cost', '${edition.mintCost.toStringAsFixed(4)} SOL'),
          const SizedBox(height: 8),
          _buildDetailRow('Gas Fee', '${fee.toStringAsFixed(6)} SOL', isSecondary: true),
          const SizedBox(height: 8),
          _buildDetailRow('Storage', 'IPFS', isSecondary: true),
          const Divider(height: 24, color: Colors.white24),
          _buildDetailRow(
            'Total Cost',
            '${total.toStringAsFixed(4)} SOL',
            isLarge: true,
            valueColor: AppColors.gold,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value, {bool isSecondary = false, bool isLarge = false, Color? valueColor}) {
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
            color: valueColor ?? (isLarge ? AppColors.gold : Colors.white),
          ),
        ),
      ],
    );
  }
  
  Widget _buildBenefits() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.stars, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),
              const Text(
                'NFT Benefits',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBenefitItem('✨', 'Immortal Post', 'Permanent on blockchain'),
          const SizedBox(height: 12),
          _buildBenefitItem('🎨', 'Tradeable', 'Sell or trade on marketplaces'),
          const SizedBox(height: 12),
          _buildBenefitItem('💰', 'Royalties', 'Earn from secondary sales'),
          const SizedBox(height: 12),
          _buildBenefitItem('🏆', 'Exclusive', 'Limited edition collectible'),
        ],
      ),
    );
  }
  
  Widget _buildBenefitItem(String icon, String title, String description) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 16)),
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
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
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
      icon: Icons.auto_awesome,
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
              'Your NFT will be stored on IPFS and minted on Solana. You\'ll retain ownership and can trade it on any Solana marketplace.',
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

/// NFT Edition model
class NFTEdition {
  final int value; // 0 = unlimited, 1 = single, 10 = limited
  final String name;
  final String description;
  final String icon;
  final double mintCost; // SOL
  
  const NFTEdition({
    required this.value,
    required this.name,
    required this.description,
    required this.icon,
    required this.mintCost,
  });
}
