import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/all_plant_name_model.dart';

class FetchAllPlantName{
    static const String baseUrl = "https://beta-api.cropio.in/manage-crops/";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzkzNTc5LCJpYXQiOjE3Mzk4MDE1NzksImp0aSI6ImFhMTI1N2QyZjU0OTQzNjViZThiOTcwMGU0ZWQ0YWQ4IiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.8t8CSE0q5PttQ8KDuQ_NVxHqHtBjzVD5ofA4wAZxZzc";
  //fetch all plant name only
 static Future<List<String>> fetchingAllPlantName() async {


   var box = Hive.box('plantBox');

    List<String>? storedPlantNames = box.get('plantNames')?.cast<String>();

    if (storedPlantNames != null && storedPlantNames.isNotEmpty) {
      // debugPrint("Using plant names from Hive. $storedPlantNames");
      return storedPlantNames;
    }

 // Fetch from API if Hive is empty
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Convert JSON to Model
        List<String> fetchedPlantNames = AllPlantName.fromJson(jsonData).plantName;

        // Save to Hive
        await box.put('plantNames', fetchedPlantNames);

        debugPrint("Fetched from API and stored in Hive.");
        return fetchedPlantNames;
      } else {
        debugPrint("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return [];
    }
  }
}



class FetchPlantTypes{

      static const String baseUrl = "https://beta-api.cropio.in/crops/?find=type";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzkzNTc5LCJpYXQiOjE3Mzk4MDE1NzksImp0aSI6ImFhMTI1N2QyZjU0OTQzNjViZThiOTcwMGU0ZWQ0YWQ4IiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.8t8CSE0q5PttQ8KDuQ_NVxHqHtBjzVD5ofA4wAZxZzc";
  static Future<List<String>> fetchingPlantTypes() async {

   var box = Hive.box('plantBox');

    // Check if plant types are already stored in Hive
    List<String>? storedPlantTypes = box.get('plantTypes')?.cast<String>();
    if (storedPlantTypes != null && storedPlantTypes.isNotEmpty) {
      debugPrint("Using plant types from Hive: $storedPlantTypes");
      return storedPlantTypes;
    }

 // Fetch from API if Hive is empty
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

         debugPrint("FetchPlantTypesAPI Response: $jsonData");

        // Extract plant types
      List<String> fetchedPlantTypes = [];

      // Iterate over the 'types' field in the response
      for (var typeData in jsonData['types']) {
        String plantType = typeData['type'].toString();
        if (!fetchedPlantTypes.contains(plantType)) {
          fetchedPlantTypes.add(plantType); // Add unique plant types
        }
      }


       debugPrint(fetchedPlantTypes.toString()) ;

        // Save to Hive
        await box.put('plantTypes', fetchedPlantTypes);

        debugPrint("Fetched from API and stored in Hive.");
        return fetchedPlantTypes;
      } else {
        debugPrint("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return [];
    }
  }

}
