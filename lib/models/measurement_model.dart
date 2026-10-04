class MeasurementModel {
  final String id;
  final String profileName;
  final double shoulder;
  final double chest;
  final double waist;
  final double hip;
  final double sleeveLength;
  final double dressLength;

  const MeasurementModel({
    required this.id,
    required this.profileName,
    required this.shoulder,
    required this.chest,
    required this.waist,
    required this.hip,
    required this.sleeveLength,
    required this.dressLength,
  });
}
