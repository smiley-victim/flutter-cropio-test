   // Model representing a sustainable farming practice
 class SustainablePractice {
    final String id;
    final String name;
    final String description;
    final String carbonImpact;
    final int points;
    bool isSelected;

    SustainablePractice({
      required this.id,
      required this.name,
      required this.description,
      required this.carbonImpact,
      required this.points,
      this.isSelected = false,
    });
  }