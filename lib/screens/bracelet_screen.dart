import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class BraceletScreen extends StatefulWidget {
  const BraceletScreen({super.key});

  @override
  State<BraceletScreen> createState() => _BraceletScreenState();
}

class _BraceletScreenState extends State<BraceletScreen> {
  // Temporary state until backend and NFC integration.
  String? _braceletId;
  bool _isScanning = false;

  bool get _isConnected => _braceletId != null;

  void _startLinking() {
    setState(() {
      _isScanning = true;
    });
  }

  void _completeDemoScan() {
    setState(() {
      _braceletId = 'TB-8F2A';
      _isScanning = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demo bracelet linked successfully!')),
    );
  }

  void _cancelScan() {
    setState(() {
      _isScanning = false;
    });
  }

  void _unlinkBracelet() {
    setState(() {
      _braceletId = null;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Bracelet unlinked.')));
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
                'My Bracelet',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Manage your festival NFC bracelet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 30),

              _buildBraceletCard(),

              const SizedBox(height: 30),

              _buildInstructions(),

              const SizedBox(height: 30),

              if (_isScanning)
                _buildScanningSection()
              else if (_isConnected)
                _buildUnlinkButton()
              else
                PrimaryButton(text: 'Link Bracelet', onPressed: _startLinking),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBraceletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: const BoxDecoration(
              color: Color(0xFF252347),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.watch_outlined,
              size: 75,
              color: AppColors.primaryLight,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            _isConnected ? 'Bracelet linked' : 'No bracelet linked',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            _isConnected
                ? 'Your bracelet is ready to use.'
                : 'Connect your festival bracelet '
                      'to your TapBack wallet.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),

          const SizedBox(height: 18),

          _buildStatusBadge(),

          if (_isConnected) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bracelet ID',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _braceletId!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _isConnected
            ? AppColors.success.withValues(alpha: 0.12)
            : AppColors.border,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _isConnected ? 'Connected' : 'Not Connected',
        style: TextStyle(
          color: _isConnected ? AppColors.success : AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How it works',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 18),

        Row(
          children: [
            Icon(Icons.nfc, color: AppColors.primaryLight),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                'Hold your bracelet near your phone.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        Row(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.primaryLight,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                'Link it to your festival wallet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScanningSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.nfc, color: AppColors.primaryLight, size: 45),

          const SizedBox(height: 12),

          const Text(
            'Simulated NFC Scan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'Demo mode. No NFC hardware is used.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),

          const SizedBox(height: 22),

          PrimaryButton(
            text: 'Complete Demo Scan',
            onPressed: _completeDemoScan,
          ),

          TextButton(onPressed: _cancelScan, child: const Text('Cancel')),
        ],
      ),
    );
  }

  Widget _buildUnlinkButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: _unlinkBracelet,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Unlink Bracelet'),
      ),
    );
  }
}
