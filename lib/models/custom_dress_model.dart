class CustomDressModel {
  final String id;
  final String dressType;
  final String fabric;
  final String color;
  final String neckDesign;
  final String sleeve;
  final String length;
  final String size;
  final Map<String, String> measurements;
  final String? referenceImageUrl;
  final double estimatedPrice;

  const CustomDressModel({
    required this.id,
    required this.dressType,
    required this.fabric,
    required this.color,
    required this.neckDesign,
    required this.sleeve,
    required this.length,
    required this.size,
    required this.measurements,
    this.referenceImageUrl,
    required this.estimatedPrice,
  });
}
