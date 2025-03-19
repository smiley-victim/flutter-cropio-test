import 'package:flutter/material.dart';
import 'package:myapp/Features/GardenV2/Data/DataSource/dataservice.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/Pages/plants_info_detailview.dart';

class PlantListPage extends StatelessWidget {
  const PlantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MyDataService().getAllPlantData();
    List<PlantDataEntity> plantList = data.isNotEmpty ? data : [];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Garden',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: plantList.length,
        itemBuilder: (context, index) {
          final plant = plantList[index];
          return _buildPlantCard(context, plant);
        },
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, PlantDataEntity plant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToDetails(context, plant),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPlantImage(plant),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPlantInfo(context, plant),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantImage(PlantDataEntity plant) {
    return Hero(
      tag: 'plant-${plant.id}',
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            plant.imageUrl.isNotEmpty
                ? plant.imageUrl.first
                : 'placeholder_url',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.local_florist,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantInfo(BuildContext context, PlantDataEntity plant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plant.plant,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          plant.scientificName,
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildInfoChip(Icons.category, plant.type),
            const SizedBox(width: 8),
            _buildInfoChip(Icons.eco, plant.plantClass),
          ],
        ),
        const SizedBox(height: 8),
        _buildSeasonalityIndicator(
          plant.harvestInfo.target!.season,
          Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, PlantDataEntity plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantsInfoDetailview(plantData: plant),
      ),
    );
  }

  Widget _buildSeasonalityIndicator(String season, Color primaryColor) {
    Color? seasonColor;
    IconData seasonIcon;
    double iconSize = 18; // Slightly smaller icon for list card
    TextStyle textStyle = TextStyle(
        color: seasonColor,
        fontWeight: FontWeight.bold,
        fontSize: 12); // Smaller text for list card

    if (season.toLowerCase().contains('summer')) {
      seasonColor = Colors.orange[600]!;
      seasonIcon = Icons.wb_sunny;
    } else if (season.toLowerCase().contains('winter')) {
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
          horizontal: 8, vertical: 3), // Even smaller padding for list card
      decoration: BoxDecoration(
        color: seasonColor.withValues(alpha: 0.15),
        borderRadius:
            BorderRadius.circular(16), // More rounded for smaller size
        border: Border.all(color: seasonColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(seasonIcon, size: iconSize, color: seasonColor),
          const SizedBox(width: 4),
          Text(
            season,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
