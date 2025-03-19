import 'package:objectbox/objectbox.dart';

@Entity()
class PlantAnalysisData {
  @Id()
  int id = 0;

  // To-One relations
  final ToOne<PlantIdentification> plantIdentification = ToOne<PlantIdentification>();
  final ToOne<PlantDescription> plantDescription = ToOne<PlantDescription>();
  final ToOne<HealthAssessment> healthAssessment = ToOne<HealthAssessment>();
  final ToOne<GrowingConditions> growingConditions = ToOne<GrowingConditions>();
  final ToOne<CommonProblems> commonProblems = ToOne<CommonProblems>();

  PlantAnalysisData(); // Default constructor needed for ObjectBox

  factory PlantAnalysisData.fromMap(Map<String, dynamic> map) {
    final plantData = PlantAnalysisData();

    if (map['plant_identification'] != null) {
      plantData.plantIdentification.target = PlantIdentification.fromMap(
          map['plant_identification'] as Map<String, dynamic>);
    }
    if (map['plant_description'] != null) {
      plantData.plantDescription.target = PlantDescription.fromMap(
          map['plant_description'] as Map<String, dynamic>);
    }
    if (map['health_assessment'] != null) {
      plantData.healthAssessment.target = HealthAssessment.fromMap(
          map['health_assessment'] as Map<String, dynamic>);
    }
    if (map['growing_conditions'] != null) {
      plantData.growingConditions.target = GrowingConditions.fromMap(
          map['growing_conditions'] as Map<String, dynamic>);
    }
    if (map['common_problems'] != null) {
      plantData.commonProblems.target = CommonProblems.fromMap(
          map['common_problems'] as Map<String, dynamic>);
    }

    return plantData;
  }

  factory PlantAnalysisData.fromJson(Map<String, dynamic> json) {
    final plantData = PlantAnalysisData();

    if (json['plant_identification'] != null) {
      plantData.plantIdentification.target = PlantIdentification.fromJson(
          json['plant_identification'] as Map<String, dynamic>);
    }
    if (json['plant_description'] != null) {
      plantData.plantDescription.target = PlantDescription.fromJson(
          json['plant_description'] as Map<String, dynamic>);
    }
    if (json['health_assessment'] != null) {
      plantData.healthAssessment.target = HealthAssessment.fromJson(
          json['health_assessment'] as Map<String, dynamic>);
    }
    if (json['growing_conditions'] != null) {
      plantData.growingConditions.target = GrowingConditions.fromJson(
          json['growing_conditions'] as Map<String, dynamic>);
    }
    if (json['common_problems'] != null) {
      plantData.commonProblems.target = CommonProblems.fromJson(
          json['common_problems'] as Map<String, dynamic>);
    }

    return plantData;
  }
}

@Entity()
class PlantIdentification {
  @Id()
  int id = 0;

  String species;

  PlantIdentification({required this.species});

  factory PlantIdentification.fromMap(Map<String, dynamic> map) {
    return PlantIdentification(species: map['species'] as String? ?? '');
  }

  factory PlantIdentification.fromJson(Map<String, dynamic> json) {
    return PlantIdentification(species: json['species'] as String? ?? '');
  }
}

@Entity()
class PlantDescription {
  @Id()
  int id = 0;

  String description;

  PlantDescription({required this.description});

  factory PlantDescription.fromMap(Map<String, dynamic> map) {
    return PlantDescription(description: map['description'] as String? ?? '');
  }

  factory PlantDescription.fromJson(Map<String, dynamic> json) {
    return PlantDescription(description: json['description'] as String? ?? '');
  }
}

@Entity()
class HealthAssessment {
  @Id()
  int id = 0;

  String overallHealth;

  // To-Many relationship with HealthIssue
  final ToMany<HealthIssue> potentialIssues = ToMany<HealthIssue>();

  HealthAssessment({required this.overallHealth});

  factory HealthAssessment.fromMap(Map<String, dynamic> map) {
    final healthAssessment = HealthAssessment(
      overallHealth: map['overall_health'] as String? ?? '',
    );
    if (map['potential_issues'] != null) {
      healthAssessment.potentialIssues.addAll(
        (map['potential_issues'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((x) => HealthIssue.fromMap(x))
            .toList(),
      );
    }
    return healthAssessment;
  }

  factory HealthAssessment.fromJson(Map<String, dynamic> json) {
    final healthAssessment = HealthAssessment(
      overallHealth: json['overall_health'] as String? ?? '',
    );
    if (json['potential_issues'] != null) {
      healthAssessment.potentialIssues.addAll(
        (json['potential_issues'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((issueJson) => HealthIssue.fromJson(issueJson))
            .toList(),
      );
    }
    return healthAssessment;
  }
}

@Entity()
class HealthIssue {
  @Id()
  int id = 0;

  String issue;
  String remedy;

  HealthIssue({required this.issue, required this.remedy});

  factory HealthIssue.fromMap(Map<String, dynamic> map) {
    return HealthIssue(
        issue: map['issue'] as String? ?? 'Issue not specified',
        remedy: map['remedy'] as String? ?? 'Remedy not available');
  }

  factory HealthIssue.fromJson(Map<String, dynamic> json) {
    return HealthIssue(
        issue: json['issue'] as String? ?? 'Issue not specified',
        remedy: json['remedy'] as String? ?? 'Remedy not available');
  }
}

@Entity()
class GrowingConditions {
  @Id()
  int id = 0;

  String sunlight;
  String watering;
  String soilType;

  GrowingConditions(
      {required this.sunlight, required this.watering, required this.soilType});

  factory GrowingConditions.fromMap(Map<String, dynamic> map) {
    return GrowingConditions(
      sunlight: map['sunlight'] as String? ?? '',
      watering: map['watering'] as String? ?? '',
      soilType: map['soil_type'] as String? ?? '',
    );
  }

  factory GrowingConditions.fromJson(Map<String, dynamic> json) {
    return GrowingConditions(
      sunlight: json['sunlight'] as String? ?? '',
      watering: json['watering'] as String? ?? '',
      soilType: json['soil_type'] as String? ?? '',
    );
  }
}

@Entity()
class CommonProblems {
  @Id()
  int id = 0;

  // To-Many relationship with Problem
  final ToMany<Problem> problems = ToMany<Problem>();

  CommonProblems(); // Default constructor needed for ObjectBox

  factory CommonProblems.fromMap(Map<String, dynamic> map) {
    final commonProblems = CommonProblems();
    if (map['problems'] != null) {
      commonProblems.problems.addAll(
        (map['problems'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((x) => Problem.fromMap(x))
            .toList(),
      );
    }
    return commonProblems;
  }

  factory CommonProblems.fromJson(Map<String, dynamic> json) {
    final commonProblems = CommonProblems();
    if (json['problems'] != null) {
      commonProblems.problems.addAll(
        (json['problems'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((problemJson) => Problem.fromJson(problemJson))
            .toList(),
      );
    }
    return commonProblems;
  }
}

@Entity()
class Problem {
  @Id()
  int id = 0;

  String issue;
  String remedy;

  Problem({required this.issue, required this.remedy});

  factory Problem.fromMap(Map<String, dynamic> map) {
    return Problem(
        issue: map['issue'] as String? ?? '', remedy: map['remedy'] as String? ?? '');
  }

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
        issue: json['issue'] as String? ?? '', remedy: json['remedy'] as String? ?? '');
  }
}