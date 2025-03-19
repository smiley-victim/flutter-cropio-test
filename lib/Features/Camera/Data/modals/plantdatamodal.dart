
// class PlantAnalysisData {
//   final PlantIdentification plantIdentification;
//   final PlantDescription plantDescription;
//   final HealthAssessment healthAssessment;
//   final GrowingConditions growingConditions;
//   final CommonProblems commonProblems;

//   PlantAnalysisData({
//     required this.plantIdentification,
//     required this.plantDescription,
//     required this.healthAssessment,
//     required this.growingConditions,
//     required this.commonProblems,
//   });

//   factory PlantAnalysisData.fromMap(Map<String, dynamic> map) {
//     return PlantAnalysisData(
//       plantIdentification:
//           PlantIdentification.fromMap(map['plant_identification']),
//       plantDescription: PlantDescription.fromMap(map['plant_description']),
//       healthAssessment: HealthAssessment.fromMap(map['health_assessment']),
//       growingConditions: GrowingConditions.fromMap(map['growing_conditions']),
//       commonProblems: CommonProblems.fromMap(map['common_problems']),
//     );
//   }

//   factory PlantAnalysisData.fromJson(Map<String, dynamic> json) {
//     return PlantAnalysisData(
//       plantIdentification:
//           PlantIdentification.fromJson(json['plant_identification']),
//       plantDescription: PlantDescription.fromJson(json['plant_description']),
//       healthAssessment: HealthAssessment.fromJson(json['health_assessment']),
//       growingConditions: GrowingConditions.fromJson(json['growing_conditions']),
//       commonProblems: CommonProblems.fromJson(json['common_problems']),
//     );
//   }
// }

// class PlantIdentification {
//   final String species;

//   PlantIdentification({required this.species});
//   factory PlantIdentification.fromMap(Map<String, dynamic> map) {
//     return PlantIdentification(species: map['species']);
//   }

//   factory PlantIdentification.fromJson(Map<String, dynamic> json) {
//     return PlantIdentification(species: json['species']);
//   }
// }

// class PlantDescription {
//   final String description;

//   PlantDescription({required this.description});
//   factory PlantDescription.fromMap(Map<String, dynamic> map) {
//     return PlantDescription(description: map['description']);
//   }

//   factory PlantDescription.fromJson(Map<String, dynamic> json) {
//     return PlantDescription(description: json['description']);
//   }
// }

// class HealthAssessment {
//   final String overallHealth;
//   final List<HealthIssue> potentialIssues;

//   HealthAssessment(
//       {required this.overallHealth, required this.potentialIssues});
//   factory HealthAssessment.fromMap(Map<String, dynamic> map) {
//     return HealthAssessment(
//       overallHealth: map['overall_health'],
//       potentialIssues: List<HealthIssue>.from(
//           map['potential_issues']?.map((x) => HealthIssue.fromMap(x))),
//     );
//   }

//   factory HealthAssessment.fromJson(Map<String, dynamic> json) {
//     return HealthAssessment(
//       overallHealth: json['overall_health'],
//       potentialIssues: (json['potential_issues'] as List)
//           .map((issueJson) => HealthIssue.fromJson(issueJson))
//           .toList(),
//     );
//   }
// }

// class HealthIssue {
//   final String issue;
//   final String remedy;

//   HealthIssue({required this.issue, required this.remedy});
//   factory HealthIssue.fromMap(Map<String, dynamic> map) {
//     return HealthIssue(issue: map['issue'], remedy: map['remedy']);
//   }

//   factory HealthIssue.fromJson(Map<String, dynamic> json) {
//     return HealthIssue(
//         issue: json['issue'] as String? ?? 'Issue not specified',
//         remedy: json['remedy'] as String? ?? 'Remedy not available');
//   }
// }

// class GrowingConditions {
//   final String sunlight;
//   final String watering;
//   final String soilType;

//   GrowingConditions(
//       {required this.sunlight, required this.watering, required this.soilType});
//   factory GrowingConditions.fromMap(Map<String, dynamic> map) {
//     return GrowingConditions(
//       sunlight: map['sunlight'],
//       watering: map['watering'],
//       soilType: map['soil_type'],
//     );
//   }

//   factory GrowingConditions.fromJson(Map<String, dynamic> json) {
//     return GrowingConditions(
//       sunlight: json['sunlight'],
//       watering: json['watering'],
//       soilType: json['soil_type'],
//     );
//   }
// }

// class CommonProblems {
//   final List<Problem> problems;

//   CommonProblems({required this.problems});
//   factory CommonProblems.fromMap(Map<String, dynamic> map) {
//     return CommonProblems(
//       problems:
//           List<Problem>.from(map['problems']?.map((x) => Problem.fromMap(x))),
//     );
//   }

//   factory CommonProblems.fromJson(Map<String, dynamic> json) {
//     return CommonProblems(
//       problems: (json['problems'] as List)
//           .map((problemJson) => Problem.fromJson(problemJson))
//           .toList(),
//     );
//   }
// }

// class Problem {
//   final String issue;
//   final String remedy;

//   Problem({required this.issue, required this.remedy});
//   factory Problem.fromMap(Map<String, dynamic> map) {
//     return Problem(issue: map['issue'], remedy: map['remedy']);
//   }

//   factory Problem.fromJson(Map<String, dynamic> json) {
//     return Problem(issue: json['issue'], remedy: json['remedy']);
//   }
// }
