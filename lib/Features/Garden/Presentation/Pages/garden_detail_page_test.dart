import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlantDetailScreen extends StatefulWidget {
  final String plantId;

  const PlantDetailScreen({super.key, required this.plantId});

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  Map<String, dynamic>? plantData;
  bool isLoading = true;
  String? selectedGrowthStage;
  String? careInstructions;

  @override
  void initState() {
    super.initState();
    fetchPlantDetails();
  }

  Future<void> fetchPlantDetails() async {
    const String apiUrl = "https://beta-api.cropio.in/admin-panel/manage-crops/";
    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMjE4MTE0LCJpYXQiOjE3Mzk2MjYxMTQsImp0aSI6Ijg0YmE3NzA1ZmRmNTRmYzJhNDU5MjZiZTE3YmVlNGRjIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.cOp2cz1-kwRO44R-Ibcv0E8ALwsI3EhLVZnYYLc-OxM";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List crops = data['crops'];
      var selectedCrop =
          crops.firstWhere((crop) => crop['id'] == widget.plantId, orElse: () => {});

      if (selectedCrop.isNotEmpty) {
        if (mounted) {
          setState(() {
            plantData = selectedCrop;
            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  void updateCareInstructions(String selectedStage) {
    var growthStages = plantData?['growthStages'] ?? [];
    var stageData = growthStages.firstWhere(
      (stage) => stage['stage'] == selectedStage,
      orElse: () => {},
    );

    setState(() {
      selectedGrowthStage = selectedStage;
      careInstructions = stageData['careInstructions'] ?? "No specific care instructions available.";
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plant Image with Green Background Placeholder
                  Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: plantData!['imageUrl'] != null && plantData!['imageUrl'].isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              plantData!['imageUrl'][0],
                              width: size.width,
                              height: size.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "No Image Available",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),

                  const SizedBox(height: 16), // Space before Quick Info section

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Plant Name
                        Text(
                          plantData!['plant'] ?? 'Unknown Plant',
                          style: TextStyle(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Quick Information Section in Elevated Card
                        Card(
                          elevation: 5,
                          shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quick Information",
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                plantData!['growing_conditions'] != null
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            _infoRowWithIcon(Icons.water_drop, "Water Needs",
                                              plantData!['growing_conditions']['water']),
                                          const SizedBox(height: 4),
                                          _infoRowWithIcon(Icons.wb_sunny, "Light",
                                              plantData!['growing_conditions']['sunlight']),
                                          const SizedBox(height: 4),
                                          _infoRowWithIcon(Icons.thermostat, "Temperature",
                                              plantData!['growing_conditions']['temperature']),
                                          const SizedBox(height: 4),
                                          _infoRowWithIcon(Icons.water, "Humidity",
                                              plantData!['growing_conditions']['humidity']),
                                          const SizedBox(height: 4),
                                            _infoRowWithIcon(Icons.grass, "Soil Type",
                                              plantData!['growing_conditions']['soilType']),
                                        ],
                                      )
                                    : const Text("No information available"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                   Card(
  elevation: 5,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Growth Stages",
          style: TextStyle(
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        plantData!['growthStages'] != null
            ? Column(
                children: (plantData!['growthStages'] as List).map((stage) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTile(
                      title: Text(
                        stage['stage'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Duration: ${stage['duration']}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Care Instructions",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 6),
                              stage['careInstructions'] != null
                                  ? Column(
                                      children: (stage['careInstructions']
                                              as Map<String, dynamic>)
                                          .entries
                                          .map((entry) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 18),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  "${entry.key}: ${entry.value}",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : Text("No care instructions available"),
                              const SizedBox(height: 10),
                            
                            
                                    
                                 
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            : const Text("No growth stages available"),
      ],
    ),
  ),
),


                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Removed unused _infoRow method
}

Widget _infoRowWithIcon(IconData icon, String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.green, size: 18),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13)),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value ?? 'N/A',
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}