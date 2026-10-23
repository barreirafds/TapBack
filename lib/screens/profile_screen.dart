import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Temporary mock data until backend integration.
  static const String userName = 'Demo User';
  static const String userEmail = 'demo@tapback.com';
  static const String festivalName = 'TapBack Demo Festival';
  static const String braceletId = 'TB-8F2A';

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Log Out'),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // Demo logout: return to Welcome Screen.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              _buildProfileHeader(),

              const SizedBox(height: 35),

              _buildSectionTitle('ACCOUNT INFORMATION'),

              const SizedBox(height: 12),

              _buildAccountCard(),

              const SizedBox(height: 30),

              _buildSectionTitle('MY FESTIVAL'),

              const SizedBox(height: 12),

              _buildFestivalCard(),

              const SizedBox(height: 35),

              _buildLogoutButton(context),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'TapBack • Version 1.0.0',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: const BoxDecoration(
            color: Color(0xFF29234C),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_outline,
            color: AppColors.primaryLight,
            size: 38,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                userName,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text(
                userEmail,
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Demo Account',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.3,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildAccountCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          _ProfileInfoRow(
            icon: Icons.person_outline,
            label: 'Full Name',
            value: userName,
          ),

          Divider(height: 32, color: AppColors.border),

          _ProfileInfoRow(
            icon: Icons.email_outlined,
            label: 'Email Address',
            value: userEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          _ProfileInfoRow(
            icon: Icons.music_note_outlined,
            label: 'Current Festival',
            value: festivalName,
          ),

          Divider(height: 32, color: AppColors.border),

          _ProfileInfoRow(
            icon: Icons.nfc,
            label: 'NFC Bracelet (Demo)',
            value: braceletId,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout),
        label: const Text('Log Out'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// Reusable widget for profile information.
class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 24),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
