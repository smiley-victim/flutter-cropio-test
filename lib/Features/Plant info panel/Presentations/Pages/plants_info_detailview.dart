import 'package:flutter/material.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';

class PlantsInfoDetailview extends StatelessWidget {
  final String? plantName;
  final String? imageUrl;
  final String? description;
  final PlantInfo? selectedPlant;

  const PlantsInfoDetailview({
    super.key,
    this.selectedPlant,
    this.plantName,
    this.imageUrl,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
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

              // Plant Image
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green,
                  image: DecorationImage(
                    // image: AssetImage('assets/philodendron.jpg'),
                    image: selectedPlant != null && selectedPlant!.imageUrl[0].isNotEmpty
                        ? NetworkImage(selectedPlant!.imageUrl[0])
                        : AssetImage('assets/placeholder.png') as ImageProvider,
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
                      selectedPlant?.plant ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedPlant == null
                          ? "Philodendron is a large genus of flowering plants in the family Araceae. As of September 2015, the World Checklist of Selected Plant Families accepted 489 species; other sources accept"
                          : selectedPlant!.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Read more'),
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
                      children: const [
                        FeatureCard(
                          icon: Icons.wb_sunny_outlined,
                          title:
                              'Indoors: Medium light\nOutside: Part sun or shade',
                          color: Color(0xFFFFF9E6),
                        ),
                        FeatureCard(
                          icon: Icons.water_drop_outlined,
                          title: '40%\nHumidity',
                          color: Color(0xFFF5E6FF),
                        ),
                        FeatureCard(
                          icon: Icons.water,
                          title: 'Medium\nWater needs',
                          color: Color(0xFFE6F3FF),
                        ),
                        FeatureCard(
                          icon: Icons.eco_outlined,
                          title: 'It purifies the air & very easy to grow.',
                          color: Color(0xFFE6FFE6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'ADD TO GARDEN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.heat_pump_rounded,
                          color: Colors.white,
                        ),
                      ),
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

/*

**Data Structure:**
----- still under consideration ----
You'll likely need to fetch plant data from an API or database. 
Here's an example of how your data might be structured:

class Plant {
  final String name;
  final String imageUrl;
  final String description;
  final String sunlight;
  final String water;
  final String growthRate;
  // ... other properties

  Plant({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.sunlight,
    required this.water,
    required this.growthRate,
    // ... other properties
  });
}

*/

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
