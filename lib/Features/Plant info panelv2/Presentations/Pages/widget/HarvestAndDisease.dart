import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import '../../controller/plant_controller.dart';


class HarvestAndDisease extends StatelessWidget {
//  final PlantController plantController = Get.find();
// final String plantId;
 final PlantDataEntity plantData; 

   HarvestAndDisease({super.key, required this.plantData, }); 

  @override
  Widget build(BuildContext context) {
     // plantController.fetchGrowthStages(plantId);

    // if (plantData.harvestInfo.isEmpty  && plantData.pests.isEmpty) {
    //     return Center(child: Text("No pests and harvest found."));
    //   } 

    return   Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


 SizedBox(height: 10),
                      Text("🍀 Nutrient Requirements", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              Container(
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                Card(
                          child: ListTile(
                            leading: Icon(Icons.grass, color: Colors.green),
                            title: Text("Nitrogen"),
                            subtitle: Text(
                              //plantController.macronutrients["nitrogen"] ?? "",),
                         plantData.nutrientRequirements.target?.macronutrients.target?.nitrogen ?? "N/A" ),
                          ),
                        ),
                
                       Card(
                          child: ListTile(
                            leading: Icon(Icons.eco, color: Colors.orange),
                            title: Text("Phosphorus"),
                            subtitle: Text(
                             // plantController.macronutrients["phosphorus"] ?? "",
                              plantData.nutrientRequirements.target?.macronutrients.target?.phosphorus ?? "N/A" 
                              )
                          ),
                        ),

                       Card(
                          child: ListTile(
                            leading: Icon(Icons.energy_savings_leaf, color: Colors.blue),
                            title: Text("Potassium"),
                            subtitle: Text(
                             // plantController.macronutrients["potassium"] ?? "",
                              plantData.nutrientRequirements.target?.macronutrients.target?.potassium ?? "N/A" 
                              )
                          ),
                        ),
                ],
              ),
            ),
              ),

  SizedBox(height: 20),

           Text("🐛 Pests & Diseases", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

              
                      Column(
              //  children: plantController.pests.map((pest) {
                  children: plantData.pests.map((pest) {
              return Card(
                color: Colors.grey.shade100,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pest.name, style: TextStyle(fontSize: 16,color: Colors.black , fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Symptoms - ${pest.symptoms.join(", ")}", style: TextStyle(color: Colors.black87,fontSize: 14,)),
                      SizedBox(height: 4),
                      Text("Control Methods - ${pest.controlMethods.join(", ")}", style: TextStyle(color: Colors.black87,fontSize: 14,)),
                       SizedBox(height: 4),
                      Text("Biological Control - ${pest.biologicalControl}", style: TextStyle(color: Colors.black87,fontSize: 14,)),
                    ],
                  ),
                ),
              );
                }).toList(),
                      ),

              Text("🦠 Diseases", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              
               Column(
               // children: plantController.diseases.map((disease) {
              children: plantData.disease.map((disease) {
              return Card(
                color: Colors.grey.shade100,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(disease.name, style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold )),
                      SizedBox(height: 4),
                      Text("Symptoms - ${disease.symptoms.join(", ")}", style: TextStyle(color: Colors.black87)),
                      Text("Remedy - ${disease.remedy.join(", ")}", style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              );
                }).toList(),
              ),
              
                  
                  
                 ]),
             
              )
                   
              ), 
           
           
           
            //         ],
            //       ),
            // ),

             

          SizedBox(height: 20),
                      Text("🌾 Harvest Information", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              Container(
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                Card(
                color: Colors.grey.shade100,
                          child: ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text("Season"),
                            subtitle: Text(
                              // plantController.harvestInfo["season"]?? ""
                              plantData.harvestInfo.target?.season ?? "N/A"
                              ),
                          ),
                        ),
                
                        Card(
                          color: Colors.grey.shade100,
                          child: ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text("Yield"),
                            subtitle: Text(
                             // plantController.harvestInfo["yieldPerAcre"] ?? ""
                              plantData.harvestInfo.target?.yieldPerAcre ?? "N/A"
                              ),
                          ),
                        ),

                       Card(
                          color: Colors.grey.shade100,
                          child: ListTile(
                            leading: Icon(Icons.watch_later),
                            title: Text("Best Harvest Time"),
                            subtitle: Text(
                              //plantController.harvestInfo["bestHarvestTime"] ?? ""
                              plantData.harvestInfo.target?.bestHarvestTime ?? "N/A"
                              ),
                          ),
                        ),

                          Card(
                          color: Colors.grey.shade100,
                          child: ListTile(
                            leading: Icon(Icons.device_hub),
                            title: Text("Method"),
                            subtitle: Text(
                             // plantController.harvestInfo["method"] ?? ""
                              plantData.harvestInfo.target?.method ?? "N/A"
                              ),
                          ),),
                                                  


                    
                    SizedBox(height: 10,),
                    Container(
                       width: double.infinity,
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
             padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text("📊  Economic Analysis  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                             SizedBox(height: 8,),
                            Text("• Cost of Cultivation: ${
                             // plantController.harvestInfo.value["economicAnalysis"]["costOfCultivation"]
                              plantData.harvestInfo.target?.economicAnalysis.target?.costOfCultivation ?? "N/A"
                              }",
                              
                               style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4,),
                            Text("• Expected Revenue: ${
                             // plantController.harvestInfo.value["economicAnalysis"]["expectedRevenue"]
                               plantData.harvestInfo.target?.economicAnalysis.target?.expectedRevenue ?? "N/A"
                              }", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4,),
                            Text("• Profit Margin: ${
                             // plantController.harvestInfo.value["economicAnalysis"]["profitMargin"]
                               plantData.harvestInfo.target?.economicAnalysis.target?.profitMargin ?? "N/A"
                              }", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 4,),
                            Text("• ROI: ${
                              
                             // plantController.harvestInfo.value["economicAnalysis"]["ROI"]
                               plantData.harvestInfo.target?.economicAnalysis.target?.roi ?? "N/A"
                              }", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                    ),
              
                ],
              ),
            ),
              ),

SizedBox(height: 10,),


 Padding(
   padding: const EdgeInsets.symmetric(horizontal: 10.0),
   child: Text("⚒️ Traditional Uses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold )),
 ),
  SizedBox(height: 10,),
// Ayurveda & Folk Medicine and Culinary Uses List


        Container(
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
  padding: const EdgeInsets.all(10.0),
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text("Ayurveda - ${plantData.traditionalUses.target?.ayurveda ?? "N/A"}"),
        SizedBox(height: 5),
        Text("Folk Medicine - ${plantData.traditionalUses.target?.folkMedicine ?? "N/A"}"),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Culinary Uses",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: plantData.traditionalUses.target?.culinaryUses
                        ?.map((use) => Text("• $use", style: TextStyle(fontSize: 14)))
                        .toList() ??
                    [],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),


      
    
    

        ]

      ));

  
  
  }
}