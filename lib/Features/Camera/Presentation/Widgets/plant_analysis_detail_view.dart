import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/Features/Camera/Data/modals/plantdatamodal.dart';

import '../../../Plant info panel/Presentations/Pages/plants_info_detailview.dart'
    show FeatureCard;

class PlantsAnalysisDetailview extends StatelessWidget {
  final PlantData plantData;
  final String image;

  const PlantsAnalysisDetailview({
    super.key,
    required this.plantData,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    List<FeatureCard> featureCards = [
      FeatureCard(
        icon: Icons.wb_sunny_outlined,
        title: 'Sunlight: ${plantData.growingConditions.sunlight}',
        color: const Color(0xFFFFF9E6),
      ),
      FeatureCard(
        icon: Icons.water_drop_outlined,
        title: 'Watering: ${plantData.growingConditions.watering}',
        color: const Color(0xFFF5E6FF),
      ),
      FeatureCard(
        icon: Icons.water,
        title: 'Soil: ${plantData.growingConditions.soilType}',
        color: const Color(0xFFE6F3FF),
      ),
      
    ];
   if (plantData.commonProblems.problems.isNotEmpty) {
      for (var problem in plantData.commonProblems.problems) {
          featureCards.add(FeatureCard(
            icon: Icons.warning_amber_rounded,
            title: '${problem.issue}',
            color: const Color(0xFFE6FFE6),
          ));
        }
    }
        if (plantData.healthAssessment.potentialIssues.isNotEmpty) {
      for (var issue in plantData.healthAssessment.potentialIssues) {
          featureCards.add(FeatureCard(
            icon: Icons.healing_outlined,
            title: 'Issue: ${issue.issue} \n Remedy: ${issue.remedy}',
            color: const Color(0xFFE6FFE6),
          ));
        }

    }

    return Scaffold(
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
                        minimumSize: const Size(35, 35),
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

              // Plant Image
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green,
                  image: DecorationImage(
                    image: FileImage(File(image)),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              // Plant Title and Description
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plantData.plantIdentification.species,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      plantData.plantDescription.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text('Read more'),
                    // ),
                  ],
                ),
              ),

              // Usage & Features Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Usage & Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      //remove const
                      children:featureCards
                    ),
                  ],
                ),
              ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                               const SizedBox(height: 16),
                            Text(
                              'Health Assessment : ${plantData.healthAssessment.overallHealth}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Common Problem',

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: plantData.commonProblems.problems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(" ${plantData.commonProblems.problems[index].issue} : ${plantData.commonProblems.problems[index].remedy}" );
                                }
                            )
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
