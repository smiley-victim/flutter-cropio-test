import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_share/flutter_share.dart';

const String apiUrl = 'https://beta-api.cropio.in/manage-crops/';
const String bearerToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMjE4MTE0LCJpYXQiOjE3Mzk2MjYxMTQsImp0aSI6Ijg0YmE3NzA1ZmRmNTRmYzJhNDU5MjZiZTE3YmVlNGRjIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.cOp2cz1-kwRO44R-Ibcv0E8ALwsI3EhLVZnYYLc-OxM';

//This was the code to select the particular crop detail and send that info to the main class
//Just for testing purpose

class CropListScreen extends StatefulWidget {
  @override
  State<CropListScreen> createState() => _CropListScreenState();
}

class _CropListScreenState extends State<CropListScreen> {
  List<dynamic> crops = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCrops();
  }

  Future<void> fetchCrops() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $bearerToken'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          crops = data['crops'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load crops';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crops List')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: crops.length,
                  itemBuilder: (context, index) {
                    final crop = crops[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: crop['imageUrl'] != null &&
                                crop['imageUrl'].isNotEmpty
                            ? Image.network(crop['imageUrl'][0],
                                width: 50, height: 50, fit: BoxFit.cover)
                            : Icon(Icons.image, size: 50),
                        title: Text(crop['plant'] ?? 'Unknown Plant'),
                        subtitle: Text(crop['scientificName'] ??
                            'Unknown Scientific Name'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CropDetailScreen(crop: crop),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class CropDetailScreen extends StatelessWidget {
  final Map<String, dynamic> crop;

  const CropDetailScreen({super.key, required this.crop});

  // Future<void> shareCropDetails() async {
  //   await FlutterShare.share(
  //     title: 'Crop Details',
  //     text: 'Check out this plant: ${crop['plant']}\nScientific Name: ${crop['scientificName']}\nDescription: ${crop['description']}',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
          // IconButton(icon: Icon(Icons.share), onPressed: shareCropDetails),
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
                  if (crop['imageUrl'] != null && crop['imageUrl'].isNotEmpty)
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
                                  crop['imageUrl'][0]), // Show first image
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
                              "1/${crop['imageUrl'].length}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Text(
                    crop['plant'] ?? 'Not Available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    crop['scientificName'] ?? 'Not Available',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  _buildGrowingConditions(),
                  Divider(),
                  Text('About',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(crop['description'] ?? 'No description available',
                      style: TextStyle(fontSize: 14)),
                  Divider(),
                  Text('Care Guide',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                      crop['careInstructions'] ??
                          'No care instructions available',
                      style: TextStyle(fontSize: 14)),
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to My Garden")),
                  );
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
    final growingConditions = crop['growing_conditions'] ?? {};

    final conditions = [
      {
        'label': 'Sunlight',
        'value': growingConditions['sunlight'] ?? 'N/A',
        'icon': Icons.wb_sunny
      },
      {
        'label': 'Water',
        'value': growingConditions['water'] ?? 'N/A',
        'icon': Icons.water_drop
      },
      {
        'label': 'Temperature',
        'value': growingConditions['temperature'] ?? 'N/A',
        'icon': Icons.thermostat
      },
      {
        'label': 'Soil Type',
        'value': growingConditions['soilType'] ?? 'N/A',
        'icon': Icons.grass
      },
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: conditions.map((condition) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(condition['icon'], size: 40, color: Colors.green),
            SizedBox(height: 5),
            Text(condition['label'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(condition['value'],
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
