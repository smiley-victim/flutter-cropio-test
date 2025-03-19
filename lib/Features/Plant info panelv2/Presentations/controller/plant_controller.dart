// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart' as dio;

// class PlantController extends GetxController {
//   final dio.Dio _dio = dio.Dio();
//   var isLoading = true.obs;
//   var growthStages = [].obs;
//   var harvestInfo = {}.obs;
//   var pests = [].obs;
//   var diseases = [].obs;
//   var growingCondition = <String, dynamic>{}.obs;
//   var macronutrients = <String, dynamic>{}.obs;
//   var scientificName = "".obs;
//   var imageUrls = <String>[].obs;
//   // var storage = <String, dynamic>{}.obs;
//   // var storageInnovations = <String>[].obs;
//   var storage = <String, dynamic>{}.obs;
//   var storageInnovations = <String>[].obs;
//   var traditionalUses = <String, dynamic>{}.obs;
//   var culinaryUses = <String>[].obs;
//   var pollination = <String, dynamic>{}.obs;
//   var careInstructions = <Map<String, dynamic>>[].obs;
//   var cropData = <String, dynamic>{}.obs;

//   var propagationMethods = <String, dynamic>{}.obs;
//   var selectedPropagationMethod = "".obs;
//   var companionPlants = <Map<String, String>>[].obs;

//   var climateChangeAdaptation = <String, String>{}.obs;
//   var geneticVarieties = <Map<String, String>>[].obs;

//   var sunlight = "Full sun to partial shade".obs;
//   var water = "Moderate watering".obs;
//   var temperature = "25-35°C".obs;
//   var humidity = "High".obs;
//   var season = "June - August".obs;
//   var plantYield = "80-200 kg per year".obs;

//   Future<void> fetchGrowthStages(String plantId) async {
//     isLoading(true);
//     try {
//       dio.Response response = await _dio.get(
//         'https://beta-api.cropio.in/manage-crops/$plantId',
//         options: Options(headers: {
//           "Authorization":
//               "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ0MTMzNTc4LCJpYXQiOjE3NDE1NDE1NzgsImp0aSI6ImM4MjQwMWMwZjAxZjQ5NzliMzcxMzQ1YWE2MTAwYjEwIiwidXNlcl9pZCI6IjFjZWQyMzBmLWQxZTEtNDJiMi05NzA1LTU1MzY5YTZkOWRmZSJ9.ilOcwRpxx8A7kLWHI_ww1bEn-5cFfppb2B9cLI6t_I4",
//           "Content-Type": "application/json",
//         }),
//       );

//       debugPrint(
//           "Full API Response: ${response.data}"); // Debugging: Print entire response

//       if (response.statusCode == 200) {
//         var responseData = response.data;

//         if (responseData != null &&
//             responseData is Map &&
//             responseData.containsKey('crop')) {
//           var cropData = responseData['crop'];

//           if (cropData is Map && cropData.containsKey('growthStages')) {
//             growthStages.assignAll(cropData['growthStages']);
//             debugPrint("Updated Growth Stages: ${growthStages.value}");
//           } else {
//             debugPrint(
//                 "Key 'growthStages' not found inside 'crop'. Available keys in crop: ${cropData.keys}");
//           }

//           // Extract image URLs

//           if (cropData.containsKey('imageUrl') &&
//               cropData['imageUrl'] is List) {
//             imageUrls.assignAll(List<String>.from(cropData['imageUrl']));
//             debugPrint("Image URLs: ${imageUrls.value}"); // Debugging
//           } else {
//             debugPrint("Key 'imageUrl' not found or not a valid List in crop.");
//           }

// // Extract Care Instructions Data

//           if (cropData.containsKey('growthStages') &&
//               cropData['growthStages'] is List) {
//             List<dynamic> growthStages = cropData['growthStages'];

//             if (growthStages.isEmpty) {
//               debugPrint("No growth stages found in cropData.");
//             } else {
//               careInstructions.value = growthStages.map((stage) {
//                 return {
//                   "stage": stage["stage"] ?? "Unknown Stage",
//                   "temperature":
//                       stage["careInstructions"]?["temperature"] ?? "N/A",
//                   "soilType": stage["careInstructions"]?["soilType"] ?? "N/A",
//                   "watering": stage["careInstructions"]?["watering"] ?? "N/A",
//                   "sunlight": stage["careInstructions"]?["sunlight"] ?? "N/A",
//                   "fertilization":
//                       stage["careInstructions"]?["fertilization"] ?? "N/A",
//                 };
//               }).toList();

//               debugPrint("Extracted Care Instructions: ${careInstructions.value}");
//             }
//           } else {
//             debugPrint("growthStages key is missing or not a list.");
//           }

// // scientific name

//           if (cropData.containsKey('scientificName')) {
//             scientificName.value = cropData['scientificName'] ?? "";
//             debugPrint("Scientific Name: ${scientificName.value}"); // Debugging
//           } else {
//             debugPrint("Key 'scientificName' not found inside 'crop'.");
//           }

// // extract growing condition

//           if (cropData.containsKey('growing_conditions') &&
//               cropData['growing_conditions'] is Map) {
//             var growingData =
//                 cropData['growing_conditions'] as Map<String, dynamic>;
//             debugPrint("Growing Conditions Data: $growingData"); // Debugging step

//             growingCondition.assignAll({
//               "sunlight": growingData["sunlight"] ?? "",
//               "water": growingData["water"] ?? "",
//               "temperature": growingData["temperature"] ?? "",
//               "humidity": growingData["humidity"] ?? "",
//               "soilType": growingData["soilType"] ?? "",
//               "soilPH": growingData["soilPH"] ?? "",
//               "windResistance": growingData["windResistance"] ?? "",
//               "frostTolerance": growingData["frostTolerance"] ?? "",
//               "climateSuitability": growingData["climateSuitability"] is List
//                   ? List<Map<String, String>>.from(
//                       (growingData["climateSuitability"] as List)
//                           .map((climate) {
//                         if (climate is Map<String, dynamic>) {
//                           return {
//                             "region": climate["region"]?.toString() ?? "",
//                             "climate": climate["climate"]?.toString() ?? "",
//                           };
//                         }
//                         return {
//                           "region": "",
//                           "climate": ""
//                         }; // Fallback if data is incorrect
//                       }),
//                     )
//                   : [],
//             });

//             debugPrint("Updated Growing Conditions: ${growingCondition.value}");
//           } else {
//             debugPrint(
//                 "Key 'growing_conditions' not found or not a valid Map in cropData.");
//           }

// // Extract harvest information
//           if (cropData.containsKey('harvestInfo')) {
//             var harvestData = cropData['harvestInfo'];
//             debugPrint("Harvest Data: $harvestData"); // Debugging step
//             var economicData = harvestData.containsKey('economicAnalysis')
//                 ? harvestData['economicAnalysis']
//                 : {};
//             // Assign values properly
//             harvestInfo.value = {
//               "season": harvestData["season"] ?? "",
//               "yieldPerAcre": harvestData["yieldPerAcre"] ?? "",
//               "bestHarvestTime": harvestData["bestHarvestTime"] ?? "",
//               "method": harvestData["method"] ?? "",
//               "economicAnalysis": {
//                 "costOfCultivation": economicData["costOfCultivation"] ?? "",
//                 "expectedRevenue": economicData["expectedRevenue"] ?? "",
//                 "profitMargin": economicData["profitMargin"] ?? "",
//                 "ROI": economicData["ROI"] ?? "",
//               }
//             };

//             debugPrint("Updated Harvest Information: ${harvestInfo.value}");
//           } else {
//             debugPrint(
//                 "Key 'harvest' not found inside 'crop'. Available keys: ${cropData.keys}");
//           }
//           // Extract pests
//           if (cropData.containsKey('pests')) {
//             pests.assignAll(cropData['pests']);
//             debugPrint("Updated Pests Information: ${pests.value}");
//           } else {
//             debugPrint("Key 'pests' not found in 'crop'.");
//           }

//           // Extract diseases
//           if (cropData.containsKey('disease')) {
//             diseases.assignAll(cropData['disease']);
//             debugPrint("Updated Diseases Information: ${diseases.value}");
//           } else {
//             debugPrint("Key 'disease' not found in 'crop'.");
//           }

//           // **Extract Macronutrients Data**
//           if (cropData.containsKey('nutrientRequirements') &&
//               cropData['nutrientRequirements'] is Map) {
//             var nutrientData = cropData['nutrientRequirements'];

//             if (nutrientData.containsKey('macronutrients') &&
//                 nutrientData['macronutrients'] is Map) {
//               var macronutrientData = nutrientData['macronutrients'];

//               macronutrients.assignAll({
//                 "nitrogen": macronutrientData["nitrogen"] ?? "",
//                 "phosphorus": macronutrientData["phosphorus"] ?? "",
//                 "potassium": macronutrientData["potassium"] ?? "",
//               });

//               debugPrint("Updated Macronutrients: ${macronutrients.value}");
//             } else {
//               debugPrint(
//                   "Key 'macronutrients' not found in 'nutrientRequirements'.");
//             }
//           } else {
//             debugPrint("Key 'nutrientRequirements' not found in cropData.");
//           }

//           // ✅ Extract Traditional Uses Data
//           if (cropData.containsKey('traditionalUses')) {
//             var traditionalData = cropData['traditionalUses'];
//             debugPrint("Traditional Uses Data: $traditionalData"); // Debugging step

//             traditionalUses.assignAll({
//               "ayurveda": traditionalData["ayurveda"] ?? "",
//               "folkMedicine": traditionalData["folkMedicine"] ?? "",
//             });

//             // ✅ Extract Culinary Uses (List)
//             if (traditionalData.containsKey('culinaryUses') &&
//                 traditionalData['culinaryUses'] is List) {
//               culinaryUses.assignAll(
//                   List<String>.from(traditionalData['culinaryUses']));
//             }

//             debugPrint("Updated Traditional Uses: ${traditionalUses.value}");
//             debugPrint("Updated Culinary Uses: ${culinaryUses.value}");
//           } else {
//             debugPrint("Key 'traditionalUses' not found inside 'crop'.");
//           }

//             //  Extract Storage Data

//           if (cropData.containsKey('storage')) {
//             var storageData = cropData['storage'];
//             debugPrint("Storage Data from API: $storageData"); // Debugging

//             // Assign data to RxMap
//             storage.assignAll({
//               "shelfLife": storageData["shelfLife"] ?? "Not Available",
//               "bestStorageConditions":
//                   storageData["bestStorageConditions"] ?? "Not Available",
//             });

//             //  Assign storage innovations to RxList
//             if (storageData.containsKey('storageInnovations') &&
//                 storageData['storageInnovations'] is List) {
//               storageInnovations.assignAll(
//                   List<String>.from(storageData['storageInnovations']));
//             }

//             debugPrint("Final Storage Map: ${storage}"); // Debugging
//             debugPrint(
//                 "Final Storage Innovations List: ${storageInnovations}"); // Debugging

//             update(); //  Force UI to refresh
//           }

//           //  Extract Propagation Methods Data
//           if (cropData.containsKey('propagationMethods')) {
//             var propagationData = cropData['propagationMethods'];
//             debugPrint("Propagation Methods: $propagationData"); // Debugging step

//             propagationMethods.assignAll({
//               "seeds": propagationData["seeds"] ?? "",
//               "grafting": propagationData["grafting"] ?? "",
//               "air-layering": propagationData["air-layering"] ?? "",
//               "tissueCulture": propagationData["tissueCulture"] ?? "",
//             });
//           }

//           // ✅ Extract Pollination Data
//           if (cropData.containsKey('pollination')) {
//             var pollinationData = cropData['pollination'];
//             debugPrint("Pollination Data: $pollinationData"); // Debugging step

//             pollination.assignAll({
//               "type": pollinationData["type"] ?? "",
//               "floweringSeason": pollinationData["floweringSeason"] ?? "",
//               "importance": pollinationData["importance"] ?? "",
//               "pollinators": pollinationData["pollinators"] ?? [],
//             });
//           }

// // Extract Companion Plants Data

//           if (cropData.containsKey('companionPlants') &&
//               cropData['companionPlants'] is List) {
//             var companionData = cropData['companionPlants'];
//             debugPrint("Extracted Companion Plants: $companionData"); // Debugging

//             // Convert dynamic map values to strings safely
//             companionPlants.assignAll(
//                 List<Map<String, String>>.from(companionData.map((plant) => {
//                       "plant": plant["plant"].toString(),
//                       "benefit": plant["benefit"].toString(),
//                     })));

//             debugPrint(
//                 "Updated Companion Plants List: ${companionPlants}"); // Debugging
//           }

// // Extract Climate Change Adaptation Data
//           if (cropData.containsKey('climateChangeAdaptation')) {
//             var climateData = cropData['climateChangeAdaptation'];
//             debugPrint("Extracted Climate Data: $climateData");

//             climateChangeAdaptation.assignAll({
//               "floodResistance": climateData["floodResistance"] ?? "N/A",
//               "extremeHeatResistance":
//                   climateData["extremeHeatResistance"] ?? "N/A",
//               "stormProtection": climateData["stormProtection"] ?? "N/A",
//             });
//           }

// // Extract Genetic Varieties Data
// //   if (cropData.containsKey('geneticVarieties') && cropData['geneticVarieties'] is List) {
// //   var varieties = cropData['geneticVarieties'];
// //   debugPrint("Extracted Genetic Varieties: $varieties");

// //   geneticVarieties.assignAll(
// //     varieties.map<Map<String, String>>((variety) => {
// //       "variety": variety["variety"] ?? "",
// //       "characteristics": variety["characteristics"] ?? "",
// //     }).toList()
// //   );
// // }

//           if (cropData.containsKey('geneticVarieties') &&
//               cropData['geneticVarieties'] is List) {
//             var varieties = cropData['geneticVarieties'];

//             debugPrint("Extracted Genetic Varieties: $varieties"); // ✅ Debugging Log

//             geneticVarieties.assignAll(varieties
//                 .map<Map<String, String>>((variety) => {
//                       "variety": variety["variety"] ?? "",
//                       "characteristics": variety["characteristics"] ?? "",
//                     })
//                 .toList());

//             geneticVarieties.refresh(); // ✅ Force UI update if needed
//           }

//           debugPrint("Final Climate Data: $climateChangeAdaptation");
//           debugPrint("Final Genetic Varieties: $geneticVarieties");
//         } else {
//           debugPrint("Key 'crop' not found in response.");
//         }
//       } else {
//         debugPrint("Failed to fetch data. Status Code: ${response.statusCode}");
//       }
//     } catch (dioError) {
//       debugPrint("Dio Error fetching data: ${dioError.toString()}");
//     } catch (error) {
//       debugPrint("Unexpected Error fetching data: $error");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
