

// import 'package:myapp/Features/Camera/Data/modals/plantdatamodal.dart';
// import 'package:myapp/objectbox.g.dart';

// class ObjectBoxDataService {
//   final Store _store;
//   late final Box<PlantAnalysisData> _plantAnalysisBox;
//   late final Box<PlantIdentification> _plantIdentificationBox;
//   late final Box<PlantDescription> _plantDescriptionBox;
//   late final Box<HealthAssessment> _healthAssessmentBox;
//   late final Box<HealthIssue> _healthIssueBox;
//   late final Box<GrowingConditions> _growingConditionsBox;
//   late final Box<CommonProblems> _commonProblemsBox;
//   late final Box<Problem> _problemBox;

//   ObjectBoxDataService(this._store) {
//     _plantAnalysisBox = _store.box<PlantAnalysisData>();
//     _plantIdentificationBox = _store.box<PlantIdentification>();
//     _plantDescriptionBox = _store.box<PlantDescription>();
//     _healthAssessmentBox = _store.box<HealthAssessment>();
//     _healthIssueBox = _store.box<HealthIssue>();
//     _growingConditionsBox = _store.box<GrowingConditions>();
//     _commonProblemsBox = _store.box<CommonProblems>();
//     _problemBox = _store.box<Problem>();
//   }

//   // ---------------------------------- Store Data ----------------------------------

//   int storePlantAnalysisData(PlantAnalysisData plantData) {
//     // For To-One relations, ObjectBox will automatically handle saving if cascade-save is enabled (default).
//     // For To-Many relations, we need to explicitly put related entities into their boxes and then
//     // add them to the ToMany<> relation.

//     // 1. Store related entities first if they are new (have id == 0).
//     if (plantData.plantIdentification.target != null &&
//         plantData.plantIdentification.targetId == 0) {
//       _plantIdentificationBox.put(plantData.plantIdentification.target!);
//     }
//     if (plantData.plantDescription.target != null &&
//         plantData.plantDescription.targetId == 0) {
//       _plantDescriptionBox.put(plantData.plantDescription.target!);
//     }
//     if (plantData.growingConditions.target != null &&
//         plantData.growingConditions.targetId == 0) {
//       _growingConditionsBox.put(plantData.growingConditions.target!);
//     }

//     if (plantData.healthAssessment.target != null) {
//       HealthAssessment healthAssessment = plantData.healthAssessment.target!;
//       if (healthAssessment.id == 0) {
//         _healthAssessmentBox.put(healthAssessment);
//       }
//       // Store HealthIssues and add them to the ToMany relation
//       for (var issue in healthAssessment.potentialIssues) {
//         if (issue.id == 0) {
//           _healthIssueBox.put(issue);
//         }
//       }
//       healthAssessment.potentialIssues
//           .applyToDb(); // Apply changes to ToMany relation
//     }

//     if (plantData.commonProblems.target != null) {
//       CommonProblems commonProblems = plantData.commonProblems.target!;
//       if (commonProblems.id == 0) {
//         _commonProblemsBox.put(commonProblems);
//       }
//       // Store Problems and add them to the ToMany relation
//       for (var problem in commonProblems.problems) {
//         if (problem.id == 0) {
//           _problemBox.put(problem);
//         }
//       }
//       commonProblems.problems.applyToDb(); // Apply changes to ToMany relation
//     }

//     // 2. Finally, store the main PlantAnalysisData entity.
//     return _plantAnalysisBox
//         .put(plantData); // Returns the ID of the stored PlantAnalysisData
//   }

//   // ---------------------------------- Retrieve Data ----------------------------------

//   PlantAnalysisData? getPlantAnalysisDataById(int id) {
//     return _plantAnalysisBox.get(id);
//   }

//   List<PlantAnalysisData> getAllPlantAnalysisData() {
//     return _plantAnalysisBox.getAll();
//   }

//   // Example: Query PlantAnalysisData by Plant Species
//    List<PlantAnalysisData> getPlantAnalysisDataBySpecies(String species) {
//     final query = _plantAnalysisBox.query(
//       PlantAnalysisData_.plantIdentification.species.equals(species) // Correct and simplified query
//     ).build();
//     final results = query.find();
//     query.close();
//     return results;
//   }
//   // Example: Query PlantAnalysisData with a specific health condition
//   List<PlantAnalysisData> getPlantAnalysisDataByHealthCondition(
//       String healthCondition) {
//     final query = _plantAnalysisBox
//         .query(PlantAnalysisData_.healthAssessment
//             .property(HealthAssessment_.overallHealth)
//             .equals(healthCondition))
//         .build();
//     final results = query.find();
//     query.close();
//     return results;
//   }
// }


