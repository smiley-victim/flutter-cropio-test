import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Features/Search/Data/model/plant_info.dart';

class SearchService {
  static const String apiUrl =
      "https://beta-api.cropio.in/admin-panel/crop-dictionary/";
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMjAyNjk3LCJpYXQiOjE3Mzk2MTA2OTcsImp0aSI6IjVkYzdlMGM5NDRlYzQ1ZDVhNTgxYmJkZTBmMjg1M2JjIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.0TeWZAW02nl8HQ_6lhlkBxAYhsJZR9NoDKvmn_uTEjc";

  /// Fetch crops from API
  static Future<List<PlantInfo>> fetchCrops() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token", 
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((data) => PlantInfo.fromJson(data)).toList();
      } else {
        throw Exception("Failed to load crops: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching crops: $e");
      return [];
    }
  }

  /// Perform search with alphabetical sorting
  static List<PlantInfo> searchCrops(String query, List<PlantInfo> allCrops) {
    if (query.isEmpty) return allCrops;

    List<PlantInfo> filteredCrops = allCrops
        .where((crop) => crop.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    filteredCrops
        .sort((a, b) => a.name.compareTo(b.name)); // Sort alphabetically
    return filteredCrops;
  }
}
