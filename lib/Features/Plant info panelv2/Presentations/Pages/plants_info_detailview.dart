import 'package:flutter/material.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/Pages/widget/GrowthStagesTimeline.dart';


import 'widget/CareInstructionsWidget .dart';
import 'widget/HarvestAndDisease.dart';
import 'widget/ImgSlider.dart';
import 'widget/StorageAndPropagation.dart';

class PlantsInfoDetailview extends StatefulWidget {
  final PlantDataEntity plantData; 
  
  

  const PlantsInfoDetailview({
    super.key,
   
    required this.plantData   
  });

  @override
  State<PlantsInfoDetailview> createState() => _PlantsInfoDetailviewState();
}

class _PlantsInfoDetailviewState extends State<PlantsInfoDetailview> {
  bool isExpanded = false;

  //final PlantController plantController = Get.find();
  
  @override
  Widget build(BuildContext context) {

     // Check if dark mode is enabled
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Refined color palette
    // final primaryColor = isDarkMode ? Colors.green[300] : Colors.green[700];
    // final primaryColorLight =
    //     isDarkMode ? Colors.green[100] : Colors.green[50]; // Lighter shade
    // final cardColor = isDarkMode
    //     ? Colors.grey[850]
    //     : Colors.white; // Slightly darker card in dark mode
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtleTextColor =
        textColor.withValues(alpha: 0.7); // For less prominent text

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Navigation
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 250, 250),
                        padding: const EdgeInsets.all(2),
                        minimumSize: Size(35, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadowColor: Colors.black45,
                        elevation: 5,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.bookmark_border, size: 20),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  SizedBox(height: 10),
                  buildImageSlider(widget.plantData),
                ],
              ),

              // Plant Title and Description
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //widget.selectedPlant?.plant ?? '',
                     widget.plantData.plant,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                              // plantController.scientificName.value,
//                              widget.plantData.scientificName,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.grey[800],
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),

//  Expanded(
  
//    child: Row(
//      children:[ Flexible(
//        child: _buildSeasonalityIndicator(widget
//                                       .plantData.harvestInfo.target?.season ??
//                                   'N/A'),
//      ),]
//    ),
//  ),

//                         ],
//                       ),
                    
                    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    /// Wrapping the scientific name inside Expanded to avoid overflow
    Flexible(
      child: Text(
        widget.plantData.scientificName,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[800],
          fontStyle: FontStyle.italic,
        ),
        overflow: TextOverflow.ellipsis, // Prevents overflow with "..."
        maxLines: 2, // Allows wrapping to two lines
        softWrap: true, // Ensures text wraps properly
      ),
    ),

    /// Wrapping the Seasonality Indicator inside Expanded
    Flexible(
      child: _buildSeasonalityIndicator(
        widget.plantData.harvestInfo.target?.season ?? 'N/A',
      ),
    ),
  ],
),

                      SizedBox(height: 10),
                     Container(
                      decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                          'Type: ${widget.plantData.type} | Class: ${widget.plantData.plantClass}', // Use plantData.type and plantData.plantClass
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: subtleTextColor), // titleSmall for type/class
                                             ),
                       ),
                     ),
                     SizedBox(height: 8),
                    Text(
                      widget.plantData.description == null
                       ? "Philodendron is a large genus of flowering plants in the family Araceae. As of September 2015, the World Checklist of Selected Plant Families accepted 489 species; other sources accept"
                          : widget.plantData!.description,
                     // widget.selectedPlant == null
                          // ? "Philodendron is a large genus of flowering plants in the family Araceae. As of September 2015, the World Checklist of Selected Plant Families accepted 489 species; other sources accept"
                          // : widget.selectedPlant!.description,
                      style: TextStyle(
                          color: Colors.grey[800], height: 1.5, fontSize: 16),
                      maxLines: isExpanded ? null : 5,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isExpanded =
                                !isExpanded; // Toggle the expanded state
                          });
                        },
                        child: const Text('Read more'),
                      ),
                    ),
                  ],
                ),
              ),

              // Growth Stages

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 300,
                  child: GrowthStagesTimeline(
                    //plantId: widget.selectedPlant?.id ?? "",
                   plantData: widget.plantData,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text("🌾 Growing Condition",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),

// Growing Condition
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2, // Two cards per row
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 1.5,
                          children: [
                            _buildInfoCard(
                                Icons.wb_sunny,
                                "Sunlight",
                               // plantController.growingCondition["sunlight"] ?? ""
                                   widget.plantData.growingConditions.target?.sunlight ?? ""
                                    
                                    ),
                            _buildInfoCard(
                                Icons.water_drop,
                                "Water",
                                widget.plantData.growingConditions.target?.water ?? ""
                                    
                                    
                                    ),
                            _buildInfoCard(
                                Icons.thermostat,
                                "Temperature",
                                // plantController
                                //         .growingCondition["temperature"] ??""
                                            widget.plantData.growingConditions.target?.temperature ?? ""
                                    
                                        ),
                            _buildInfoCard(
                                Icons.cloud,
                                "Humidity",
                                //plantController.growingCondition["humidity"] ??""
                                    widget.plantData.growingConditions.target?.humidity ?? ""
                                    
                                ),
                          ],
                        )),
                  ),
                ),
              

// Nutrient Requirements
              HarvestAndDisease(plantData: widget.plantData,
               

                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CareInstructionsScreen(
                    // plantId: widget.selectedPlant?.id ?? ""
                      plantData: widget.plantData,
                    ),
              ),

              Storageandpropagation(
                // plantId: widget.selectedPlant?.id ?? ""
                  plantData: widget.plantData,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 1.5, // Ensures a square shape
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon,
                  size: 30, color: Colors.black87), // Increased icon size
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                value.isNotEmpty ? value : "Not Available",
                style: TextStyle(color: Colors.black54, fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Prevents overflow
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


 Widget _buildSeasonalityIndicator(String season) {
    Color seasonColor;
    IconData seasonIcon;

    if (season.toLowerCase().contains('summer')) {
      seasonColor = Colors.orange[600]!; // More vibrant orange
      seasonIcon = Icons.wb_sunny;
    } // ... (rest of seasonality indicator logic - no changes needed) ...
    else if (season.toLowerCase().contains('winter')) {
      seasonColor = Colors.blue[600]!;
      seasonIcon = Icons.ac_unit;
    } else if (season.toLowerCase().contains('monsoon') ||
        season.toLowerCase().contains('rainy')) {
      seasonColor = Colors.lightBlue[600]!;
      seasonIcon = Icons.water_drop;
    } else if (season.toLowerCase().contains('spring')) {
      seasonColor = Colors.green[600]!;
      seasonIcon = Icons.local_florist;
    } else if (season.toLowerCase().contains('autumn') ||
        season.toLowerCase().contains('fall')) {
      seasonColor = Colors.deepOrange[600]!;
      seasonIcon = Icons.event_available;
    } else {
      seasonColor = Colors.grey[600]!;
      seasonIcon = Icons.event;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 5), // Adjusted padding
      decoration: BoxDecoration(
        color:
            seasonColor.withValues(alpha: 0.15), // Slightly darker background
        borderRadius: BorderRadius.circular(20), // More rounded corners
        border: Border.all(
            color:
                seasonColor.withValues(alpha: 0.6)), // Slightly darker border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(seasonIcon,
              size: 18, color: seasonColor), // Slightly larger icon
          const SizedBox(width: 6), // Adjusted spacing
          Text(
            season,
            style: TextStyle(
                color: seasonColor,
                fontWeight: FontWeight.w600), // Slightly bolder text
          ),
        ],
      ),
    );
  }

 