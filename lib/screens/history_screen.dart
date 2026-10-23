import 'package:flutter/material.dart';

import '../models/wallet_transaction.dart';
import '../theme/app_colors.dart';

enum TransactionFilter { all, payments, refunds, topUps }

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  TransactionFilter _selectedFilter = TransactionFilter.all;

  // Temporary mock transactions.
  // Later these will be retrieved from our backend API.
  final List<WalletTransaction> _transactions = [
    WalletTransaction(
      title: 'Cup return refund',
      description: 'Return Station A',
      amount: 0.50,
      date: DateTime(2026, 10, 23),
      type: TransactionType.refund,
    ),
    WalletTransaction(
      title: 'Bar purchase',
      description: 'Main Bar',
      amount: -4.00,
      date: DateTime(2026, 10, 22),
      type: TransactionType.payment,
    ),
    WalletTransaction(
      title: 'Wallet top-up',
      description: 'Online top-up',
      amount: 25.00,
      date: DateTime(2026, 10, 21),
      type: TransactionType.topUp,
    ),
    WalletTransaction(
      title: 'Cup deposit',
      description: 'Festival Bar',
      amount: -1.00,
      date: DateTime(2026, 10, 20),
      type: TransactionType.payment,
    ),
    WalletTransaction(
      title: 'Cup return refund',
      description: 'Return Station B',
      amount: 0.50,
      date: DateTime(2026, 10, 19),
      type: TransactionType.refund,
    ),
  ];

  List<WalletTransaction> get _filteredTransactions {
    final filtered = _transactions.where((transaction) {
      switch (_selectedFilter) {
        case TransactionFilter.all:
          return true;

        case TransactionFilter.payments:
          return transaction.type == TransactionType.payment;

        case TransactionFilter.refunds:
          return transaction.type == TransactionType.refund;

        case TransactionFilter.topUps:
          return transaction.type == TransactionType.topUp;
      }
    }).toList();

    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  IconData _transactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.payment:
        return Icons.shopping_bag_outlined;
      case TransactionType.refund:
        return Icons.recycling;
      case TransactionType.topUp:
        return Icons.add_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _filteredTransactions;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Track your festival spending and refunds.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 26),

                  _buildFilters(),

                  const SizedBox(height: 24),

                  Text(
                    '${transactions.length} transactions',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: transactions.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: transactions.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        return _buildTransactionItem(transactions[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        _buildFilterButton('All', TransactionFilter.all),
        const SizedBox(width: 5),
        _buildFilterButton('Payments', TransactionFilter.payments),
        const SizedBox(width: 5),
        _buildFilterButton('Refunds', TransactionFilter.refunds),
        const SizedBox(width: 5),
        _buildFilterButton('Top-ups', TransactionFilter.topUps),
      ],
    );
  }

  Widget _buildFilterButton(String label, TransactionFilter filter) {
    final isSelected = _selectedFilter == filter;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedFilter = filter;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(WalletTransaction transaction) {
    final isPositive = transaction.isPositive;

    final amountText =
        '${isPositive ? '+' : '-'}'
        '€${transaction.amount.abs().toStringAsFixed(2)}';

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            _transactionIcon(transaction.type),
            color: isPositive ? AppColors.success : AppColors.primaryLight,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                transaction.description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                _formatDate(transaction.date),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Text(
          amountText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isPositive ? AppColors.success : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 60,
              color: AppColors.textSecondary,
            ),

            SizedBox(height: 18),

            Text(
              'No transactions found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            Text(
              'There are no transactions for this filter.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
