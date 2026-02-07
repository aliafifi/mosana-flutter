import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/user_avatar.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/post_model.dart';

/// Screen for sending tips to users via Solana
class SendTipScreen extends StatefulWidget {
  final UserModel recipient;
  final PostModel? post; // Optional: tip for a specific post
  
  const SendTipScreen({
    super.key,
    required this.recipient,
    this.post,
  });

  @override
  State<SendTipScreen> createState() => _SendTipScreenState();
}

class _SendTipScreenState extends State<SendTipScreen> {
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();
  
  String? _selectedCharity;
  bool _isProcessing = false;
  double _amount = 0.0;
  
  // Mock charities (TODO: Fetch from API)
  final List<Charity> _charities = [
    Charity(
      id: '1',
      name: 'Red Cross',
      description: 'Humanitarian aid worldwide',
      icon: '🏥',
      impactScore: 4.8,
    ),
    Charity(
      id: '2',
      name: 'World Wildlife Fund',
      description: 'Conservation of endangered species',
      icon: '🐼',
      impactScore: 4.7,
    ),
    Charity(
      id: '3',
      name: 'Water.org',
      description: 'Clean water access for all',
      icon: '💧',
      impactScore: 4.9,
    ),
    Charity(
      id: '4',
      name: 'Doctors Without Borders',
      description: 'Medical aid in crisis zones',
      icon: '⚕️',
      impactScore: 4.8,
    ),
    Charity(
      id: '5',
      name: 'UNICEF',
      description: "Children's emergency fund",
      icon: '👶',
      impactScore: 4.6,
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    _selectedCharity = _charities.first.id;
  }
  
  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }
  
  void _updateAmount(String value) {
    setState(() {
      _amount = double.tryParse(value) ?? 0.0;
    });
  }
  
  Future<void> _sendTip() async {
    if (_amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }
    
    if (_selectedCharity == null) {
      _showError('Please select a charity');
      return;
    }
    
    setState(() {
      _isProcessing = true;
    });
    
    try {
      // TODO: Implement actual Solana transaction
      // 1. Get connected wallet
      // 2. Build transaction
      // 3. Sign with wallet
      // 4. Send to blockchain
      // 5. Confirm transaction
      // 6. Update backend
      
      await Future.delayed(const Duration(seconds: 2)); // Simulate transaction
      
      if (!mounted) return;
      
      // Show success
      _showSuccess();
      
      // Navigate back
      Navigator.of(context).pop(true);
      
    } catch (e) {
      if (!mounted) return;
      _showError('Transaction failed: $e');
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
        content: Text('✅ Tip sent successfully! ${_amount.toStringAsFixed(2)} SOL'),
        backgroundColor: AppColors.green,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedCharityData = _charities.firstWhere((c) => c.id == _selectedCharity);
    final estimatedFee = 0.000005; // SOL
    final totalAmount = _amount + estimatedFee;
    
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
          'Send Tip',
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
                    AppColors.mosanaPurple.withOpacity(0.15),
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
                  // Recipient card
                  _buildRecipientCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Amount input
                  _buildAmountInput(),
                  
                  const SizedBox(height: 24),
                  
                  // Charity selection
                  _buildCharitySelection(),
                  
                  const SizedBox(height: 24),
                  
                  // Message (optional)
                  _buildMessageInput(),
                  
                  const SizedBox(height: 24),
                  
                  // Transaction summary
                  _buildTransactionSummary(selectedCharityData, estimatedFee, totalAmount),
                  
                  const SizedBox(height: 32),
                  
                  // Send button
                  _buildSendButton(),
                  
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
  
  Widget _buildRecipientCard() {
    return GlassCard(
      child: Row(
        children: [
          UserAvatar(
            imageUrl: widget.recipient.avatarUrl,
            isVerified: widget.recipient.isVerified,
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
                      widget.recipient.username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (widget.recipient.isVerified) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        size: 18,
                        color: AppColors.mosanaBlue,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.recipient.walletAddress.substring(0, 8) + '...' + 
                  widget.recipient.walletAddress.substring(widget.recipient.walletAddress.length - 6),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.account_balance_wallet,
            color: AppColors.mosanaPurple,
            size: 28,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tip Amount',
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
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,9}')),
                ],
                onChanged: _updateAmount,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary.withOpacity(0.3),
                  ),
                  suffix: Text(
                    'SOL',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Quick amount buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickAmountButton('0.1'),
                  _buildQuickAmountButton('0.5'),
                  _buildQuickAmountButton('1.0'),
                  _buildQuickAmountButton('5.0'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuickAmountButton(String amount) {
    return GestureDetector(
      onTap: () {
        _amountController.text = amount;
        _updateAmount(amount);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.mosanaPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.mosanaPurple.withOpacity(0.3),
          ),
        ),
        child: Text(
          '$amount SOL',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.mosanaPurple,
          ),
        ),
      ),
    );
  }
  
  Widget _buildCharitySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Support Charity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '100% of your tip goes to support a great cause',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          _charities.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCharityOption(_charities[index]),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCharityOption(Charity charity) {
    final isSelected = _selectedCharity == charity.id;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCharity = charity.id;
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
                color: isSelected 
                    ? AppColors.mosanaPurple.withOpacity(0.2)
                    : AppColors.cardSurface,
                borderRadius: BorderRadius.circular(12),
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
                    charity.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Impact score
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: AppColors.gold,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    charity.impactScore.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Radio
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.mosanaPurple : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMessageInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Message (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          child: TextField(
            controller: _messageController,
            maxLines: 3,
            maxLength: 200,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Say something nice...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildTransactionSummary(Charity charity, double fee, double total) {
    return GlassCard(
      variant: GlassCardVariant.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Tip Amount', '${_amount.toStringAsFixed(4)} SOL'),
          const SizedBox(height: 8),
          _buildSummaryRow('Network Fee', '${fee.toStringAsFixed(6)} SOL', isSecondary: true),
          const SizedBox(height: 8),
          _buildSummaryRow('Charity', charity.name, isSecondary: true),
          const Divider(height: 24, color: Colors.white24),
          _buildSummaryRow(
            'Total',
            '${total.toStringAsFixed(4)} SOL',
            isLarge: true,
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryRow(String label, String value, {bool isSecondary = false, bool isLarge = false}) {
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
  
  Widget _buildSendButton() {
    return GradientButton(
      text: _isProcessing ? 'Processing...' : 'Send Tip',
      onPressed: _isProcessing || _amount <= 0 ? null : _sendTip,
      isLoading: _isProcessing,
      icon: Icons.send,
      style: GradientButtonStyle.gold,
    );
  }
  
  Widget _buildInfoNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mosanaPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.mosanaPurple.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.mosanaPurple,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your tip will be sent via Solana blockchain. Transaction usually confirms in ~400ms.',
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

/// Charity model
class Charity {
  final String id;
  final String name;
  final String description;
  final String icon;
  final double impactScore;
  
  const Charity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.impactScore,
  });
}
