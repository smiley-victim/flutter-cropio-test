class AllPlantName {
  final List<String> plantName;

  AllPlantName({required this.plantName});

  factory AllPlantName.fromJson(Map<String, dynamic> data) {
    return AllPlantName(
      plantName: (data['crops'] as List<dynamic>)
          .map(
            (e) => e["plant"].toString(),
          )
          .toList(),
    );
  }
}
