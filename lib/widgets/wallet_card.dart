import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WalletCard extends StatelessWidget {
  final double balance;
  final String braceletId;
  final bool isConnected;

  const WalletCard({
    super.key,
    required this.balance,
    required this.braceletId,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Festival wallet balance',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.primaryLight,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            '${balance.toStringAsFixed(2)}€',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Bracelet · $braceletId',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: isConnected
                      ? AppColors.success.withValues(alpha: 0.12)
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isConnected ? 'Connected' : 'Not linked',
                  style: TextStyle(
                    color: isConnected
                        ? AppColors.success
                        : AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
