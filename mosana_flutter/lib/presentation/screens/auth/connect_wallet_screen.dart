import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/glass_card.dart';
import '../home/home_screen.dart';

class ConnectWalletScreen extends StatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen> {
  String? _connectingWallet;

  final List<WalletOption> _wallets = [
    const WalletOption(
      name: 'Phantom',
      description: 'Recommended',
      icon: Icons.account_balance_wallet,
      isRecommended: true,
    ),
    const WalletOption(
      name: 'Solflare',
      description: 'Popular choice',
      icon: Icons.local_fire_department,
      isRecommended: false,
    ),
    const WalletOption(
      name: 'Saga',
      description: 'Mobile optimized',
      icon: Icons.phone_android,
      isRecommended: false,
    ),
  ];

  Future<void> _connectWallet(String walletName) async {
    setState(() {
      _connectingWallet = walletName;
    });

    // Simulate connection (in real app, this would open wallet app)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // For preview, just navigate to home
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 1.0,
                    colors: [
                      AppColors.mosanaPurple.withOpacity(0.15),
                      AppColors.pureBlack,
                    ],
                  ),
                ),
              ),
            ),

            // Content
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Logo
                  Image.asset(
                    'assets/images/mosana-logo.png',
                    width: 80,
                    height: 80,
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Connect Your Wallet',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Choose your preferred Solana wallet\nto get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Wallet options
                  ...List.generate(
                    _wallets.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildWalletCard(_wallets[index]),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Security note
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardSurface.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.mosanaPurple.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: AppColors.mosanaPurple,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Secure connection via deep linking.\nYour keys never leave your wallet.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Learn more
                  TextButton(
                    onPressed: () {
                      // TODO: Open wallet guide
                    },
                    child: Text(
                      'Don\'t have a wallet? Learn more →',
                      style: TextStyle(
                        color: AppColors.mosanaBlue,
                        fontSize: 14,
                      ),
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

  Widget _buildWalletCard(WalletOption wallet) {
    final isConnecting = _connectingWallet == wallet.name;

    return GlassCard(
      variant: wallet.isRecommended
          ? GlassCardVariant.highlighted
          : GlassCardVariant.standard,
      onTap: isConnecting ? null : () => _connectWallet(wallet.name),
      child: Row(
        children: [
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: wallet.isRecommended
                  ? AppColors.primaryGradient
                  : LinearGradient(
                      colors: [
                        Colors.grey.shade800,
                        Colors.grey.shade900,
                      ],
                    ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              wallet.icon,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // Wallet info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      wallet.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (wallet.isRecommended) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '✓ Recommended',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  wallet.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Arrow or loading
          if (isConnecting)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          else
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
        ],
      ),
    );
  }
}

class WalletOption {
  final String name;
  final String description;
  final IconData icon;
  final bool isRecommended;

  const WalletOption({
    required this.name,
    required this.description,
    required this.icon,
    this.isRecommended = false,
  });
}
