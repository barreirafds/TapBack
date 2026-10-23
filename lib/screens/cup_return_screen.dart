import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import 'return_success_screen.dart';

class CupReturnScreen extends StatefulWidget {
  const CupReturnScreen({super.key});

  @override
  State<CupReturnScreen> createState() => _CupReturnScreenState();
}

class _CupReturnScreenState extends State<CupReturnScreen> {
  static const double refundPerCup = 0.50;

  int _cupCount = 1;

  double get _totalRefund => _cupCount * refundPerCup;

  void _confirmReturn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReturnSuccessScreen(
          cupCount: _cupCount,
          refundAmount: _totalRefund,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Return Cups'), centerTitle: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroduction(),

              const SizedBox(height: 32),

              const Text(
                'How it works',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              _buildInstruction(
                Icons.location_on_outlined,
                'Find a return station',
                'Go to a reusable cup return station '
                    'inside the festival.',
              ),

              const SizedBox(height: 18),

              _buildInstruction(
                Icons.local_drink_outlined,
                'Return your cups',
                'Hand in your reusable cups at '
                    'the return station.',
              ),

              const SizedBox(height: 18),

              _buildInstruction(
                Icons.account_balance_wallet_outlined,
                'Receive your refund',
                'After validation, the refund '
                    'is added to your wallet.',
              ),

              const SizedBox(height: 32),

              _buildReturnSimulator(),

              const SizedBox(height: 24),

              const Text(
                'Demo mode: No real cups are returned '
                'and no wallet balance is changed.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              PrimaryButton(
                text: 'Confirm Demo Return',
                onPressed: _confirmReturn,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
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
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              color: Color(0xFF282451),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.recycling,
              color: AppColors.primaryLight,
              size: 65,
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Give your cups a second life',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          const Text(
            'Return your reusable cups and '
            'receive a refund in your festival wallet.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildInstruction(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryLight),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReturnSimulator() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demo Cup Return',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'Select how many cups you want to return.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),

          const SizedBox(height: 26),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton.filledTonal(
                onPressed: _cupCount > 1
                    ? () {
                        setState(() {
                          _cupCount--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove),
              ),

              Column(
                children: [
                  Text(
                    '$_cupCount',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    'Cups',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),

              IconButton.filledTonal(
                onPressed: _cupCount < 10
                    ? () {
                        setState(() {
                          _cupCount++;
                        });
                      }
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),

          const SizedBox(height: 25),

          const Divider(color: AppColors.border),

          const SizedBox(height: 18),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Refund per cup',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Text('€0.50'),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total refund',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                '+€${_totalRefund.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
