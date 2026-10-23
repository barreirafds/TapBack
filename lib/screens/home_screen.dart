import 'package:flutter/material.dart';

import '../models/wallet_transaction.dart';
import '../theme/app_colors.dart';
import '../widgets/wallet_card.dart';
import 'cup_return_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Temporary mock data until Neon API integration.
  final double balance = 42.50;

  final String braceletId = 'TB-8F2A';

  static final List<WalletTransaction> transactions = [
    WalletTransaction(
      title: 'Cup return refund',
      description: 'Return Station A',
      amount: 0.50,
      date: DateTime(2026, 10, 14),
    ),
    WalletTransaction(
      title: 'Bar purchase',
      description: 'Main Bar',
      amount: -4.00,
      date: DateTime(2026, 10, 13),
    ),
  ];

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
                'YOUR FESTIVAL WALLET',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Hey, Diego.',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              const WalletCard(
                balance: 42.50,
                braceletId: 'TB-8F2A',
                isConnected: true,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CupReturnScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.recycling),
                  label: const Text('Return Cups'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Recent activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              ...transactions.map((transaction) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,

                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        transaction.isPositive
                            ? Icons.recycling
                            : Icons.shopping_bag_outlined,
                        color: transaction.isPositive
                            ? AppColors.success
                            : AppColors.textSecondary,
                      ),
                    ),

                    title: Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: Text(
                      transaction.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),

                    trailing: Text(
                      '${transaction.isPositive ? '+' : ''}'
                      '${transaction.amount.toStringAsFixed(2)}€',
                      style: TextStyle(
                        color: transaction.isPositive
                            ? AppColors.success
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
