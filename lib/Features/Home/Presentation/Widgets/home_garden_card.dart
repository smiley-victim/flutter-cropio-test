import 'package:flutter/material.dart';
import 'package:myapp/Features/Home/Presentation/Pages/series_of_pages.dart';
import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/Pages/plants_info_detailview.dart';
import '../../../GardenV2/Data/Models/plantdataentity_model.dart';

class DashboardPlantCard extends StatelessWidget {
  final PlantDataEntity plant;

  const DashboardPlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantsInfoDetailview(plantData: plant),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPlantImage(plant),
                  const SizedBox(height: 8),
                  Text(
                    plant.plant,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    plant.scientificName,
                    style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildInfoChip(Icons.category, plant.type),
                      const SizedBox(width: 4),
                      _buildInfoChip(Icons.eco, plant.plantClass),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildSeasonalityIndicator(
                    plant.harvestInfo.target!.season,
                    Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantImage(PlantDataEntity plant) {
    return Hero(
      tag: 'plant-dashboard-${plant.id}',
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 1),
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
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalityIndicator(String season, Color primaryColor) {
    Color? seasonColor;
    IconData seasonIcon;
    double iconSize = 14;
    TextStyle textStyle = TextStyle(
        color: seasonColor, fontWeight: FontWeight.bold, fontSize: 10);

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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: seasonColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: seasonColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(seasonIcon, size: iconSize, color: seasonColor),
          const SizedBox(width: 2),
          Text(
            season,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

Widget buildEmptyGardenPlaceholder(BuildContext context) {
  return Container(
    height: 160,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.local_florist_outlined,
          size: 40,
          color: Colors.grey.shade600,
        ),
        const SizedBox(height: 12),
        Text(
          "Your garden is empty",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            BottomNavigationBar navigationBar =
                glbkey.currentWidget as BottomNavigationBar;
            navigationBar.onTap!(1);
          },
          child: const Text(
            "Add Plants",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
