


//  final String token =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzk1ODcyLCJpYXQiOjE3Mzk4MDM4NzIsImp0aSI6ImI1YzJmYmYwODg3MTQxNzhhZDc2MGFmZGQ5YmJmZjAzIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.CBf7zvQU3O3BW3JgMH9kitBRsgmDmzfDMIf4sVQXVz8";

import 'dart:convert';
import 'package:dio/dio.dart';

class PlantApi {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchPlantDetails(String plantId) async {
    try {
      Response response = await _dio.get(
        'https://yourapi.com/plants/$plantId',
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzk1ODcyLCJpYXQiOjE3Mzk4MDM4NzIsImp0aSI6ImI1YzJmYmYwODg3MTQxNzhhZDc2MGFmZGQ5YmJmZjAzIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.CBf7zvQU3O3BW3JgMH9kitBRsgmDmzfDMIf4sVQXVz8",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Plant Details: ${jsonEncode(response.data)}"); 
        return response.data; 
        
       // Returns the parsed JSON data
      } else {
        throw Exception('Failed to load plant details');
      }
    } catch (e) {
      print("Error fetching plant details: $e");
      throw Exception('Failed to load plant details');
    }
  }
}
