import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/gradient_button.dart';

/// Screen for managing wallet settings
class WalletSettingsScreen extends StatefulWidget {
  const WalletSettingsScreen({super.key});

  @override
  State<WalletSettingsScreen> createState() => _WalletSettingsScreenState();
}

class _WalletSettingsScreenState extends State<WalletSettingsScreen> {
  // Mock wallet data (TODO: Get from auth state)
  final String _walletAddress = 'ABC123def456GHI789jkl012MNO345pqr678STU901';
  final String _walletProvider = 'Phantom';
  final double _balance = 25.5432;
  final String _network = 'Mainnet Beta';
  
  bool _isDisconnecting = false;
  
  Future<void> _disconnectWallet() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _buildDisconnectDialog(),
    );
    
    if (confirmed != true) return;
    
    setState(() {
      _isDisconnecting = true;
    });
    
    try {
      // TODO: Implement wallet disconnect
      // 1. Clear auth state
      // 2. Clear secure storage
      // 3. Navigate to connect wallet screen
      
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;
      
      // Navigate back to connect wallet
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Wallet disconnected successfully'),
          backgroundColor: Colors.green,
        ),
      );
      
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to disconnect: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDisconnecting = false;
        });
      }
    }
  }
  
  void _copyAddress() {
    Clipboard.setData(ClipboardData(text: _walletAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('📋 Wallet address copied!'),
        backgroundColor: AppColors.mosanaPurple,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  
  void _viewOnExplorer() {
    // TODO: Open Solana explorer
    // https://explorer.solana.com/address/$_walletAddress
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Solana Explorer...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  void _switchNetwork() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNetworkSelector(),
    );
  }
  
  void _exportPrivateKey() {
    showDialog(
      context: context,
      builder: (context) => _buildSecurityWarningDialog(),
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
          'Wallet Settings',
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
                  // Wallet card
                  _buildWalletCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Balance card
                  _buildBalanceCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Network info
                  _buildNetworkCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Actions
                  _buildActionsSection(),
                  
                  const SizedBox(height: 32),
                  
                  // Disconnect button
                  _buildDisconnectButton(),
                  
                  const SizedBox(height: 16),
                  
                  // Security note
                  _buildSecurityNote(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWalletCard() {
    return GlassCard(
      variant: GlassCardVariant.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _walletProvider,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Connected Wallet',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            'Wallet Address',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${_walletAddress.substring(0, 8)}...${_walletAddress.substring(_walletAddress.length - 8)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.copy,
                  size: 18,
                  color: AppColors.mosanaPurple,
                ),
                onPressed: _copyAddress,
                tooltip: 'Copy address',
              ),
              IconButton(
                icon: Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: AppColors.mosanaBlue,
                ),
                onPressed: _viewOnExplorer,
                tooltip: 'View on explorer',
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildBalanceCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance,
                color: AppColors.gold,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Balance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _balance.toStringAsFixed(4),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'SOL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '≈ \$${(_balance * 145.23).toStringAsFixed(2)} USD',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNetworkCard() {
    return GlassCard(
      child: Column(
        children: [
          _buildSettingRow(
            icon: Icons.language,
            title: 'Network',
            value: _network,
            onTap: _switchNetwork,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions',
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
              _buildActionRow(
                icon: Icons.history,
                title: 'Transaction History',
                subtitle: 'View all transactions',
                onTap: () {
                  // Navigate to transaction history
                  Navigator.of(context).pop();
                },
              ),
              const Divider(height: 24, color: Colors.white24),
              _buildActionRow(
                icon: Icons.key,
                title: 'Export Private Key',
                subtitle: 'For backup purposes',
                onTap: _exportPrivateKey,
                iconColor: AppColors.gold,
              ),
              const Divider(height: 24, color: Colors.white24),
              _buildActionRow(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version & info',
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Mosana',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(Icons.favorite, size: 48),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.mosanaPurple,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.mosanaPurple,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActionRow({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.mosanaPurple).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.mosanaPurple,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDisconnectButton() {
    return GradientButton(
      text: _isDisconnecting ? 'Disconnecting...' : 'Disconnect Wallet',
      onPressed: _isDisconnecting ? null : _disconnectWallet,
      isLoading: _isDisconnecting,
      icon: Icons.logout,
      style: GradientButtonStyle.secondary,
    );
  }
  
  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: AppColors.red,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Never share your private key or seed phrase. Mosana will never ask for it.',
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
  
  Widget _buildDisconnectDialog() {
    return AlertDialog(
      backgroundColor: AppColors.cardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Disconnect Wallet?',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        'Are you sure you want to disconnect your wallet? You will need to reconnect to use the app.',
        style: TextStyle(
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Disconnect',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildNetworkSelector() {
    final networks = ['Mainnet Beta', 'Devnet', 'Testnet'];
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Network',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            networks.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildNetworkOption(networks[index]),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNetworkOption(String network) {
    final isSelected = network == _network;
    
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        // TODO: Switch network
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mosanaPurple.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.mosanaPurple
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.mosanaPurple : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Text(
              network,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSecurityWarningDialog() {
    return AlertDialog(
      backgroundColor: AppColors.cardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(Icons.warning, color: AppColors.red, size: 28),
          const SizedBox(width: 12),
          const Text(
            'Security Warning',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      content: Text(
        'Exporting your private key is dangerous and should only be done for backup purposes. Never share it with anyone.',
        style: TextStyle(
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'I Understand',
            style: TextStyle(color: AppColors.mosanaPurple),
          ),
        ),
      ],
    );
  }
}
