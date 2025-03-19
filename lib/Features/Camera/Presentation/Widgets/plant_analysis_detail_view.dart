import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/Features/Plant%20info%20panel/Presentations/Widget/feature_card.dart';

import '../../Data/modals/plantdatamodelv2.dart';




class PlantsAnalysisDetailview extends StatelessWidget {
  final PlantAnalysisData plantData;
  final String image;

  const PlantsAnalysisDetailview({
    super.key,
    required this.plantData,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final PlantIdentification? plantIdentification = plantData.plantIdentification.target;
    final PlantDescription? plantDescription = plantData.plantDescription.target;
    final GrowingConditions? growingConditions = plantData.growingConditions.target;
    final HealthAssessment? healthAssessment = plantData.healthAssessment.target;
    final CommonProblems? commonProblems = plantData.commonProblems.target;

    List<FeatureCard> featureCards = [];

    if (growingConditions != null) {
      featureCards.addAll([
        FeatureCard(
          icon: Icons.wb_sunny_outlined,
          title: 'Sunlight: ${growingConditions.sunlight}',
          color: const Color(0xFFFFF9E6),
        ),
        FeatureCard(
          icon: Icons.water_drop_outlined,
          title: 'Watering: ${growingConditions.watering}',
          color: const Color(0xFFF5E6FF),
        ),
        FeatureCard(
          icon: Icons.water,
          title: 'Soil: ${growingConditions.soilType}',
          color: const Color(0xFFE6F3FF),
        ),
      ]);
    }

    if (commonProblems != null && commonProblems.problems.isNotEmpty) {
      for (var problem in commonProblems.problems) {
        featureCards.add(FeatureCard(
          icon: Icons.warning_amber_rounded,
          title: problem.issue,
          color: const Color(0xFFE6FFE6),
        ));
      }
    }

    if (healthAssessment != null && healthAssessment.potentialIssues.isNotEmpty) {
      for (var issue in healthAssessment.potentialIssues) {
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
                      plantIdentification?.species ?? 'N/A', // Null-safe access
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      plantDescription?.description ?? 'N/A', // Null-safe access
                      style: TextStyle(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
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
                      children: featureCards,
                    ),
                  ],
                ),
              ),

              // Health Assessment
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Health Assessment : ${healthAssessment?.overallHealth ?? 'N/A'}', // Null-safe access
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Common Problems
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: commonProblems?.problems.length ?? 0, // Null-safe length check
                      itemBuilder: (BuildContext context, int index) {
                        final problem = commonProblems?.problems[index]; // Get problem safely
                        return Text(
                          " ${problem?.issue ?? 'N/A'} : ${problem?.remedy ?? 'N/A'}", // Null-safe access to issue and remedy
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}