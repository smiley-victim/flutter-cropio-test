import 'package:flutter/material.dart';

import '../../Data/modala/garden_plants.dart';

class PlantDetailPage extends StatelessWidget {
  final Crop plant;

  const PlantDetailPage({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      SingleChildScrollView(
        child: Column(
          children: [
            _buildSliverAppBar(context),
            _buildQuickInfo(),
            _buildGrowthStages(),
            _buildCareGuide(),
            _buildSeasonalCare(),
            _buildTroubleshooting(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                backgroundColor: const Color.fromARGB(255, 255, 250, 250),
                padding: const EdgeInsets.all(2),
                minimumSize: Size(35, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadowColor: Colors.black.withOpacity(0.1),
                elevation: 8,
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
          image: const DecorationImage(
            image: AssetImage('assets/philodendron.jpg'),
            fit: BoxFit.cover,
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
              plant.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ]);
  }

  Widget _buildQuickInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                  Icons.water_drop, 'Water Needs', plant.careInfo.waterNeeds),
              _buildInfoRow(Icons.wb_sunny, 'Light', plant.careInfo.light),
              _buildInfoRow(
                  Icons.thermostat, 'Temperature', plant.careInfo.temperature),
              _buildInfoRow(
                  Icons.straighten, 'Max Height', plant.careInfo.maxHeight),
              _buildInfoRow(Icons.water, 'Humidity', plant.careInfo.humidity),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthStages() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Growth Stages',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...plant.growthStages
                  .map((stage) => _buildStageCard(stage))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageCard(GrowthStage stage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[50],
      child: ExpansionTile(
        title: Text(
          stage.stage,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Duration: ${stage.duration}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Care Requirements:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...stage.careInstructions.map(
                  (instruction) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(instruction)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareGuide() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Care Guide',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...plant.careProcedures.map((procedure) => _buildCareSection(
                    procedure.title,
                    getIconData(procedure.icon),
                    procedure.description,
                    procedure.tips,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareSection(
    String title,
    IconData icon,
    String description,
    List<String> tips,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[50],
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description),
                const SizedBox(height: 8),
                const Text(
                  'Tips:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...tips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_right, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(child: Text(tip)),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalCare() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seasonal Care',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSeasonCard('Spring', plant.seasonalCare.spring),
              _buildSeasonCard('Summer', plant.seasonalCare.summer),
              _buildSeasonCard('Fall', plant.seasonalCare.fall),
              _buildSeasonCard('Winter', plant.seasonalCare.winter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeasonCard(String season, SeasonalTasks seasonTasks) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[50],
      child: ExpansionTile(
        leading: Icon(
          getIconData(seasonTasks.icon),
          color: Colors.green,
        ),
        title: Text(season),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: seasonTasks.tasks
                  .map((task) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                color: Colors.green, size: 20),
                            const SizedBox(width: 8),
                            Expanded(child: Text(task)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshooting() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Troubleshooting',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...plant.commonIssues
                  .map((issue) => _buildProblemCard(issue))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProblemCard(CommonIssue issue) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[50],
      child: ExpansionTile(
        title: Text(issue.issue),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Possible Causes:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...issue.causes.map(
                  (cause) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.orange, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(cause)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Solution:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(issue.solution),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
