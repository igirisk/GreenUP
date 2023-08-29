class Challenge {
  String name;
  String image;
  String description;
  String waterSaved;
  String carbonSaved;
  String wasteSaved;

  Challenge({
    required this.name,
    required this.image,
    required this.description,
    required this.waterSaved,
    required this.carbonSaved,
    required this.wasteSaved,
  });

  Challenge.fromMap(this.name, Map<String, dynamic> snapshot)
      : image = snapshot['image'] ?? '',
        description = snapshot['description'] ?? '',
        waterSaved = snapshot['waterSaved'] ?? '',
        carbonSaved = snapshot['carbonSaved'] ?? '',
        wasteSaved = snapshot['wasteSaved'] ?? '';
}
