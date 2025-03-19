import 'package:dotted_border/dotted_border.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Features/AI%20chat%20interaction/Presentation/Pages/ai_home_page.dart';
import 'package:myapp/Features/Calculator/screen/fertilizer_calculator_screen.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import 'package:myapp/Features/Home/Presentation/Widgets/app_drawer.dart';
import 'package:myapp/Features/Maps/Presentation/Pages/map.dart';
import 'package:myapp/Features/Reminder/Presentation/Pages/reminder.dart';

import '../../../GardenV2/Data/DataSource/dataservice.dart';
import '../../../GardenV2/Presentation/Pages/gradenlist_page.dart';
import '../Widgets/home_garden_card.dart'; 

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, String>> allCrops = [];
  List<Map<String, String>> displayedCrops = [];

  // Temperature data
  int temperature = 14;

  // Plant data for My Garden section
  List<PlantDataEntity> plantList =
      MyDataService().getAllPlantData(); // Fetch plant data here

  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
  }

  String getSprayingCondition() {
    if (temperature < 15) {
      return "Low";
    } else if (temperature <= 30) {
      return "Moderate";
    } else {
      return "High";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Builder(builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/logo.png'),
                  child: const Icon(
                    Icons.grass,
                    color: Colors.green,
                  ),
                ),
              );
            }),
            const SizedBox(width: 8),
            const Text("Cropio", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReminderScreen())),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 240, 238, 247),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _weatherCard(),
            const SizedBox(height: 24),
            _sprayingConditionCard(),
            const SizedBox(height: 24),
            _myGardenSection(),
            const SizedBox(height: 16),
            _smartToolsSection(),
            const SizedBox(height: 16),
            FieldManagementScreen(),
            const SizedBox(height: 16),
            _recentScansSection(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AIHomePage(),
          ),
        ),
        elevation: 10,
        shape: CircleBorder(),
        child: Icon(Icons.smart_toy, color: Colors.black),
      ),
    );
  }

  Widget _weatherCard() {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$temperature°C",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Icon(LucideIcons.cloudSun, size: 30),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Partly Cloudy",
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: _weatherDetailCard(
                        LucideIcons.droplet, "Humidity", "65%")),
                SizedBox(width: 8),
                Expanded(
                    child: _weatherDetailCard(
                        LucideIcons.wind, "Wind", "12 km/h")),
                SizedBox(width: 8),
                Expanded(
                    child: _weatherDetailCard(
                        LucideIcons.sun, "UV Index", "Medium")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherDetailCard(IconData icon, String label, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Text(value,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _sprayingConditionCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(LucideIcons.sprayCan,
              size: 28, color: const Color.fromARGB(255, 1, 3, 3)),
          const SizedBox(width: 8),
          Text(
            "Spraying Condition: ${getSprayingCondition()}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _myGardenSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Garden",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlantListPage()),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Horizontal scrollable list of garden items using DashboardPlantCard
        plantList.isNotEmpty
            ? SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: plantList.length,
                  itemBuilder: (context, index) {
                    final plant = plantList[index]; // Get PlantDataEntity
                    return DashboardPlantCard(
                        plant: plant); // Use DashboardPlantCard
                  },
                ),
              )
            : buildEmptyGardenPlaceholder(context)
      ],
    );
  }

  Widget _smartToolsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Smart Tools",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // Using GridView.builder with SliverGridDelegateWithMaxCrossAxisExtent for responsiveness
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                200, // Max width for each item, adjust as needed
            childAspectRatio: 1.5, // You can still control the aspect ratio
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 4, // Number of SmartToolItem widgets
          itemBuilder: (context, index) {
            // Rebuild SmartToolItem widgets here based on index
            if (index == 0) {
              return SmartToolItem(
                label: "Fertilizer Calculator",
                icon: LucideIcons.calculator,
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FertilizerCalculatorScreen()),
                  )
                },
              );
            } else if (index == 1) {
              return SmartToolItem(
                  label: "Area Calculator",
                  icon: LucideIcons.map,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(),
                        ),
                      ));
            } else if (index == 2) {
              return SmartToolItem(
                label: "Crop Planning",
                icon: Icons.trending_up,
                onTap: () {},
              );
            } else if (index == 3) {
              return SmartToolItem(
                  label: "Reminder",
                  icon: LucideIcons.bell,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReminderScreen())));
            }
            return const SizedBox
                .shrink(); // Fallback, should not reach here in this example
          },
        ),
      ],
    );
  }

  Widget _recentScansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Recent Scans",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        RecentScanItem(title: "Leaf Analysis", time: "2 hours ago"),
        RecentScanItem(title: "Soil Test", time: "Yesterday"),
      ],
    );
  }
}

class RecentScanItem extends StatelessWidget {
  final String title;
  final String time;

  const RecentScanItem({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://via.placeholder.com/100',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox();
              },
            ),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(time, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class SmartToolItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const SmartToolItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 30),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      label,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget FieldManagementScreen() {
  return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Manage your field",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // FieldCard(
              //   cropName: "Wheat",
              //   cropIcon: "🌾",
              //   area: "2.5 acres",
              //   location: "Nearby",
              //   mapImageUrl: "https://via.placeholder.com/100",
              // ),
              // SizedBox(width: 16),
              FieldCard(
                cropName: "Rice",
                cropIcon: "🌾",
                area: "1.5 acres",
                location: "puri",
                mapImageUrl: "https://via.placeholder.com/100",
              ),
              SizedBox(width: 16),
              AddFieldCard(),
            ],
          ),
        ),
      ]));
}

Widget FieldCard({
  required String cropName,
  required String cropIcon,
  required String area,
  required String location,
  required String mapImageUrl,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
        //  padding: EdgeInsets.all(10),
        width: 310,
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My field", style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Text(cropIcon, style: TextStyle(fontSize: 20)),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cropName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text(area,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 40),

                    // Load Image with Error Handling
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            mapImageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image loaded successfully
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                  // Show loader while loading
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  // Placeholder background
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(Icons.location_disabled,
                                      size: 30, color: Colors.grey[700]),
                                  // Fallback icon
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(location,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
              ]),
        )),
  );
}

Widget AddFieldCard() {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: Radius.circular(12),
    dashPattern: [6, 3], // Adjust for different dot styles
    color: const Color.fromARGB(255, 64, 132, 1),
    strokeWidth: 2,
    child: Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add,
                color: const Color.fromARGB(255, 64, 132, 1), size: 28),
            SizedBox(height: 4),
            Text("Add field",
                style: TextStyle(
                    color: const Color.fromARGB(255, 64, 132, 1),
                    fontSize: 14)),
          ],
        ),
      ),
    ),
  );
}
