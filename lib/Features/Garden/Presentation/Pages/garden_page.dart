import 'package:flutter/material.dart';
import 'package:myapp/Features/Garden/Data/modala/garden_plants.dart';
import 'package:myapp/Features/Garden/Presentation/Pages/garden_plant_detail_page.dart';

class MyGardenPage extends StatelessWidget {
  const MyGardenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plants = [
      {
        'name': 'Monstera',
        'image':
            'https://images.pexels.com/photos/1072824/pexels-photo-1072824.jpeg'
      },
      {'name': 'Cactus', 'image': 'assets/cactus.jpg'},
      {'name': 'Aloe Vera', 'image': 'assets/aloe.jpg'},
      {'name': 'Snake Plant', 'image': 'assets/snake.jpg'},
      {'name': 'Pothos', 'image': 'assets/pothos.jpg'},
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                  children: plants
                      .map((plant) =>
                          PlantCard(name: plant['name'], image: plant['image']))
                      .toList(),
                ),
                const SizedBox(height: 32),
                _buildCareSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Your Garden',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
  
  Widget _buildCareSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Care for your plants',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildCareCard(
          'How to water your Monstera',
          '1 min read',
          Icons.water_drop,
        ),
        const SizedBox(height: 12),
        _buildCareCard(
          'Fertilizing schedule for Cactus',
          '2 min read',
          Icons.eco,
        ),
        const SizedBox(height: 12),
        _buildCareCard(
          'Pruning your Aloe Vera',
          '3 min read',
          Icons.cut,
        ),
      ],
    );
  }

  Widget _buildCareCard(String title, String readTime, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  readTime,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String? name, image;
  const PlantCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlantDetailPage(plant: monstera,),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 250, 210),
                ),
                // child: Image.network(
                //   plant['image']!,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
