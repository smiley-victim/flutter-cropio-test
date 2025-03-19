import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/Pages/widget/CareInstructionsWidget%20.dart';
import '../../controller/plant_controller.dart';

class Storageandpropagation extends StatelessWidget {
   final PlantDataEntity plantData; 

  Storageandpropagation({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    
    

      // if (plantData.harvestInfo.isEmpty  && plantData.companionPlants.isEmpty) {
      //   return Center(child: Text("No pests and harvest found."));
      // }

    return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// ✅ Companion Plants Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("🌿 Companion Plants",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10,
              ),

              plantData.companionPlants.isNotEmpty
                  ? Container(
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
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: plantData.companionPlants
                              .map((plant) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${plant.plant}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text("Benefit: ${plant.benefit}",
                                          style: TextStyle(fontSize: 14)),
                                      SizedBox(height: 8),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    )
                  : Text("No Companion Plants Available",
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),

              SizedBox(
                height: 10,
              ),

SizedBox(height: 10,),


 Padding(
   padding: const EdgeInsets.symmetric(horizontal: 10.0),
   child: Text(" Storage Inovation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold )),
 ),
  SizedBox(height: 10,),
//Storage and Inovation Uses List

//plantData.storageData.isNotEmpty?
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
        Text(" - ${plantData.plant?? "N/A"}"),
        SizedBox(height: 5),
        Text(" - ${plantData.plant??"N/A"}"),
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
                "Storage Inovation",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // children: plantData
                //         .map((use) => Text("• $use", style: TextStyle(fontSize: 14)))
                //         .toList() ??
                //     [],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

      
    
    

              Text("Other Features",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              // ✅ Propagation Methods

              SizedBox(height: 10),

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
// Text("Propagation Methods", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("🌿 Propagation Methods",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Seeds  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            softWrap: true),
                                        Text(
                                          "${plantData.propagationMethods.target?.seeds ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Grafting  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            softWrap: true),
                                        Text(
                                         "${plantData.propagationMethods.target?.grafting ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Air-Layering  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            softWrap: true),
                                        Text(
                                         "${plantData.propagationMethods.target?.airLayering ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Tissue Culture  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            softWrap: true),
                                        Text(
                                        "${plantData.propagationMethods.target?.tissueCulture ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
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
                          child: Text("🌿 Propagation Methods",
                              style: TextStyle(
                                fontSize: 16,
                              ))),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    // ✅ Pollination Information
// Text("Pollination Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("🌿 Pollination Information",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Type  ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            softWrap: true),
                                        Text(
                                        "${plantData.pollination.target?.type ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Flowering Season  ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            softWrap: true),
                                        Text(
                                          "${plantData.pollination.target?.floweringSeason ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Importance  ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            softWrap: true),
                                        Text(
                                         "${plantData.pollination.target?.importance ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text("Pollinators:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: (plantData.pollination.target?.pollinators
                                                  as List<dynamic>?)
                                              ?.map((pollinator) => Text(
                                                  "• $pollinator",
                                                  style:
                                                      TextStyle(fontSize: 14)))
                                              .toList() ??
                                          [],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
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
                          child: Text("🌿 Pollination Information",
                              style: TextStyle(
                                fontSize: 16,
                              ))),
                    ),

                    SizedBox(
                      height: 10,
                    ),
//🌿 Climate Change Adaptation

// Text("🌿 Climate Change Adaptation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("🌿 Climate Change Adaptation",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Flood Resistance  ",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            softWrap: true),
                                        Text(
                                          " ${plantData.climateChangeAdaptation.target?.floodResistance ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Extreme Heat Resistance  ",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            softWrap: true),
                                        Text(
                                           " ${plantData.climateChangeAdaptation.target?.extremeHeatResistance ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Storm Protection  ",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            softWrap: true),
                                        Text(
                                         " ${plantData.climateChangeAdaptation.target?.stormProtection ?? "N/A"}",
                                          style:
                                              TextStyle(color: Colors.black87),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
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
                          child: Text("🌿 Climate Change Adaptation",
                              style: TextStyle(
                                fontSize: 16,
                              ))),
                    ),

                    SizedBox(
                      height: 10,
                    ),

// genetic Varieties
                    
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("🌿 Genetic Varieties",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (plantData.geneticVarieties == null || plantData.geneticVarieties!.isEmpty)
          const Text(
            "No Genetic Varieties Available",
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ...?plantData.geneticVarieties?.map((variety) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ${variety.variety}",
                  style: const TextStyle(fontSize: 16, ),
                ),
                Text(
                  "Characteristics: ${variety.characteristics}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
              ],
            )),
                                  ],
                                ),
                             
                             
                              ),
                            
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
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
                          child: Text("🌿 Genetic Varieties",
                              style: TextStyle(
                                fontSize: 16,
                              ))),
                    ),

                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),


            ],
          ),
        );
  }
}
