import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class ReturnSuccessScreen extends StatelessWidget {
  final int cupCount;
  final double refundAmount;

  const ReturnSuccessScreen({
    super.key,
    required this.cupCount,
    required this.refundAmount,
  });

  void _returnToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Return Result')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 75,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Return Successful!',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                'Your demo cup return has been completed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Simulated Refund',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '+€${refundAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Divider(color: AppColors.border),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cups returned',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        Text(
                          '$cupCount',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction type',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        Text('Demo Refund'),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              const Text(
                'This was a simulation. Your wallet '
                'balance has not been changed.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: 'Back to Home',
                onPressed: () => _returnToHome(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
