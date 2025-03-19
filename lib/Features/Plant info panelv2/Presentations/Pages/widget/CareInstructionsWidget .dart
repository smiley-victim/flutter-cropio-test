import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdata_model.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/controller/plant_controller.dart';

class CareInstructionsScreen extends StatefulWidget {
final PlantDataEntity plantData;
  const CareInstructionsScreen({super.key, required this.plantData});

  @override
  _CareInstructionsScreenState createState() => _CareInstructionsScreenState();
}

class _CareInstructionsScreenState extends State<CareInstructionsScreen> {
  // final PlantController plantController = Get.find<PlantController>();
  bool showAll = false; // Toggle state

  @override
  Widget build(BuildContext context) {
   
      if (widget.plantData.growthStages.isEmpty) {
        return Center(child: Text("No care instructions available"));
      }

      // Decide how many items to display
     int itemCount = showAll ? widget.plantData.growthStages.length : 1;


      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("🌱 Care Instructions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAll = !showAll; // Toggle view
                    });
                  },
                  child: Text(showAll ? "View Less" : "View All",
                      style: TextStyle(fontSize: 16, )),
                ),
              ],
             ),
          
            Container(
               width: double.infinity,
         //  height: MediaQuery.of(context).size.height * 0.8, // Constrained height
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true, // Makes ListView take only needed space
                    physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      var growthStage = widget.plantData.growthStages[index];

                      return Padding(
                        padding: const EdgeInsets.all( 10.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(growthStage.stage,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text("🌡️ Temperature - ${growthStage.careInstructions.target?.temperature ?? 'N/A'}"),
                                  SizedBox(height: 2),
                                Text("🪴 Soil Type - ${growthStage.careInstructions.target?.soilType ?? 'N/A'}"),
                              SizedBox(height: 2),
                                Text("💧 Watering - ${growthStage.careInstructions.target?.watering ?? 'N/A'}"),
                               SizedBox(height: 2),
                                Text("☀️ Sunlight - ${growthStage.careInstructions.target?.sunlight ?? 'N/A'}"),
                               SizedBox(height: 2), 
                                Text("🌱 Fertilization - ${growthStage.careInstructions.target?.fertilization ?? 'N/A'}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          
          ],
        ),
      );
    
  }
}
