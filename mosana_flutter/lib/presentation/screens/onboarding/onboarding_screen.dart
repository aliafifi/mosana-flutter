import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                // Logo Section
                const SizedBox(height: 20),
                _buildLogo(),
                const SizedBox(height: 32),
                
                // Tagline
                _buildTagline(),
                const SizedBox(height: 16),
                
                // Subtitle
                _buildSubtitle(),
                const SizedBox(height: 48),
                
                // Feature Cards
                _buildFeatureCard(
                  icon: Icons.flash_on,
                  title: '5× Multiplier',
                  description: 'Earn up to 5× rewards for verified humans',
                ),
                const SizedBox(height: 14),
                _buildFeatureCard(
                  icon: Icons.shield_outlined,
                  title: 'Conscious Finance',
                  description: 'Ethical, fair, and transparent',
                ),
                const SizedBox(height: 14),
                _buildFeatureCard(
                  icon: Icons.favorite_border,
                  title: 'Social Good',
                  description: 'Every tip funds real-world impact',
                ),
                const SizedBox(height: 32),
                
                // Connect Wallet Button
                _buildConnectButton(context),
                const SizedBox(height: 32),
                
                // Supported Wallets
                _buildSupportedWallets(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // Logo Image
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.mosanaPurple.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/mosana-logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Mosana Title with Gradient
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
          child: const Text(
            'Mosana',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -1.2,
            ),
          ),
        ),
        const SizedBox(height: 6),
        
        // Subtitle
        Text(
          'ETHICAL SOCIALFI',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return const Text(
      'Give More. Earn More. Impact More.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.3,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'The first ethical SocialFi platform on Solana where your generosity is rewarded. Connect your wallet to start your journey.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.mosanaPurple.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.mosanaPurple.withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.mosanaPurple.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          // Save that user has completed onboarding
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isFirstTime', false);
          
          // Navigate to Home
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.account_balance_wallet,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(width: 12),
            Text(
              'Connect Wallet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportedWallets() {
    return Column(
      children: [
        Text(
          'SUPPORTED WALLETS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWalletBadge('Phantom'),
            const SizedBox(width: 10),
            _buildWalletBadge('Solflare'),
            const SizedBox(width: 10),
            _buildWalletBadge('Saga'),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletBadge(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.mosanaPurple.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
