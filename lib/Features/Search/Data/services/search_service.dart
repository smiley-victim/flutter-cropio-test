// import 'dart:convert';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/Features/Search/Data/model/plant_info.dart';

// class SearchService {
//   static const String baseUrl = "https://beta-api.cropio.in/manage-crops/";

//   static const String token =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMjAyNjk3LCJpYXQiOjE3Mzk2MTA2OTcsImp0aSI6IjVkYzdlMGM5NDRlYzQ1ZDVhNTgxYmJkZTBmMjg1M2JjIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.0TeWZAW02nl8HQ_6lhlkBxAYhsJZR9NoDKvmn_uTEjc";

//   static const String _plantBox = 'allPlants';

//   /// Fetching plants with optional filters
//   static Future<List<PlantInfo>> fetchPlants(
//       {String? query, String? type}) async {
//     var box = await Hive.openBox<PlantInfo>(_plantBox);

//     if (box.isNotEmpty) {
//       debugPrint("Fetching plants from Hive..");
//       return _filterAndSortPlants(box.values.toList(), query, type);
//     }
//     // If Hive is empty, fetch from API
//     debugPrint("Fetching plants from API...");
//     try {
//       // Constructing query parameters based on filter
//       String requestUrl = baseUrl;

//       if (type != null && type != "All") {
//         requestUrl += "?filter=type&type=$type";
//       }

//       if (query != null && query.isNotEmpty) {
//         requestUrl += "${requestUrl.contains("?") ? "&" : "?"}search=$query";
//       }

//       final response = await http.get(
//         Uri.parse(requestUrl),
//         headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = jsonDecode(response.body);

//         if (jsonData.containsKey('crops')) {
//           List<PlantInfo> plants = (jsonData['crops'] as List)
//               .map((data) => PlantInfo.fromJson(data))
//               .toList();

//           // Save to Hive
//           await _savePlantsToHive(plants);

//            return _filterAndSortPlants(plants, query, type);

//           // Filterint plants name that start with the given query
//           // List<PlantInfo> filteredCrops = plants
//           //     .where((crop) =>
//           //         crop.plant.toLowerCase().contains(query?.toLowerCase() ?? ""))
//           //     .toList();

//           // // Sort alphabetically by plant name
//           // filteredCrops.sort(
//           //   (a, b) => a.plant.toLowerCase().compareTo(b.plant.toLowerCase()),
//           // );
//           // return filteredCrops;
//         } else {
//           throw Exception("Invalid API response: Missing 'crops' key");
//         }
//       } else {
//         debugPrint("Failed to load crops: ${response.reasonPhrase}");
//         return [];
//       }
//     } catch (e) {
//       debugPrint("Error fetching crops: $e");
//       return [];
//     }
//   }

//   /// Save fetched plants to Hive
//   static Future<void> _savePlantsToHive(List<PlantInfo> plants) async {
//     var box = await Hive.openBox<PlantInfo>(_plantBox);
//     await box.clear();
//     for (var plant in plants) {
//       await box.put(plant.plant, plant);
//     }
//   }

//   /// Retrieve and filter Hive data
//   static List<PlantInfo> _filterAndSortPlants(List<PlantInfo> plants, String? query, String? type) {
//     if (query != null && query.isNotEmpty) {
//       plants = plants.where((plant) => plant.plant.toLowerCase().contains(query.toLowerCase())).toList();
//     }
//     if (type != null && type != 'All') {
//       plants = plants.where((plant) => plant.plant.toLowerCase().contains(type.toLowerCase())).toList();
//     }
//     plants.sort((a, b) => a.plant.toLowerCase().compareTo(b.plant.toLowerCase()));
//     return plants;
//   }
// }



import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Features/Search/Data/model/plant_info.dart';

class SearchService {
  static const String baseUrl = "https://beta-api.cropio.in/manage-crops/";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzkzNTc5LCJpYXQiOjE3Mzk4MDE1NzksImp0aSI6ImFhMTI1N2QyZjU0OTQzNjViZThiOTcwMGU0ZWQ0YWQ4IiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.8t8CSE0q5PttQ8KDuQ_NVxHqHtBjzVD5ofA4wAZxZzc";

  static const String _plantBox = 'allPlants';

  /// Fetching plants with optional filters
  static Future<List<PlantInfo>> fetchPlants(
      {String? query, String? type}) async {
    var box = await Hive.openBox<PlantInfo>(_plantBox);

      // await box.delete(_plantBox);

    if (box.isNotEmpty) {
      debugPrint("Fetching plants from Hive..");
      return _filterAndSortPlants(box.values.toList(), query, type);
    }
    // If Hive is empty, fetch all plants from API
    debugPrint("Fetching all plants from API...");
    try {
      // Constructing request URL for fetching all plants
      String requestUrl = baseUrl; // No filters here

      final response = await http.get(
        Uri.parse(requestUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('crops')) {
          List<PlantInfo> plants = (jsonData['crops'] as List)
              .map((data) => PlantInfo.fromJson(data))
              .toList();

            debugPrint("debugPrinting All Plants from $plants");
          // Save all fetched plants to Hive (unfiltered)
          await _savePlantsToHive(plants);

          // Now apply filtering and sorting based on user input (query/type)
          return _filterAndSortPlants(plants, query, type);
        } else {
          throw Exception("Invalid API response: Missing 'crops' key");
        }
      } else {
        debugPrint("Failed to load crops: ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching crops: $e");
      return [];
    }
  }

  /// Save fetched plants to Hive (unfiltered)
  static Future<void> _savePlantsToHive(List<PlantInfo> plants) async {
    var box = await Hive.openBox<PlantInfo>(_plantBox);
      // Remove the existing data by the key associated with allPlants
    await box.delete(_plantBox);// Clear any existing data
    for (var plant in plants) {
      await box.put(plant.plant, plant); // Save the plant info by its plant name
    }
  }

  /// Retrieve and filter Hive data
  static List<PlantInfo> _filterAndSortPlants(
      List<PlantInfo> plants, String? query, String? type) {
    if (query != null && query.isNotEmpty) {
      plants = plants
          .where((plant) => plant.plant.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (type != null && type != 'All') {
      plants = plants
          .where((plant) => plant.type.toLowerCase().contains(type.toLowerCase()))
          .toList();
    }
    plants.sort((a, b) => a.plant.toLowerCase().compareTo(b.plant.toLowerCase()));
    return plants;
  }
}
