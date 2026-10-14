class WalletTransaction {
  final String title;
  final String description;
  final double amount;
  final DateTime date;

  const WalletTransaction({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
  });

  bool get isPositive => amount > 0;
}
