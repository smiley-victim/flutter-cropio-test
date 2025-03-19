import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:myapp/Features/Garden/Data/modala/garden_plants.dart';
// import 'package:myapp/Features/Garden/Presentation/Pages/garden_plant_detail_page.dart';
import 'package:http/http.dart' as http;
import 'garden_detail_page_test.dart';
// class MyGardenPage extends StatelessWidget {
//   const MyGardenPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final plants = [
//       {
//         'name': 'Monstera',
//         'image':
//             'https://images.pexels.com/photos/1072824/pexels-photo-1072824.jpeg'
//       },
//       {'name': 'Cactus', 'image': 'assets/cactus.jpg'},
//       {'name': 'Aloe Vera', 'image': 'assets/aloe.jpg'},
//       {'name': 'Snake Plant', 'image': 'assets/snake.jpg'},
//       {'name': 'Pothos', 'image': 'assets/pothos.jpg'},
//     ];
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(),
//                 const SizedBox(height: 24),
//                 GridView.count(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 16,
//                   childAspectRatio: 1,
//                   children: plants
//                       .map((plant) =>
//                           PlantCard(name: plant['name'], image: plant['image']))
//                       .toList(),
//                 ),
//                 const SizedBox(height: 32),
//                 _buildCareSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Your Garden',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   Widget _buildCareSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Care for your plants',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildCareCard(
//           'How to water your Monstera',
//           '1 min read',
//           Icons.water_drop,
//         ),
//         const SizedBox(height: 12),
//         _buildCareCard(
//           'Fertilizing schedule for Cactus',
//           '2 min read',
//           Icons.eco,
//         ),
//         const SizedBox(height: 12),
//         _buildCareCard(
//           'Pruning your Aloe Vera',
//           '3 min read',
//           Icons.cut,
//         ),
//       ],
//     );
//   }

//   Widget _buildCareCard(String title, String readTime, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade200),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   readTime,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PlantCard extends StatelessWidget {
//   final String? name, image;
//   const PlantCard({super.key, required this.name, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(75),
//             child: InkWell(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       PlantDetailPage(plant: monstera,),
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 214, 250, 210),
//                 ),
//                 // child: Image.network(
//                 //   plant['image']!,
//                 //   fit: BoxFit.cover,
//                 // ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           name!,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

//// due of rapid and unintendent changes =======

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  String apiUrl = "https://beta-api.cropio.in/admin-panel/manage-crops/";
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMjE4MTE0LCJpYXQiOjE3Mzk2MjYxMTQsImp0aSI6Ijg0YmE3NzA1ZmRmNTRmYzJhNDU5MjZiZTE3YmVlNGRjIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.cOp2cz1-kwRO44R-Ibcv0E8ALwsI3EhLVZnYYLc-OxM";

  List<Map<String, String>> allCrops = [];
  List<Map<String, String>> displayedCrops = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<dynamic> crops = jsonResponse["crops"] ?? [];

        List<Map<String, String>> data = crops.map((crop) {
          return {
            "id": crop["id"].toString(),
            "name": crop["plant"].toString(),
            "imageUrl": crop["imageUrl"].toString(),
            "hover": "false"
          };
        }).toList();

        setState(() {
          allCrops = data;
          displayedCrops = allCrops.take(5).toList();
        });
      }
    } catch (error) {
      setState(() {
        displayedCrops = [
          {"name": "Request failed: $error", "imageUrl": ""}
        ];
      });
    }
  }

  void filterSearchResults(String query) {
    List<Map<String, String>> searchResults = [];
    if (query.isEmpty) {
      searchResults = allCrops.take(5).toList();
    } else {
      searchResults = allCrops
          .where((crop) =>
              crop["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      displayedCrops = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final crossAxisCount = (screenWidth ~/ 150)
        .clamp(2, 4); // Dynamic column count based on screen width

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              children: [
                Text(
                  "Your Garden",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.06,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: TextField(
              controller: searchController,
              onChanged: filterSearchResults,
              decoration: InputDecoration(
                hintText: "Search plant...",
                prefixIcon: Icon(Icons.search, size: 20),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: screenHeight * 0.02), // Added SizedBox for spacing
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              itemCount: displayedCrops.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing:
                    screenWidth * 0.08, // Increased cross axis spacing
                mainAxisSpacing:
                    screenHeight * 0.02, // Increased main axis spacing
                childAspectRatio:
                    0.8, // Adjusted aspect ratio to reduce card size
              ),
              itemBuilder: (context, index) {
                if (index < displayedCrops.length) {
                  return MouseRegion(
                    onEnter: (_) =>
                        setState(() => displayedCrops[index]["hover"] = "true"),
                    onExit: (_) => setState(
                        () => displayedCrops[index]["hover"] = "false"),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantDetailScreen(
                              plantId: displayedCrops[index]["id"]!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio:
                                1, // Ensures the image is always a square
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(251, 210, 255, 214),
                                borderRadius: BorderRadius.circular(
                                    55), // Reduced border radius
                                boxShadow:
                                    displayedCrops[index]["hover"] == "true"
                                        ? [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 10,
                                                spreadRadius: 2)
                                          ]
                                        : [],
                                image: displayedCrops[index]["imageUrl"]!
                                        .isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            displayedCrops[index]["imageUrl"]!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  4), // Reduced space between image and text
                          Flexible(
                            child: Text(
                              displayedCrops[index]["name"]!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Placeholder()),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                            height: 4), // Reduced space between image and text
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  69), // Reduced border radius
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child:
                                Icon(Icons.add, size: 24, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                            height: 4), // Reduced space between image and text
                        Flexible(
                          child: Text(
                            "Add New Plant",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20), // Added empty footer space
        ],
      ),
    );
  }
}
