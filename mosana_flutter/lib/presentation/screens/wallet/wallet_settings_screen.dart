import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/gradient_button.dart';

/// Screen for wallet settings and management
class WalletSettingsScreen extends StatefulWidget {
  const WalletSettingsScreen({super.key});

  @override
  State<WalletSettingsScreen> createState() => _WalletSettingsScreenState();
}

class _WalletSettingsScreenState extends State<WalletSettingsScreen> {
  String _selectedNetwork = 'mainnet'; // mainnet or devnet
  bool _showTestWallets = false;
  bool _autoConfirm = false;
  
  // Mock wallet data (TODO: Get from actual connected wallet)
  final String _walletAddress = 'Ae2td15DdVGpV7LmNhKHcpg3fjLTJ3W8S9pQJU9sR8TpqLvM6BxpYhpz9Hc';
  final String _walletProvider = 'Phantom';
  final double _balance = 12.5467; // SOL
  final String _walletIcon = '👻'; // Phantom ghost
  
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
                  // Connected wallet card
                  _buildConnectedWalletCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Network section
                  _buildSectionHeader('Network'),
                  const SizedBox(height: 12),
                  _buildNetworkSelection(),
                  
                  const SizedBox(height: 24),
                  
                  // Preferences section
                  _buildSectionHeader('Preferences'),
                  const SizedBox(height: 12),
                  _buildPreferences(),
                  
                  const SizedBox(height: 24),
                  
                  // Security section
                  _buildSectionHeader('Security'),
                  const SizedBox(height: 12),
                  _buildSecurityOptions(),
                  
                  const SizedBox(height: 32),
                  
                  // Disconnect button
                  _buildDisconnectButton(),
                  
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
  
  Widget _buildConnectedWalletCard() {
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
                child: Center(
                  child: Text(
                    _walletIcon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Connected Wallet',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: AppColors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Active',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _walletProvider,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          const Divider(height: 1, color: Colors.white24),
          const SizedBox(height: 16),
          
          // Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Balance',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${_balance.toStringAsFixed(4)} SOL',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Wallet address
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_walletAddress.substring(0, 12)}...${_walletAddress.substring(_walletAddress.length - 8)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mosanaBlue,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.copy,
                  size: 20,
                  color: AppColors.mosanaBlue,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _walletAddress));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Address copied to clipboard'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
  
  Widget _buildNetworkSelection() {
    return Column(
      children: [
        _buildNetworkOption(
          'Mainnet Beta',
          'mainnet',
          'Production network for real transactions',
          recommended: true,
        ),
        const SizedBox(height: 12),
        _buildNetworkOption(
          'Devnet',
          'devnet',
          'Testing network with free SOL tokens',
        ),
      ],
    );
  }
  
  Widget _buildNetworkOption(String title, String value, String description, {bool recommended = false}) {
    final isSelected = _selectedNetwork == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNetwork = value;
        });
        _showNetworkChangeDialog(title);
      },
      child: GlassCard(
        variant: isSelected ? GlassCardVariant.highlighted : GlassCardVariant.standard,
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _selectedNetwork,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedNetwork = newValue;
                  });
                  _showNetworkChangeDialog(title);
                }
              },
              activeColor: AppColors.mosanaPurple,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (recommended) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '⭐ Recommended',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPreferences() {
    return Column(
      children: [
        _buildSwitchOption(
          'Show Test Wallets',
          'Display test wallet options for development',
          _showTestWallets,
          (value) {
            setState(() {
              _showTestWallets = value;
            });
          },
        ),
        const SizedBox(height: 12),
        _buildSwitchOption(
          'Auto-confirm Transactions',
          'Skip confirmation dialog for transactions under 0.1 SOL',
          _autoConfirm,
          (value) {
            setState(() {
              _autoConfirm = value;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildSecurityOptions() {
    return Column(
      children: [
        _buildActionOption(
          Icons.fingerprint,
          'Biometric Authentication',
          'Use fingerprint or Face ID to confirm transactions',
          onTap: () {
            // TODO: Implement biometric setup
            _showComingSoonDialog('Biometric Authentication');
          },
        ),
        const SizedBox(height: 12),
        _buildActionOption(
          Icons.vpn_key,
          'Export Private Key',
          'Backup your wallet private key (use with caution)',
          onTap: () {
            _showPrivateKeyWarningDialog();
          },
          isWarning: true,
        ),
        const SizedBox(height: 12),
        _buildActionOption(
          Icons.history,
          'Transaction History',
          'View all your blockchain transactions',
          onTap: () {
            // TODO: Navigate to transaction history
            Navigator.pushNamed(context, '/transaction-history');
          },
        ),
      ],
    );
  }
  
  Widget _buildSwitchOption(String title, String description, bool value, Function(bool) onChanged) {
    return GlassCard(
      child: Row(
        children: [
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.mosanaPurple,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionOption(IconData icon, String title, String description, {VoidCallback? onTap, bool isWarning = false}) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (isWarning ? Colors.orange : AppColors.mosanaPurple).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isWarning ? Colors.orange : AppColors.mosanaPurple,
                size: 24,
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
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDisconnectButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _showDisconnectDialog,
        icon: const Icon(Icons.logout),
        label: const Text('Disconnect Wallet'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.withOpacity(0.2),
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.red.withOpacity(0.3)),
          ),
        ),
      ),
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
              'Your private keys are never stored on our servers. All transactions are signed locally in your wallet.',
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
  
  void _showNetworkChangeDialog(String networkName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.deepPurpleBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Network Changed',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Switched to $networkName. Please reconnect your wallet for the changes to take effect.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: AppColors.mosanaPurple)),
          ),
        ],
      ),
    );
  }
  
  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.deepPurpleBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Coming Soon',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '$feature will be available in the next update!',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: AppColors.mosanaPurple)),
          ),
        ],
      ),
    );
  }
  
  void _showPrivateKeyWarningDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.deepPurpleBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            const SizedBox(width: 8),
            const Text(
              'Warning',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: Text(
          'Exporting your private key is dangerous. Anyone with access to your private key can steal your funds. Only proceed if you know what you\'re doing.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement private key export
              _showComingSoonDialog('Private Key Export');
            },
            child: const Text('I Understand', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }
  
  void _showDisconnectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.deepPurpleBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Disconnect Wallet?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to disconnect your wallet? You\'ll need to reconnect to use Mosana.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual disconnect
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Wallet disconnected'),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Disconnect', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
