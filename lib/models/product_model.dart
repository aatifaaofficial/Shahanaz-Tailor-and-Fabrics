class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final double? discountedPrice;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String fabric;
  final List<String> colors;
  final List<String> sizes;
  final bool inStock;
  final bool isNewArrival;
  final String? tag;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.discountedPrice,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.fabric,
    required this.colors,
    required this.sizes,
    required this.inStock,
    required this.isNewArrival,
    this.tag,
  });

  double get effectivePrice => discountedPrice ?? price;

  String get priceLabel => '₹${price.toStringAsFixed(0)}';

  String get discountedLabel {
    if (discountedPrice == null) return priceLabel;
    return '₹${discountedPrice!.toStringAsFixed(0)}';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      discountedPrice: json['discountedPrice'] != null ? (json['discountedPrice'] as num).toDouble() : null,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String,
      fabric: json['fabric'] as String,
      colors: List<String>.from(json['colors'] as List? ?? const []),
      sizes: List<String>.from(json['sizes'] as List? ?? const []),
      inStock: json['inStock'] as bool? ?? true,
      isNewArrival: json['isNewArrival'] as bool? ?? false,
      tag: json['tag'] as String?,
    );
  }
}
