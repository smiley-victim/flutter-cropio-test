import 'package:flutter/material.dart';

import '../../Data/ modals/sustainanble_practice_modal.dart';

class CarbonCreditRewardsPage extends StatefulWidget {
  const CarbonCreditRewardsPage({super.key});

  @override
  State<CarbonCreditRewardsPage> createState() => _CarbonCreditRewardsPageState();
}

class _CarbonCreditRewardsPageState extends State<CarbonCreditRewardsPage> {

 

  // List of sustainable practices
  final List<SustainablePractice> sustainablePractices = [
    SustainablePractice(
      id: 'no-till-farming',
      name: 'No-Till Farming',
      description: 'Minimizes soil disturbance to reduce carbon emissions',
      carbonImpact: 'High',
      points: 500,
    ),
    SustainablePractice(
      id: 'cover-cropping',
      name: 'Cover Cropping',
      description: 'Planting crops to prevent soil erosion and improve carbon sequestration',
      carbonImpact: 'Medium',
      points: 350,
    ),
    SustainablePractice(
      id: 'agroforestry',
      name: 'Agroforestry',
      description: 'Integrating trees and shrubs into agricultural landscapes',
      carbonImpact: 'High',
      points: 750,
    ),
    SustainablePractice(
      id: 'precision-agriculture',
      name: 'Precision Agriculture',
      description: 'Using technology to optimize resource use and reduce emissions',
      carbonImpact: 'Medium',
      points: 400,
    ),
  ];

  // Eligibility status
  String? _eligibilityMessage;
  Color? _eligibilityColor;
  String? _nextSteps;

  // Calculate total points and eligibility
  void _calculateEligibility() {
    int totalPoints = sustainablePractices
        .where((practice) => practice.isSelected)
        .fold(0, (sum, practice) => sum + practice.points);

    setState(() {
      if (totalPoints >= 1000) {
        _eligibilityMessage = 'Congratulations! You qualify for carbon credits.';
        _eligibilityColor = Colors.green;
        _nextSteps = 'Submit detailed documentation for verification';
      } else if (totalPoints > 0) {
        _eligibilityMessage = 'You are close to qualifying. Implement more sustainable practices.';
        _eligibilityColor = Colors.orange;
        _nextSteps = 'Add more sustainable farming techniques';
      } else {
        _eligibilityMessage = null;
        _eligibilityColor = null;
        _nextSteps = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Credit Rewards'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Sustainable Farming Practices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: sustainablePractices.length,
                itemBuilder: (context, index) {
                  final practice = sustainablePractices[index];
                  return Card(
                    color: practice.isSelected ? Colors.green.shade50 : null,
                    child: CheckboxListTile(
                      title: Text(practice.name),
                      subtitle: Text(practice.description),
                      secondary: Text('${practice.points} Points'),
                      value: practice.isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          practice.isSelected = value ?? false;
                          _calculateEligibility();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (_eligibilityMessage != null)
              Card(
                color: _eligibilityColor?.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _eligibilityMessage!,
                        style: TextStyle(
                          color: _eligibilityColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Next Steps: $_nextSteps',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}