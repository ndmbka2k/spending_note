class Transaction {
  final String id;
  final String tiltle;
  final double amount;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.tiltle,
      required this.amount,
      required this.date});
}
