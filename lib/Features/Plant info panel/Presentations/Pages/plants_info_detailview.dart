// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myapp/Core/Get_it/get_it.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';
import '../../../GardenV2/Data/DataSource/dataservice.dart';
import '../../../GardenV2/Data/Models/plantdata_model.dart';


class CropDetailScreen extends StatelessWidget {
  final PlantInfo crop;
  final MyDataService _store = servicelocator<MyDataService>();
  CropDetailScreen({super.key, required this.crop});

  // Future<void> shareCropDetails() async {
  //   await FlutterShare.share(
  //     title: 'Crop Details',
  //     text:
  //         'Check out this plant: ${crop['plant']}\nScientific Name: ${crop['scientificName']}\nDescription: ${crop['description']}',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                /// TODO:share logic
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (crop.imageUrl.isNotEmpty)
                    Stack(
                      children: [
                        // Full-width Image
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                  crop.imageUrl[0]), // Show first image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Image count indicator
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "1/${crop.imageUrl.length}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Text(
                    crop.plant.isEmpty ? 'Not Available' : crop.plant,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    crop.scientificName.isEmpty
                        ? 'Not Available'
                        : crop.scientificName.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  _buildGrowingConditions(),
                  Divider(),
                  Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      crop.description.isEmpty
                          ? 'No description available'
                          : crop.description,
                      style: TextStyle(fontSize: 14),
                      textAlign:
                          TextAlign.justify, // Ensures even text alignment
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Text('Care Guide',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  _careGuideItem(
                      Icons.wb_sunny,
                      "Sunlight",
                      crop.careInfo.light.isNotEmpty
                          ? crop.careInfo.light
                          : "Not Available"),
                  _careGuideItem(
                      Icons.water_drop,
                      "Watering",
                      crop.careInfo.waterNeeds.isNotEmpty
                          ? crop.careInfo.waterNeeds
                          : "Not Available"),
                  _careGuideItem(
                      Icons.thermostat,
                      "Temperature",
                      crop.careInfo.temperature.isNotEmpty
                          ? crop.careInfo.temperature
                          : "Not Available"),
                  Divider(),
                  SizedBox(height: 20),
                  Text("Benefits & Uses",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _benefitCard("Medicinal", "Helps in wound healing"),
                      _benefitCard("Cosmetic", "Skin care benefits"),
                      _benefitCard("Indoor Air", "Air purifying"),
                      _benefitCard("Chemical", "Anti-inflammatory"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Seasonal Care",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  _careGuideItem(Icons.wb_sunny, "Summer",
                      "Increase watering frequency; protect from intense afternoon sun"),
                  _careGuideItem(Icons.ac_unit, "Winter",
                      "Reduce watering frequency; keep in a warm area"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to My Garden")),
                  );
                  final data = await fetchPlantDetails(crop.id);

                  debugPrint(
                      "CropDetailScreen - Plant Name from PlantInfo crop: ${crop.plant}");
                  debugPrint(
                      "CropDetailScreen - Data from fetchPlantDetails: $data");

                  if (data == null) {
                    debugPrint(
                        "CropDetailScreen - ERROR: data from fetchPlantDetails is NULL (API call failed?)"); // Specific error log
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Failed to add to My Garden. API call error.")),
                    );
                  } else if (data['crop'] == null) {
                    debugPrint(
                        "CropDetailScreen - ERROR: data['crop'] is NULL (API response structure issue?)"); // Specific error log
                    debugPrint(
                        "CropDetailScreen - Full Data Received: $data"); // Print the full data to inspect
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Failed to add to My Garden. 'crop' data missing in response.")),
                    );
                  } else if (data['crop'] is! Map<String, dynamic>) {
                    debugPrint(
                        "CropDetailScreen - ERROR: data['crop'] is NOT a Map<String, dynamic> (Unexpected data type)"); // Type error log
                    debugPrint(
                        "CropDetailScreen - Type of data['crop']: ${data['crop'].runtimeType}"); // Print the actual type
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Failed to add to My Garden. Unexpected data format.")),
                    );
                  } else {
                    final cropData = data['crop'] as Map<String, dynamic>;
                    debugPrint(
                        "CropDetailScreen - Crop Data extracted: $cropData");
                    _store.addPlantData(PlantData.fromJson(cropData));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white),
                    SizedBox(width: 5),
                    Text("Add to Garden"),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.notifications_outlined,
                  color: Colors.black54, size: 28),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Notifications Clicked")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowingConditions() {
    final growingConditions = crop.careInfo;

    final conditions = [
      {
        'label': 'Sunlight',
        'value': growingConditions.light.isNotEmpty
            ? growingConditions.light.toString()
            : 'N/A',
        'icon': Icons.wb_sunny
      },
      {
        'label': 'Water',
        'value': growingConditions.waterNeeds.isNotEmpty
            ? growingConditions.waterNeeds.toString()
            : 'N/A',
        'icon': Icons.water_drop
      },
      {
        'label': 'Temperature',
        'value': growingConditions.temperature.isNotEmpty
            ? growingConditions.temperature.toString()
            : 'N/A',
        'icon': Icons.thermostat
      },
      {
        'label': 'Max Height',
        'value': growingConditions.maxHeight.isNotEmpty
            ? growingConditions.maxHeight.toString()
            : 'N/A',
        'icon': Icons.scale
      },
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: conditions.map((condition) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(condition['icon'] as IconData?, size: 20),
            SizedBox(height: 5),
            Text(condition['label'] as String,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(condition['value'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          ],
        );
      }).toList(),
    );
  }
}

Widget _benefitCard(String title, String description) {
  return SizedBox(
    width: 170,
    height: 90, // Ensures equal width
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(description, style: TextStyle(color: Colors.black54)),
        ],
      ),
    ),
  );
}

Widget _careGuideItem(IconData icon, String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.black54),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(description, style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}
