import 'package:flutter/material.dart';
import '../../Data/Models/plantdataentity_model.dart';

class PlantDetailsPage extends StatefulWidget {
  final PlantDataEntity plantData; // Changed to PlantDataEntity

  const PlantDetailsPage({super.key, required this.plantData});

  @override
  State<PlantDetailsPage> createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends State<PlantDetailsPage>
    with TickerProviderStateMixin {
  // Add TickerProviderStateMixin for animation
  bool isBookmarked = false;
  late PageController _imagePageController;
  int _currentImageIndex = 0;

  // Animation for bookmark icon
  late AnimationController _bookmarkAnimationController;
  // late Animation<double> _bookmarkAnimation;

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController();

    // Bookmark animation setup
    _bookmarkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    // _bookmarkAnimation =
    //     Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    //   parent: _bookmarkAnimationController,
    //   curve: Curves.easeInOut,
    // ));
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _bookmarkAnimationController.dispose();
    super.dispose();
  }

  // void _toggleBookmark() {
  //   setState(() {
  //     isBookmarked = !isBookmarked;
  //     if (isBookmarked) {
  //       _bookmarkAnimationController.forward(); // Animate to filled bookmark
  //     } else {
  //       _bookmarkAnimationController
  //           .reverse(); // Animate back to border bookmark
  //     }
  //   });
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //           isBookmarked ? 'Saved to My Garden' : 'Removed from My Garden'),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // Check if dark mode is enabled
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Refined color palette
    final primaryColor = isDarkMode ? Colors.green[300] : Colors.green[700];
    final primaryColorLight =
        isDarkMode ? Colors.green[100] : Colors.green[50]; // Lighter shade
    final cardColor = isDarkMode
        ? Colors.grey[850]
        : Colors.white; // Slightly darker card in dark mode
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtleTextColor =
        textColor.withValues(alpha: 0.7); // For less prominent text

    return Scaffold(
      backgroundColor: Colors.grey
          .shade50, // Very light grey background instead of pure white for visual interest
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuickActionSheet(context);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.tips_and_updates,
            color: Colors.white), // White icon on FAB
      ),
      body: SingleChildScrollView(
        child: Padding(
          // Added padding around the entire content
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCarousel(context),
              const SizedBox(
                  height: 20), // Increased spacing below image carousel
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4.0), // Slight horizontal padding for text
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align row content to top
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plantData.plant, // Use plantData.plant
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      // headlineLarge for plant name
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                              ),
                              Text(
                                widget.plantData
                                    .scientificName, // Use plantData.scientificName
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      // titleMedium for scientific name
                                      fontStyle: FontStyle.italic,
                                      color: subtleTextColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        _buildSeasonalityIndicator(widget
                                .plantData.harvestInfo.target?.season ??
                            'N/A'), // Use plantData.harvestInfo.target?.season
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Type: ${widget.plantData.type} | Class: ${widget.plantData.plantClass}', // Use plantData.type and plantData.plantClass
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: subtleTextColor), // titleSmall for type/class
                    ),
                    const SizedBox(
                        height:
                            20), // Increased spacing before quick overview cards
                    _buildQuickOverviewCards(
                        primaryColor!, cardColor!, textColor),
                    const SizedBox(
                        height:
                            30), // Further increased spacing after quick overview cards
                  ],
                ),
              ),
              _buildExpandableSection(
                'About ${widget.plantData.plant}', // Use plantData.plant
                _buildDescriptionCard(widget.plantData.description, cardColor,
                    textColor), // Use plantData.description
                primaryColor,
                textColor,
                initiallyExpanded: true,
                icon: Icons.info_outline,
              ),
              _buildExpandableSection(
                'Growing Conditions',
                _buildGrowingConditionsCard(
                    widget.plantData.growingConditions
                        .target!, // Use plantData.growingConditions.target!
                    cardColor,
                    textColor,
                    primaryColor),
                primaryColor,
                textColor,
                icon: Icons.wb_sunny_outlined,
              ),
              _buildExpandableSection(
                'Nutrient Needs & Fertilization',
                _buildNutrientRequirementsCard(
                    widget.plantData.nutrientRequirements
                        .target!, // Use plantData.nutrientRequirements.target!
                    cardColor,
                    textColor,
                    primaryColor),
                primaryColor,
                textColor,
                icon: Icons.grass,
              ),
              _buildExpandableSection(
                'Pests & Diseases',
                _buildPestsAndDiseasesSection(
                    widget.plantData.pests
                        .toList(), // Use plantData.pests.toList()
                    widget.plantData.disease
                        .toList(), // Use plantData.disease.toList()
                    cardColor,
                    textColor,
                    primaryColor),
                primaryColor,
                textColor,
                icon: Icons.bug_report,
              ),
              _buildExpandableSection(
                'Harvesting Information',
                _buildHarvestInfoCard(
                    widget.plantData.harvestInfo.target!,
                    cardColor, // Use plantData.harvestInfo.target!
                    textColor,
                    primaryColor),
                primaryColor,
                textColor,
                icon: Icons.agriculture,
              ),
              _buildExpandableSection(
                'Companion Plants',
                _buildCompanionPlantsCard(
                    widget.plantData.companionPlants
                        .toList(), // Use plantData.companionPlants.toList()
                    cardColor,
                    textColor,
                    primaryColor),
                primaryColor,
                textColor,
                icon: Icons.people_outline,
              ),
              _buildExpandableSection(
                'Other Useful Information',
                _buildOtherInfoCard(
                    widget.plantData, cardColor, textColor, primaryColor),
                primaryColor,
                textColor,
                icon: Icons.more_horiz,
              ),
              const SizedBox(height: 100), // Space for FAB and bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250, // Increased image carousel height
          child: PageView.builder(
            controller: _imagePageController,
            itemCount: widget.plantData.imageUrl.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                // ClipRRect for rounded corners on images
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.plantData.imageUrl[index], // Use plantData.imageUrl
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      // Grey background for image error state
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Icon(Icons.image_not_supported,
                          size: 60, color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12, // Slightly adjusted indicator position
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.plantData.imageUrl.length, // Use plantData.imageUrl
              (index) => Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 4), // Adjusted indicator spacing
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index
                      ? Colors.white
                      : Colors.white.withValues(
                          alpha:
                              0.6), // Slightly more transparent inactive indicators
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeasonalityIndicator(String season) {
    Color seasonColor;
    IconData seasonIcon;

    if (season.toLowerCase().contains('summer')) {
      seasonColor = Colors.orange[600]!; // More vibrant orange
      seasonIcon = Icons.wb_sunny;
    } // ... (rest of seasonality indicator logic - no changes needed) ...
    else if (season.toLowerCase().contains('winter')) {
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
          horizontal: 10, vertical: 5), // Adjusted padding
      decoration: BoxDecoration(
        color:
            seasonColor.withValues(alpha: 0.15), // Slightly darker background
        borderRadius: BorderRadius.circular(20), // More rounded corners
        border: Border.all(
            color:
                seasonColor.withValues(alpha: 0.6)), // Slightly darker border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(seasonIcon,
              size: 18, color: seasonColor), // Slightly larger icon
          const SizedBox(width: 6), // Adjusted spacing
          Text(
            season,
            style: TextStyle(
                color: seasonColor,
                fontWeight: FontWeight.w600), // Slightly bolder text
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOverviewCards(
      Color primaryColor, Color cardColor, Color textColor) {
    return SizedBox(
      height: 110, // Slightly taller quick overview cards
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none, // To prevent clipping of shadows
        children: [
          _buildQuickCard(
              'Water',
              widget.plantData.growingConditions.target?.water ??
                  'N/A', // Use plantData.growingConditions.target?.water
              Icons.water_drop,
              cardColor,
              textColor,
              primaryColor),
          _buildQuickCard(
              'Sunlight',
              widget.plantData.growingConditions.target?.sunlight ??
                  'N/A', // Use plantData.growingConditions.target?.sunlight
              Icons.wb_sunny,
              cardColor,
              textColor,
              primaryColor),
          _buildQuickCard(
              'Soil',
              widget.plantData.growingConditions.target?.soilType ??
                  'N/A', // Use plantData.growingConditions.target?.soilType
              Icons.terrain,
              cardColor,
              textColor,
              primaryColor),
          _buildQuickCard(
              'pH',
              widget.plantData.growingConditions.target?.soilPH ??
                  'N/A', // Use plantData.growingConditions.target?.soilPH
              Icons.science,
              cardColor,
              textColor,
              primaryColor),
          _buildQuickCard(
              'Temp',
              widget.plantData.growingConditions.target?.temperature ??
                  'N/A', // Use plantData.growingConditions.target?.temperature
              Icons.thermostat,
              cardColor,
              textColor,
              primaryColor),
        ],
      ),
    );
  }

  Widget _buildQuickCard(String title, String value, IconData icon,
      Color cardColor, Color textColor, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(right: 12), // Increased right margin
      child: Card(
        color: cardColor,
        elevation: 3, // Slightly increased elevation for shadow
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)), // More rounded corners
        child: Container(
          width: 120, // Slightly wider quick cards
          padding:
              const EdgeInsets.all(16), // Increased padding inside quick cards
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: iconColor,
                  size: 26), // Slightly larger icons in quick cards
              const SizedBox(height: 10), // Increased spacing
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Slightly larger title text
                ),
              ),
              const SizedBox(height: 6), // Adjusted spacing
              Text(
                value,
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.8),
                  fontSize: 13, // Slightly larger value text
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
      String title, Widget content, Color primaryColor, Color textColor,
      {bool initiallyExpanded = false, IconData icon = Icons.article}) {
    return Container(
      // Container to apply margin to the Card
      margin: const EdgeInsets.symmetric(
          horizontal: 0, vertical: 10), // Adjusted vertical margin
      child: Card(
        elevation: 2, // Reduced elevation for expandable section cards
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(14)), // Slightly more rounded corners
        color: Colors.white, // Ensure card background is white
        child: ExpansionTile(
          title: Padding(
            // Added padding to ExpansionTile title for better spacing
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(icon,
                    color: primaryColor,
                    size: 24), // Slightly larger icons in section titles
                const SizedBox(width: 12), // Increased spacing
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 17, // Slightly larger section title text
                  ),
                ),
              ],
            ),
          ),
          childrenPadding: const EdgeInsets.all(
              20), // Increased padding inside expandable sections
          initiallyExpanded: initiallyExpanded,
          iconColor: primaryColor,
          tilePadding: EdgeInsets.symmetric(
              horizontal: 24), // Padding for the whole tile area
          children: [content],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(
      String description, Color cardColor, Color textColor) {
    return Text(
      description,
      style: TextStyle(
        color: textColor,
        height: 1.6, // Slightly increased line height for description
        fontSize: 15, // Slightly larger description text
      ),
    );
  }

  Widget _buildGrowingConditionsCard(
      GrowingConditionsEntity conditions, // Changed to GrowingConditionsEntity
      Color cardColor,
      Color textColor,
      Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconRow(
            Icons.wb_sunny,
            'Sunlight',
            conditions.sunlight, // Use conditions.sunlight
            textColor,
            primaryColor),
        _buildIconRow(
            Icons.water_drop,
            'Water',
            conditions.water,
            textColor, // Use conditions.water
            primaryColor),
        _buildIconRow(
            Icons.thermostat,
            'Temperature',
            conditions.temperature, // Use conditions.temperature
            textColor,
            primaryColor),
        _buildIconRow(
            Icons.air,
            'Humidity',
            conditions.humidity,
            textColor, // Use conditions.humidity
            primaryColor),
        _buildIconRow(
            Icons.terrain,
            'Soil Type',
            conditions.soilType, // Use conditions.soilType
            textColor,
            primaryColor),
        _buildIconRow(
            Icons.science,
            'Soil pH',
            conditions.soilPH,
            textColor, // Use conditions.soilPH
            primaryColor),
        const SizedBox(height: 20),
        Text(
          'Suitable Climates:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: conditions.climateSuitability
              .toList() // Use conditions.climateSuitability.toList()
              .map((climate) => _buildChip(
                    '${climate.region} (${climate.climate})', // Use climate.region and climate.climate
                    primaryColor,
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),
        _buildToleranceRow(
            'Wind Resistance',
            conditions.windResistance, // Use conditions.windResistance
            textColor,
            primaryColor),
        _buildToleranceRow(
            'Frost Tolerance',
            conditions.frostTolerance, // Use conditions.frostTolerance
            textColor,
            primaryColor),
        _buildToleranceRow(
            'Drought Tolerance',
            conditions.droughtTolerance, // Use conditions.droughtTolerance
            textColor,
            primaryColor),
      ],
    );
  }

  Widget _buildNutrientRequirementsCard(
      NutrientRequirementsEntity
          requirements, // Changed to NutrientRequirementsEntity
      Color cardColor,
      Color textColor,
      Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Macronutrients visualization
        Text(
          'Macronutrients:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _buildNutrientBar(
                'N',
                requirements.macronutrients.target?.nitrogen ?? 'N/A',
                Colors
                    .green), // Use requirements.macronutrients.target?.nitrogen
            const SizedBox(width: 15),
            _buildNutrientBar(
                'P',
                requirements.macronutrients.target?.phosphorus ?? 'N/A',
                Colors
                    .orange), // Use requirements.macronutrients.target?.phosphorus
            const SizedBox(width: 15),
            _buildNutrientBar(
                'K',
                requirements.macronutrients.target?.potassium ?? 'N/A',
                Colors
                    .purple), // Use requirements.macronutrients.target?.potassium
          ],
        ),
        const SizedBox(height: 30),

        // Micronutrients
        Text(
          'Micronutrients:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildMicroNutrientChip(
                'Ca',
                requirements.micronutrients.target?.calcium ?? 'N/A',
                Colors.blue[
                    300]!), // Use requirements.micronutrients.target?.calcium
            _buildMicroNutrientChip(
                'Mg',
                requirements.micronutrients.target?.magnesium ?? 'N/A',
                Colors.pink[
                    300]!), // Use requirements.micronutrients.target?.magnesium
            _buildMicroNutrientChip(
                'Zn',
                requirements.micronutrients.target?.zinc ?? 'N/A',
                Colors.amber[
                    700]!), // Use requirements.micronutrients.target?.zinc
            _buildMicroNutrientChip(
                'Fe',
                requirements.micronutrients.target?.iron ?? 'N/A',
                Colors
                    .red[700]!), // Use requirements.micronutrients.target?.iron
          ],
        ),

        const SizedBox(height: 30),
        Text(
          'Fertilizer Application:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        ...requirements.fertilizerApplication
            .toList() // Use requirements.fertilizerApplication.toList()
            .map((app) =>
                _buildFertilizerCard(app, cardColor, textColor, primaryColor)),
      ],
    );
  }

  Widget _buildNutrientBar(String symbol, String level, Color color) {
    // ... (Nutrient Bar Widget - No changes needed) ...
    // Convert text level to numeric value
    int value = 0;
    if (level.toLowerCase().contains('high')) {
      value = 3;
    } else if (level.toLowerCase().contains('medium')) {
      value = 2;
    } else if (level.toLowerCase().contains('low')) {
      value = 1;
    }

    return Expanded(
      child: Column(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: value * 18.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(level, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMicroNutrientChip(String symbol, String level, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            level,
            style: TextStyle(
              color: color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFertilizerCard(
      FertilizerApplicationEntity app,
      Color cardColor, // Changed to FertilizerApplicationEntity
      Color textColor,
      Color primaryColor) {
    Color importanceColor;
    if (app.importance.toLowerCase().contains('high')) {
      importanceColor = Colors.red;
    } // ... (rest of Fertilizer Card logic - No changes needed) ...
    else if (app.importance.toLowerCase().contains('medium')) {
      importanceColor = Colors.orange;
    } else {
      importanceColor = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor, // Use cardColor here
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${app.stage} Stage', // Use app.stage
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor, // Use textColor here
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.eco, color: primaryColor, size: 18),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: importanceColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  app.importance, // Use app.importance
                  style: TextStyle(
                    color: importanceColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Type: ${app.fertilizerType}', // Use app.fertilizerType
            style:
                TextStyle(color: textColor, fontSize: 14), // Use textColor here
          ),
          Text(
            'Frequency: ${app.applicationFrequency}', // Use app.applicationFrequency
            style:
                TextStyle(color: textColor, fontSize: 14), // Use textColor here
          ),
        ],
      ),
    );
  }

  Widget _buildPestsAndDiseasesSection(
      List<PestEntity> pests,
      List<DiseaseEntity>
          diseases, // Changed to List<PestEntity> and List<DiseaseEntity>
      Color cardColor,
      Color textColor,
      Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pests.isNotEmpty) ...[
          Text(
            'Common Pests:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          ...pests.map((pest) => _buildPestDiseaseCard(
                pest.name, // Use pest.name
                pest.symptoms, // Use pest.symptoms
                pest.controlMethods, // Use pest.controlMethods
                biologicalControl:
                    pest.biologicalControl, // Use pest.biologicalControl
                isPest: true,
                cardColor: cardColor,
                textColor: textColor,
                primaryColor: primaryColor,
              )),
        ],
        if (diseases.isNotEmpty) ...[
          const SizedBox(height: 25),
          Text(
            'Common Diseases:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          ...diseases.map((disease) => _buildPestDiseaseCard(
                disease.name, // Use disease.name
                disease.symptoms, // Use disease.symptoms
                disease.remedy, // Use disease.remedy
                isPest: false,
                cardColor: cardColor,
                textColor: textColor,
                primaryColor: primaryColor,
              )),
        ],
      ],
    );
  }

  Widget _buildPestDiseaseCard(
    String name,
    List<String> symptoms,
    List<String> remedies, {
    String? biologicalControl,
    required bool isPest,
    required Color cardColor,
    required Color textColor,
    required Color primaryColor,
  }) {
    // ... (Pest Disease Card Widget - No changes needed in logic, just using entity properties) ...
    final iconColor = isPest ? Colors.red[700] : Colors.amber[700];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: isPest
                ? Colors.red.withValues(alpha: 0.3)
                : Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: isPest
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.amber.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isPest ? Icons.bug_report : Icons.sick,
                  color: iconColor,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name, // Use name parameter (pest.name or disease.name)
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Symptoms:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ...symptoms // Use symptoms parameter (pest.symptoms or disease.symptoms)
                    .map((symptom) => _buildBulletPoint(symptom, textColor,
                        isPest ? Colors.red : Colors.amber)),
                const SizedBox(height: 20),
                Text(
                  isPest ? 'Control Methods:' : 'Remedies:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ...remedies // Use remedies parameter (pest.controlMethods or disease.remedy)
                    .map((remedy) => _buildBulletPoint(
                        remedy, textColor, isPest ? Colors.red : Colors.amber)),
                if (isPest &&
                    biologicalControl != null &&
                    biologicalControl.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Biological Control:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildBulletPoint(biologicalControl, textColor,
                      Colors.green), // Use biologicalControl parameter
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHarvestInfoCard(
      HarvestInfoEntity harvestInfo,
      Color cardColor, // Changed to HarvestInfoEntity
      Color textColor,
      Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic harvest information
        _buildIconRow(
            Icons.calendar_month,
            'Harvest Season',
            harvestInfo.season,
            textColor,
            primaryColor), // Use harvestInfo.season
        _buildIconRow(
            Icons.access_time,
            'Best Time',
            harvestInfo.bestHarvestTime,
            textColor,
            primaryColor), // Use harvestInfo.bestHarvestTime
        _buildIconRow(
            Icons.agriculture,
            'Method',
            harvestInfo.method, // Use harvestInfo.method
            textColor,
            primaryColor),
        _buildIconRow(
            Icons.bar_chart,
            'Yield per Acre',
            harvestInfo.yieldPerAcre,
            textColor,
            primaryColor), // Use harvestInfo.yieldPerAcre

        const SizedBox(height: 30),
        // Economic analysis
        Text(
          'Economic Analysis:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _buildEconomicRow(
                  'Cost of Cultivation',
                  harvestInfo.economicAnalysis.target?.costOfCultivation ??
                      'N/A',
                  textColor), // Use harvestInfo.economicAnalysis.target?.costOfCultivation
              _buildEconomicRow(
                  'Expected Revenue',
                  harvestInfo.economicAnalysis.target?.expectedRevenue ?? 'N/A',
                  textColor), // Use harvestInfo.economicAnalysis.target?.expectedRevenue
              _buildEconomicRow(
                  'Profit Margin',
                  harvestInfo.economicAnalysis.target?.profitMargin ?? 'N/A',
                  textColor), // Use harvestInfo.economicAnalysis.target?.profitMargin
              _buildEconomicRow(
                  'Return on Investment',
                  harvestInfo.economicAnalysis.target?.roi ?? 'N/A',
                  textColor), // Use harvestInfo.economicAnalysis.target?.roi
            ],
          ),
        ),

        const SizedBox(height: 30),
        // Storage information
        Text(
          'Storage:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        _buildIconRow(
            Icons.timelapse,
            'Shelf Life',
            harvestInfo.storage.target?.shelfLife ?? 'N/A',
            textColor,
            primaryColor), // Use harvestInfo.storage.target?.shelfLife
        _buildIconRow(
            Icons.settings_input_component,
            'Best Conditions',
            harvestInfo.storage.target?.bestStorageConditions ?? 'N/A',
            textColor,
            primaryColor), // Use harvestInfo.storage.target?.bestStorageConditions

        if (harvestInfo.storage.target?.storageInnovations.isNotEmpty ??
            false) ...[
          // Use harvestInfo.storage.target?.storageInnovations
          const SizedBox(height: 15),
          Text(
            'Storage Innovations:',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          ...(harvestInfo.storage.target?.storageInnovations ??
                  []) // Use harvestInfo.storage.target?.storageInnovations
              .map((innovation) =>
                  _buildBulletPoint(innovation, textColor, primaryColor)),
        ],
      ],
    );
  }

  Widget _buildCompanionPlantsCard(
      List<CompanionPlantEntity> plants,
      Color cardColor, // Changed to List<CompanionPlantEntity>
      Color textColor,
      Color primaryColor) {
    if (plants.isEmpty) {
      return Text(
        "No companion plants listed for this crop.",
        style: TextStyle(
            color: textColor, fontStyle: FontStyle.italic, fontSize: 15),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Plants that grow well with ${widget.plantData.plant}:", // Use widget.plantData.plant
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: plants
              .map((plant) => _buildCompanionPlantChip(plant, primaryColor))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCompanionPlantChip(
      CompanionPlantEntity plant, Color primaryColor) {
    // Changed to CompanionPlantEntity
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: primaryColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            plant.plant, // Use plant.plant
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            plant.benefit, // Use plant.benefit
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherInfoCard(
      PlantDataEntity plantData,
      Color cardColor, // Changed to PlantDataEntity
      Color textColor,
      Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pollination:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        _buildIconRow(
            Icons.nature,
            'Type',
            plantData.pollination.target?.type ??
                'N/A', // Use plantData.pollination.target?.type
            textColor,
            primaryColor),
        if (plantData.pollination.target?.pollinators.isNotEmpty ?? false) ...[
          // Use plantData.pollination.target?.pollinators
          const SizedBox(height: 10),
          Text(
            'Pollinators:',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          ...(plantData.pollination.target?.pollinators ??
                  []) // Use plantData.pollination.target?.pollinators
              .map((pollinator) =>
                  _buildBulletPoint(pollinator, textColor, primaryColor)),
        ],
        const SizedBox(height: 15),
        Text(
          'Propagation Methods:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        _buildIconRow(
            Icons.h_plus_mobiledata_sharp,
            'Seeds',
            plantData.propagationMethods.target?.seeds ?? 'N/A',
            textColor,
            primaryColor), // Use plantData.propagationMethods.target?.seeds
        _buildIconRow(
            Icons.gesture,
            'Grafting',
            plantData.propagationMethods.target?.grafting ?? 'N/A',
            textColor,
            primaryColor), // Use plantData.propagationMethods.target?.grafting
        _buildIconRow(
            Icons.format_list_numbered,
            'Air Layering',
            plantData.propagationMethods.target?.airLayering ?? 'N/A',
            textColor,
            primaryColor), // Use plantData.propagationMethods.target?.airLayering
        _buildIconRow(
            Icons.biotech,
            'Tissue Culture',
            plantData.propagationMethods.target?.tissueCulture ??
                'N/A', // Use plantData.propagationMethods.target?.tissueCulture
            textColor,
            primaryColor),
        // ... (rest of Other Info Card Widget - adjust to use PlantDataEntity properties) ...
        const SizedBox(height: 25),
        Text(
          'Climate Change Adaptation:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        _buildToleranceRow(
            'Flood Resistance',
            plantData.climateChangeAdaptation.target?.floodResistance ??
                'N/A', // Use plantData.climateChangeAdaptation.target?.floodResistance
            textColor,
            primaryColor),
        _buildToleranceRow(
            'Extreme Heat Resistance',
            plantData.climateChangeAdaptation.target?.extremeHeatResistance ??
                'N/A', // Use plantData.climateChangeAdaptation.target?.extremeHeatResistance
            textColor,
            primaryColor),
        _buildToleranceRow(
            'Storm Protection',
            plantData.climateChangeAdaptation.target?.stormProtection ??
                'N/A', // Use plantData.climateChangeAdaptation.target?.stormProtection
            textColor,
            primaryColor),
        if (plantData.traditionalUses.target?.culinaryUses.isNotEmpty ??
            false || // Use plantData.traditionalUses.target?.culinaryUses
                plantData.traditionalUses.target!.ayurveda.isNotEmpty) ...[
          // Use plantData.traditionalUses.target?.folkMedicine
          const SizedBox(height: 25),
          Text(
            'Traditional Uses:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          if (plantData.traditionalUses.target?.culinaryUses.isNotEmpty ??
              false) ...[
            // Use plantData.traditionalUses.target?.culinaryUses
            Text(
              'Culinary Uses:',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            ...(plantData.traditionalUses.target?.culinaryUses ??
                    []) // Use plantData.traditionalUses.target?.culinaryUses
                .map((use) => _buildBulletPoint(use, textColor, primaryColor)),
          ],
          if (plantData.traditionalUses.target?.ayurveda.isNotEmpty ??
              false) ...[
            // Use plantData.traditionalUses.target?.ayurveda
            const SizedBox(height: 10),
            _buildIconRow(
                Icons.medical_services,
                'Ayurveda',
                plantData.traditionalUses.target?.ayurveda ?? 'N/A',
                textColor,
                primaryColor), // Use plantData.traditionalUses.target?.ayurveda
          ],
          if (plantData.traditionalUses.target?.folkMedicine.isNotEmpty ??
              false) ...[
            // Use plantData.traditionalUses.target?.folkMedicine
            const SizedBox(height: 10),
            _buildIconRow(
                Icons.healing,
                'Folk Medicine',
                plantData.traditionalUses.target?.folkMedicine ??
                    'N/A', // Use plantData.traditionalUses.target?.folkMedicine
                textColor,
                primaryColor),
          ],
        ]
      ],
    );
  }

  Widget _buildIconRow(IconData icon, String label, String value,
      Color textColor, Color primaryColor) {
    // ... (Icon Row Widget - No changes needed) ...
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: textColor, height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToleranceRow(
      String label, String value, Color textColor, Color primaryColor) {
    final isHighTolerance = value.toLowerCase().contains('high') ||
        value.toLowerCase().contains('moderate');
    final toleranceColor = isHighTolerance ? Colors.green : Colors.orangeAccent;
    final toleranceIcon = isHighTolerance ? Icons.thumb_up : Icons.thumb_down;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(toleranceIcon, color: toleranceColor, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: textColor, height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEconomicRow(String label, String value, Color textColor) {
    // ... (Economic Row Widget - No changes needed) ...
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: textColor, fontSize: 15)),
          Text(value, style: TextStyle(color: textColor, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color textColor, Color bulletColor) {
    // ... (Bullet Point Widget - No changes needed) ...
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.brightness_1, size: 10, color: bulletColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textColor, height: 1.5, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.water_drop, color: Colors.blue),
                title: const Text('Set Watering Reminder',
                    style: TextStyle(fontSize: 15)),
                onTap: () =>
                    {Navigator.pop(context), _showReminderDialog('Watering')},
              ),
              ListTile(
                leading: const Icon(Icons.eco, color: Colors.green),
                title: const Text('Fertilize Plant',
                    style: TextStyle(fontSize: 15)),
                onTap: () => {
                  Navigator.pop(context),
                  _showReminderDialog('Fertilizing')
                },
              ),
              ListTile(
                leading: const Icon(Icons.bug_report, color: Colors.orange),
                title: const Text('Pest Check Reminder',
                    style: TextStyle(fontSize: 15)),
                onTap: () =>
                    {Navigator.pop(context), _showReminderDialog('Pest Check')},
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.grey),
                title: const Text('Cancel', style: TextStyle(fontSize: 15)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showReminderDialog(String actionType) async {
    // ... (Reminder Dialog - No changes needed) ...
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Reminder for $actionType',
              style: TextStyle(fontSize: 17)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Do you want to set a reminder for $actionType for ${widget.plantData.plant}?',
                    style: TextStyle(fontSize: 15)),
                const SizedBox(height: 16),
                const Text(
                    'This feature will be implemented in a future update.',
                    style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Set Reminder (Coming Soon)',
                  style: TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '$actionType reminder set (not really, feature coming soon!)',
                        style: TextStyle(fontSize: 15)),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildChip(String label, Color primaryColor) {
    // ... (Chip Widget - No changes needed) ...
    return Chip(
      label: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
