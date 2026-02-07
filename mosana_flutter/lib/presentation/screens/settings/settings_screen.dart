import 'package:flutter/material.dart';
import '../../../core/config/colors.dart';
import '../../widgets/common/glass_card.dart';

/// Settings and preferences screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Theme settings
  bool _isDarkMode = true;
  String _accentColor = 'Purple';
  
  // Notification settings
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _likesNotif = true;
  bool _commentsNotif = true;
  bool _tipsNotif = true;
  bool _followsNotif = true;
  bool _mintsNotif = true;
  
  // Privacy settings
  bool _publicProfile = true;
  bool _showBalance = false;
  bool _showActivity = true;
  
  // App settings
  bool _autoPlayVideos = true;
  bool _highQualityImages = true;
  String _language = 'English';
  
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
          'Settings',
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
                  // Appearance
                  _buildSectionTitle('Appearance'),
                  const SizedBox(height: 12),
                  _buildAppearanceSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Notifications
                  _buildSectionTitle('Notifications'),
                  const SizedBox(height: 12),
                  _buildNotificationsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Privacy
                  _buildSectionTitle('Privacy & Security'),
                  const SizedBox(height: 12),
                  _buildPrivacySection(),
                  
                  const SizedBox(height: 24),
                  
                  // App Settings
                  _buildSectionTitle('App Settings'),
                  const SizedBox(height: 12),
                  _buildAppSettingsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Account
                  _buildSectionTitle('Account'),
                  const SizedBox(height: 12),
                  _buildAccountSection(),
                  
                  const SizedBox(height: 24),
                  
                  // About
                  _buildSectionTitle('About'),
                  const SizedBox(height: 12),
                  _buildAboutSection(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
  
  Widget _buildAppearanceSection() {
    return GlassCard(
      child: Column(
        children: [
          _buildSwitchRow(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Use dark theme',
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildSelectRow(
            icon: Icons.palette,
            title: 'Accent Color',
            subtitle: _accentColor,
            onTap: () {
              _showAccentColorPicker();
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotificationsSection() {
    return GlassCard(
      child: Column(
        children: [
          _buildSwitchRow(
            icon: Icons.notifications,
            title: 'Push Notifications',
            subtitle: 'Receive push notifications',
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildSwitchRow(
            icon: Icons.email,
            title: 'Email Notifications',
            subtitle: 'Receive email updates',
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notify me about:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildCheckboxRow('❤️ Likes', _likesNotif, (value) {
                  setState(() => _likesNotif = value!);
                }),
                _buildCheckboxRow('💬 Comments', _commentsNotif, (value) {
                  setState(() => _commentsNotif = value!);
                }),
                _buildCheckboxRow('💸 Tips', _tipsNotif, (value) {
                  setState(() => _tipsNotif = value!);
                }),
                _buildCheckboxRow('👥 New Followers', _followsNotif, (value) {
                  setState(() => _followsNotif = value!);
                }),
                _buildCheckboxRow('✨ NFT Mints', _mintsNotif, (value) {
                  setState(() => _mintsNotif = value!);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacySection() {
    return GlassCard(
      child: Column(
        children: [
          _buildSwitchRow(
            icon: Icons.public,
            title: 'Public Profile',
            subtitle: 'Anyone can view your profile',
            value: _publicProfile,
            onChanged: (value) {
              setState(() {
                _publicProfile = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildSwitchRow(
            icon: Icons.account_balance_wallet,
            title: 'Show Wallet Balance',
            subtitle: 'Display balance on profile',
            value: _showBalance,
            onChanged: (value) {
              setState(() {
                _showBalance = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildSwitchRow(
            icon: Icons.history,
            title: 'Show Activity',
            subtitle: 'Display recent activity',
            value: _showActivity,
            onChanged: (value) {
              setState(() {
                _showActivity = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.block,
            title: 'Blocked Users',
            subtitle: 'Manage blocked users',
            onTap: () {
              // Navigate to blocked users
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.security,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {
              // Open privacy policy
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAppSettingsSection() {
    return GlassCard(
      child: Column(
        children: [
          _buildSwitchRow(
            icon: Icons.play_circle,
            title: 'Auto-play Videos',
            subtitle: 'Videos play automatically',
            value: _autoPlayVideos,
            onChanged: (value) {
              setState(() {
                _autoPlayVideos = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildSwitchRow(
            icon: Icons.high_quality,
            title: 'High Quality Images',
            subtitle: 'Load full resolution images',
            value: _highQualityImages,
            onChanged: (value) {
              setState(() {
                _highQualityImages = value;
              });
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildSelectRow(
            icon: Icons.language,
            title: 'Language',
            subtitle: _language,
            onTap: () {
              _showLanguagePicker();
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.storage,
            title: 'Clear Cache',
            subtitle: 'Free up storage space',
            onTap: () {
              _showClearCacheDialog();
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAccountSection() {
    return GlassCard(
      child: Column(
        children: [
          _buildActionRow(
            icon: Icons.person,
            title: 'Edit Profile',
            subtitle: 'Update your profile information',
            onTap: () {
              // Navigate to edit profile
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.account_balance_wallet,
            title: 'Wallet Settings',
            subtitle: 'Manage connected wallet',
            onTap: () {
              // Navigate to wallet settings
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Disconnect wallet and sign out',
            onTap: () {
              _showSignOutDialog();
            },
            iconColor: AppColors.red,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAboutSection() {
    return GlassCard(
      child: Column(
        children: [
          _buildActionRow(
            icon: Icons.info,
            title: 'App Version',
            subtitle: '1.0.0 (Build 1)',
            onTap: null,
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.description,
            title: 'Terms of Service',
            subtitle: 'Read our terms',
            onTap: () {
              // Open terms
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help with the app',
            onTap: () {
              // Open support
            },
          ),
          const Divider(height: 24, color: Colors.white24),
          _buildActionRow(
            icon: Icons.star,
            title: 'Rate Mosana',
            subtitle: 'Share your feedback',
            onTap: () {
              // Open rating
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSwitchRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.mosanaPurple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.mosanaPurple,
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
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.mosanaPurple,
        ),
      ],
    );
  }
  
  Widget _buildSelectRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.mosanaPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.mosanaPurple,
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: iconColor ?? Colors.white,
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
          if (onTap != null)
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
        ],
      ),
    );
  }
  
  Widget _buildCheckboxRow(String label, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.mosanaPurple,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAccentColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
              'Accent Color',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            _buildColorOption('Purple', AppColors.mosanaPurple),
            const SizedBox(height: 12),
            _buildColorOption('Blue', AppColors.mosanaBlue),
            const SizedBox(height: 12),
            _buildColorOption('Gold', AppColors.gold),
            const SizedBox(height: 12),
            _buildColorOption('Green', AppColors.green),
          ],
        ),
      ),
    );
  }
  
  Widget _buildColorOption(String name, Color color) {
    final isSelected = _accentColor == name;
    
    return InkWell(
      onTap: () {
        setState(() {
          _accentColor = name;
        });
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
              ),
          ],
        ),
      ),
    );
  }
  
  void _showLanguagePicker() {
    final languages = ['English', 'Spanish', 'French', 'German', 'Chinese', 'Japanese'];
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
              'Language',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ...languages.map((lang) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildLanguageOption(lang),
            )),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLanguageOption(String language) {
    final isSelected = _language == language;
    
    return InkWell(
      onTap: () {
        setState(() {
          _language = language;
        });
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mosanaPurple.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.mosanaPurple : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.mosanaPurple : AppColors.textSecondary,
            ),
            const SizedBox(width: 16),
            Text(
              language,
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
  
  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Clear Cache?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'This will clear all cached images and data. This may free up storage space.',
          style: TextStyle(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ Cache cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(
              'Clear',
              style: TextStyle(
                color: AppColors.mosanaPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Sign Out?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to disconnect your wallet and sign out?',
          style: TextStyle(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Sign out
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
