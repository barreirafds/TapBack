enum TransactionType { payment, refund, topUp }

class WalletTransaction {
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;

  const WalletTransaction({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    this.type = TransactionType.payment,
  });

  bool get isPositive => amount > 0;
}
