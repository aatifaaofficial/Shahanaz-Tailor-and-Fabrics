class OrderModel {
  final String id;
  final String productName;
  final String date;
  final double amount;
  final String status;
  final String imageUrl;

  const OrderModel({
    required this.id,
    required this.productName,
    required this.date,
    required this.amount,
    required this.status,
    required this.imageUrl,
  });
}
