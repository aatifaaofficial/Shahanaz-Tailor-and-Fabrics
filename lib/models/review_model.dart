class ReviewModel {
  final String id;
  final String productId;
  final String userName;
  final String comment;
  final int rating;
  final String imageUrl;
  final String date;

  const ReviewModel({
    required this.id,
    required this.productId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.imageUrl,
    required this.date,
  });
}
