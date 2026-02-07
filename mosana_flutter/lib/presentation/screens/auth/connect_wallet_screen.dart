import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/glass_card.dart';
import '../../providers/auth_provider.dart';
import '../home/home_screen.dart';

class ConnectWalletScreen extends ConsumerStatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  ConsumerState<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends ConsumerState<ConnectWalletScreen> {
  String? _connectingWallet;
  String? _errorMessage;

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
      _errorMessage = null;
    });

    try {
      // TODO: Implement real wallet connection (Phantom/Solflare deep linking)
      // For now, show error that real wallet integration is coming
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Real wallet integration coming soon!\nUse "Test Mode" button below for now.';
        _connectingWallet = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Connection failed: $e';
        _connectingWallet = null;
      });
    }
  }

  /// Mock wallet connection for testing (TODO: Remove in production)
  Future<void> _connectMockWallet() async {
    setState(() {
      _connectingWallet = 'Mock';
      _errorMessage = null;
    });

    try {
      // Generate random username for testing
      final username = 'user${DateTime.now().millisecondsSinceEpoch % 10000}';
      
      await ref.read(authStateProvider.notifier).connectMockWallet(username);

      if (!mounted) return;

      // Check if authentication was successful
      final authState = ref.read(authStateProvider);
      if (authState is _AuthStateAuthenticated) {
        // Navigate to home on success
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else if (authState is _AuthStateError) {
        setState(() {
          _errorMessage = authState.message;
          _connectingWallet = null;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Mock connection failed: $e';
        _connectingWallet = null;
      });
    }
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

                  // Error message
                  if (_errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // TEST MODE Button (for development)
                  GradientButton(
                    text: 'Continue in Test Mode',
                    onPressed: _connectingWallet == null ? _connectMockWallet : null,
                    isLoading: _connectingWallet == 'Mock',
                    icon: Icons.science,
                    style: GradientButtonStyle.gold,
                  ),

                  const SizedBox(height: 16),

                  // Test mode note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.gold.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_outlined,
                          color: AppColors.gold,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Test mode uses mock data. Real wallet integration coming soon!',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.gold,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
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
