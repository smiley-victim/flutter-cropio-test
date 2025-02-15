class PlantInfo {
  final String id;
  final String name;
  final List<String> imageUrl;
  final String description;
  final String type;

  PlantInfo({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.type,
  });

  factory PlantInfo.fromJson(Map<String, dynamic> json) {
    return PlantInfo(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'] != null ? List<String>.from(json['image_url']) : [],
      description: json['description'],
      type: json['type'],
    );
  }
}
