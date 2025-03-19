class PlantData {
  final String id;
  final String plant;
  final String type;
  final String plantClass;
  final String scientificName;
  final List<String> imageUrl;
  final String description;
  final GrowingConditions growingConditions;
  final NutrientRequirements nutrientRequirements;
  final Pollination pollination;
  final HarvestInfo harvestInfo;
  final PropagationMethods propagationMethods;
  final List<Pest> pests;
  final List<Disease> disease;
  final List<CompanionPlant> companionPlants;
  final ClimateChangeAdaptation climateChangeAdaptation;
  final List<GeneticVariety> geneticVarieties;
  final TraditionalUses traditionalUses;
  final FertilizerCalculation fertilizerCalculation;
  final List<GrowthStage> growthStages;

  PlantData({
    required this.id,
    required this.plant,
    required this.type,
    required this.plantClass,
    required this.scientificName,
    required this.imageUrl,
    required this.description,
    required this.growingConditions,
    required this.nutrientRequirements,
    required this.pollination,
    required this.harvestInfo,
    required this.propagationMethods,
    required this.pests,
    required this.disease,
    required this.companionPlants,
    required this.climateChangeAdaptation,
    required this.geneticVarieties,
    required this.traditionalUses,
    required this.fertilizerCalculation,
    required this.growthStages,
  });

  factory PlantData.fromJson(Map<String, dynamic> json) {
    return PlantData(
      id: json['id']?.toString() ?? '',
      plant: json['plant']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      plantClass: json['class']?.toString() ?? '',
      scientificName: json['scientificName']?.toString() ?? '',
      imageUrl: json['imageUrl'] is List
          ? List<String>.from(json['imageUrl'])
          : (json['imageUrl'] != null ? [json['imageUrl'].toString()] : []),
      description: json['description']?.toString() ?? '',
      growingConditions: json['growing_conditions'] != null
          ? GrowingConditions.fromJson(json['growing_conditions'] as Map<String, dynamic>)
          : GrowingConditions.fromJson({}), // Provide empty map as default
      nutrientRequirements: json['nutrientRequirements'] != null
          ? NutrientRequirements.fromJson(json['nutrientRequirements'] as Map<String, dynamic>)
          : NutrientRequirements.fromJson({}), // Provide empty map as default
      pollination: json['pollination'] != null
          ? Pollination.fromJson(json['pollination'] as Map<String, dynamic>)
          : Pollination.fromJson({}), // Provide empty map as default
      harvestInfo: json['harvestInfo'] != null
          ? HarvestInfo.fromJson(json['harvestInfo'] as Map<String, dynamic>)
          : HarvestInfo.fromJson({}), // Provide empty map as default
      propagationMethods: json['propagationMethods'] != null
          ? PropagationMethods.fromJson(json['propagationMethods'] as Map<String, dynamic>)
          : PropagationMethods.fromJson({}), // Provide empty map as default
      pests: (json['pests'] as List?)?.map((i) => Pest.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
      disease: (json['disease'] as List?)?.map((i) => Disease.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
      companionPlants: (json['companionPlants'] as List?)?.map((i) => CompanionPlant.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
      climateChangeAdaptation: json['climateChangeAdaptation'] != null
          ? ClimateChangeAdaptation.fromJson(json['climateChangeAdaptation'] as Map<String, dynamic>)
          : ClimateChangeAdaptation.fromJson({}), // Provide empty map as default
      geneticVarieties: (json['geneticVarieties'] as List?)?.map((i) => GeneticVariety.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
      traditionalUses: json['traditionalUses'] != null
          ? TraditionalUses.fromJson(json['traditionalUses'] as Map<String, dynamic>)
          : TraditionalUses.fromJson({}), // Provide empty map as default
      fertilizerCalculation: json['fertilizerCalculation'] != null
          ? FertilizerCalculation.fromJson(json['fertilizerCalculation'] as Map<String, dynamic>)
          : FertilizerCalculation.fromJson({}), // Provide empty map as default
      growthStages: (json['growthStages'] as List?)?.map((i) => GrowthStage.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
    );
  }
}

class GrowingConditions {
  final String sunlight;
  final String water;
  final String temperature;
  final String humidity;
  final String soilType;
  final String soilPH;
  final List<ClimateSuitability> climateSuitability;
  final String windResistance;
  final String frostTolerance;
  final String droughtTolerance;

  GrowingConditions({
    required this.sunlight,
    required this.water,
    required this.temperature,
    required this.humidity,
    required this.soilType,
    required this.soilPH,
    required this.climateSuitability,
    required this.windResistance,
    required this.frostTolerance,
    required this.droughtTolerance,
  });

  factory GrowingConditions.fromJson(Map<String, dynamic> json) {
    return GrowingConditions(
      sunlight: json['sunlight']?.toString() ?? '',
      water: json['water']?.toString() ?? '',
      temperature: json['temperature']?.toString() ?? '',
      humidity: json['humidity']?.toString() ?? '',
      soilType: json['soilType']?.toString() ?? '',
      soilPH: json['soilPH']?.toString() ?? '',
      climateSuitability: (json['climateSuitability'] as List?)?.map((i) => ClimateSuitability.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
      windResistance: json['windResistance']?.toString() ?? '',
      frostTolerance: json['frostTolerance']?.toString() ?? '',
      droughtTolerance: json['droughtTolerance']?.toString() ?? '',
    );
  }
}

class ClimateSuitability {
  final String region;
  final String climate;

  ClimateSuitability({
    required this.region,
    required this.climate,
  });

  factory ClimateSuitability.fromJson(Map<String, dynamic> json) {
    return ClimateSuitability(
      region: json['region']?.toString() ?? '',
      climate: json['climate']?.toString() ?? '',
    );
  }
}

class NutrientRequirements {
  final Macronutrients macronutrients;
  final Micronutrients micronutrients;
  final List<FertilizerApplication> fertilizerApplication;

  NutrientRequirements({
    required this.macronutrients,
    required this.micronutrients,
    required this.fertilizerApplication,
  });

  factory NutrientRequirements.fromJson(Map<String, dynamic> json) {
    return NutrientRequirements(
      macronutrients: json['macronutrients'] != null
          ? Macronutrients.fromJson(json['macronutrients'] as Map<String, dynamic>)
          : Macronutrients.fromJson({}), // Provide empty map as default
      micronutrients: json['micronutrients'] != null
          ? Micronutrients.fromJson(json['micronutrients'] as Map<String, dynamic>)
          : Micronutrients.fromJson({}), // Provide empty map as default
      fertilizerApplication: (json['fertilizerApplication'] as List?)?.map((i) => FertilizerApplication.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
    );
  }
}

class Macronutrients {
  final String nitrogen;
  final String phosphorus;
  final String potassium;

  Macronutrients({
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
  });

  factory Macronutrients.fromJson(Map<String, dynamic> json) {
    return Macronutrients(
      nitrogen: json['nitrogen']?.toString() ?? '',
      phosphorus: json['phosphorus']?.toString() ?? '',
      potassium: json['potassium']?.toString() ?? '',
    );
  }
}

class Micronutrients {
  final String calcium;
  final String magnesium;
  final String zinc;
  final String iron;

  Micronutrients({
    required this.calcium,
    required this.magnesium,
    required this.zinc,
    required this.iron,
  });

  factory Micronutrients.fromJson(Map<String, dynamic> json) {
    return Micronutrients(
      calcium: json['calcium']?.toString() ?? '',
      magnesium: json['magnesium']?.toString() ?? '',
      zinc: json['zinc']?.toString() ?? '',
      iron: json['iron']?.toString() ?? '',
    );
  }
}

class FertilizerApplication {
  final String stage;
  final String fertilizerType;
  final String applicationFrequency;
  final String importance;

  FertilizerApplication({
    required this.stage,
    required this.fertilizerType,
    required this.applicationFrequency,
    required this.importance,
  });

  factory FertilizerApplication.fromJson(Map<String, dynamic> json) {
    return FertilizerApplication(
      stage: json['stage']?.toString() ?? '',
      fertilizerType: json['fertilizerType']?.toString() ?? '',
      applicationFrequency: json['applicationFrequency']?.toString() ?? '',
      importance: json['importance']?.toString() ?? '',
    );
  }
}

class Pollination {
  final String type;
  final List<String> pollinators;
  final String floweringSeason;
  final String importance;

  Pollination({
    required this.type,
    required this.pollinators,
    required this.floweringSeason,
    required this.importance,
  });

  factory Pollination.fromJson(Map<String, dynamic> json) {
    return Pollination(
      type: json['type']?.toString() ?? '',
      pollinators: (json['pollinators'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
      floweringSeason: json['floweringSeason']?.toString() ?? '',
      importance: json['importance']?.toString() ?? '',
    );
  }
}

class HarvestInfo {
  final String season;
  final String bestHarvestTime;
  final String method;
  final String yieldPerTree;
  final String yieldPerAcre;
  final EconomicAnalysis economicAnalysis;
  final Storage storage;

  HarvestInfo({
    required this.season,
    required this.bestHarvestTime,
    required this.method,
    required this.yieldPerTree,
    required this.yieldPerAcre,
    required this.economicAnalysis,
    required this.storage,
  });

  factory HarvestInfo.fromJson(Map<String, dynamic> json) {
    return HarvestInfo(
      season: json['season']?.toString() ?? '',
      bestHarvestTime: json['bestHarvestTime']?.toString() ?? '',
      method: json['method']?.toString() ?? '',
      yieldPerTree: json['yieldPerTree']?.toString() ?? '',
      yieldPerAcre: json['yieldPerAcre']?.toString() ?? '',
      economicAnalysis: json['economicAnalysis'] != null
          ? EconomicAnalysis.fromJson(json['economicAnalysis'] as Map<String, dynamic>)
          : EconomicAnalysis.fromJson({}), // Provide empty map as default
      storage: json['storage'] != null
          ? Storage.fromJson(json['storage'] as Map<String, dynamic>)
          : Storage.fromJson({}), // Provide empty map as default
    );
  }
}

class EconomicAnalysis {
  final String costOfCultivation;
  final String expectedRevenue;
  final String profitMargin;
  final String roi;

  EconomicAnalysis({
    required this.costOfCultivation,
    required this.expectedRevenue,
    required this.profitMargin,
    required this.roi,
  });

  factory EconomicAnalysis.fromJson(Map<String, dynamic> json) {
    return EconomicAnalysis(
      costOfCultivation: json['costOfCultivation']?.toString() ?? '',
      expectedRevenue: json['expectedRevenue']?.toString() ?? '',
      profitMargin: json['profitMargin']?.toString() ?? '',
      roi: json['ROI']?.toString() ?? '',
    );
  }
}

class Storage {
  final String shelfLife;
  final String bestStorageConditions;
  final List<String> storageInnovations;

  Storage({
    required this.shelfLife,
    required this.bestStorageConditions,
    required this.storageInnovations,
  });

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      shelfLife: json['shelfLife']?.toString() ?? '',
      bestStorageConditions: json['bestStorageConditions']?.toString() ?? '',
      storageInnovations: (json['storageInnovations'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
    );
  }
}

class PropagationMethods {
  final String seeds;
  final String grafting;
  final String airLayering;
  final String tissueCulture;

  PropagationMethods({
    required this.seeds,
    required this.grafting,
    required this.airLayering,
    required this.tissueCulture,
  });

  factory PropagationMethods.fromJson(Map<String, dynamic> json) {
    return PropagationMethods(
      seeds: json['seeds']?.toString() ?? '',
      grafting: json['grafting']?.toString() ?? '',
      airLayering: json['air-layering']?.toString() ?? '',
      tissueCulture: json['tissueCulture']?.toString() ?? '',
    );
  }
}

class Pest {
  final String name;
  final List<String> symptoms;
  final List<String> controlMethods;
  final String biologicalControl;

  Pest({
    required this.name,
    required this.symptoms,
    required this.controlMethods,
    required this.biologicalControl,
  });

  factory Pest.fromJson(Map<String, dynamic> json) {
    return Pest(
      name: json['name']?.toString() ?? '',
      symptoms: (json['symptoms'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
      controlMethods: (json['controlMethods'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
      biologicalControl: json['biologicalControl']?.toString() ?? '',
    );
  }
}

class Disease {
  final String name;
  final List<String> symptoms;
  final List<String> remedy;

  Disease({
    required this.name,
    required this.symptoms,
    required this.remedy,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['name']?.toString() ?? '',
      symptoms: (json['symptoms'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
      remedy: (json['remedy'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
    );
  }
}

class CompanionPlant {
  final String plant;
  final String benefit;

  CompanionPlant({
    required this.plant,
    required this.benefit,
  });

  factory CompanionPlant.fromJson(Map<String, dynamic> json) {
    return CompanionPlant(
      plant: json['plant']?.toString() ?? '',
      benefit: json['benefit']?.toString() ?? '',
    );
  }
}

class ClimateChangeAdaptation {
  final String floodResistance;
  final String extremeHeatResistance;
  final String stormProtection;

  ClimateChangeAdaptation({
    required this.floodResistance,
    required this.extremeHeatResistance,
    required this.stormProtection,
  });

  factory ClimateChangeAdaptation.fromJson(Map<String, dynamic> json) {
    return ClimateChangeAdaptation(
      floodResistance: json['floodResistance']?.toString() ?? '',
      extremeHeatResistance: json['extremeHeatResistance']?.toString() ?? '',
      stormProtection: json['stormProtection']?.toString() ?? '',
    );
  }
}

class GeneticVariety {
  final String variety;
  final String characteristics;

  GeneticVariety({
    required this.variety,
    required this.characteristics,
  });

  factory GeneticVariety.fromJson(Map<String, dynamic> json) {
    return GeneticVariety(
      variety: json['variety']?.toString() ?? '',
      characteristics: json['characteristics']?.toString() ?? '',
    );
  }
}

class TraditionalUses {
  final String ayurveda;
  final String folkMedicine;
  final List<String> culinaryUses;

  TraditionalUses({
    required this.ayurveda,
    required this.folkMedicine,
    required this.culinaryUses,
  });

  factory TraditionalUses.fromJson(Map<String, dynamic> json) {
    return TraditionalUses(
      ayurveda: json['ayurveda']?.toString() ?? '',
      folkMedicine: json['folkMedicine']?.toString() ?? '',
      culinaryUses: (json['culinaryUses'] as List?)?.map((item) => item.toString()).toList() ?? [], // Null-safe list parsing
    );
  }
}

class FertilizerCalculation {
  final List<StageFertilizer> stages;
  final CalculationMethodology calculationMethodology;

  FertilizerCalculation({
    required this.stages,
    required this.calculationMethodology,
  });

  factory FertilizerCalculation.fromJson(Map<String, dynamic> json) {
    return FertilizerCalculation(
      stages: (json['stages'] as List?)?.map((i) => StageFertilizer.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
      calculationMethodology: json['calculationMethodology'] != null
          ? CalculationMethodology.fromJson(json['calculationMethodology'] as Map<String, dynamic>)
          : CalculationMethodology.fromJson({}), // Provide empty map as default
    );
  }
}

class StageFertilizer {
  final String stage;
  final String fertilizerType;
  final FertilizerQuantity fertilizerQuantity;
  final SoilAdjustment soilAdjustment;
  final String importance;

  StageFertilizer({
    required this.stage,
    required this.fertilizerType,
    required this.fertilizerQuantity,
    required this.soilAdjustment,
    required this.importance,
  });

  factory StageFertilizer.fromJson(Map<String, dynamic> json) {
    return StageFertilizer(
      stage: json['stage']?.toString() ?? '',
      fertilizerType: json['fertilizerType']?.toString() ?? '',
      fertilizerQuantity: json['fertilizerQuantity'] != null
          ? FertilizerQuantity.fromJson(json['fertilizerQuantity'] as Map<String, dynamic>)
          : FertilizerQuantity.fromJson({}), // Provide empty map as default
      soilAdjustment: json['soilAdjustment'] != null
          ? SoilAdjustment.fromJson(json['soilAdjustment'] as Map<String, dynamic>)
          : SoilAdjustment.fromJson({}), // Provide empty map as default
      importance: json['importance']?.toString() ?? '',
    );
  }
}

class FertilizerQuantity {
  final Npk npk;
  final String compost;
  final String frequency;

  FertilizerQuantity({
    required this.npk,
    required this.compost,
    required this.frequency,
  });

  factory FertilizerQuantity.fromJson(Map<String, dynamic> json) {
    return FertilizerQuantity(
      npk: json['NPK'] != null
          ? Npk.fromJson(json['NPK'] as Map<String, dynamic>)
          : Npk.fromJson({}), // Provide empty map as default
      compost: json['compost']?.toString() ?? '',
      frequency: json['frequency']?.toString() ?? '',
    );
  }
}

class Npk {
  final String nitrogen;
  final String phosphorus;
  final String potassium;

  Npk({
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
  });

  factory Npk.fromJson(Map<String, dynamic> json) {
    return Npk(
      nitrogen: json['nitrogen']?.toString() ?? '',
      phosphorus: json['phosphorus']?.toString() ?? '',
      potassium: json['potassium']?.toString() ?? '',
    );
  }
}

class SoilAdjustment {
  final String soilType;
  final ClimateAdjustment climateAdjustment;

  SoilAdjustment({
    required this.soilType,
    required this.climateAdjustment,
  });

  factory SoilAdjustment.fromJson(Map<String, dynamic> json) {
    return SoilAdjustment(
      soilType: json['soilType']?.toString() ?? '',
      climateAdjustment: json['climateAdjustment'] != null
          ? ClimateAdjustment.fromJson(json['climateAdjustment'] as Map<String, dynamic>)
          : ClimateAdjustment.fromJson({}), // Provide empty map as default
    );
  }
}

class ClimateAdjustment {
  final String temperature;
  final String humidity;

  ClimateAdjustment({
    required this.temperature,
    required this.humidity,
  });

  factory ClimateAdjustment.fromJson(Map<String, dynamic> json) {
    return ClimateAdjustment(
      temperature: json['temperature']?.toString() ?? '',
      humidity: json['humidity']?.toString() ?? '',
    );
  }
}

class CalculationMethodology {
  final String fertilizerRequirementFormula;

  CalculationMethodology({
    required this.fertilizerRequirementFormula,
  });

  factory CalculationMethodology.fromJson(Map<String, dynamic> json) {
    return CalculationMethodology(
      fertilizerRequirementFormula: json['fertilizerRequirementFormula']?.toString() ?? '',
    );
  }
}

class GrowthStage {
  final String stage;
  final String duration;
  final CareInstructions careInstructions;
  final List<Task> tasks;

  GrowthStage({
    required this.stage,
    required this.duration,
    required this.careInstructions,
    required this.tasks,
  });

  factory GrowthStage.fromJson(Map<String, dynamic> json) {
    return GrowthStage(
      stage: json['stage']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      careInstructions: json['careInstructions'] != null
          ? CareInstructions.fromJson(json['careInstructions'] as Map<String, dynamic>)
          : CareInstructions.fromJson({}), // Provide empty map as default
      tasks: (json['tasks'] as List?)?.map((i) => Task.fromJson(i as Map<String, dynamic>)).toList() ?? [], // Null-safe list parsing
    );
  }
}

class CareInstructions {
  final String temperature;
  final String soilType;
  final String watering;
  final String sunlight;
  final String fertilization;

  CareInstructions({
    required this.temperature,
    required this.soilType,
    required this.watering,
    required this.sunlight,
    required this.fertilization,
  });

  factory CareInstructions.fromJson(Map<String, dynamic> json) {
    return CareInstructions(
      temperature: json['temperature']?.toString() ?? '',
      soilType: json['soilType']?.toString() ?? '',
      watering: json['watering']?.toString() ?? '',
      sunlight: json['sunlight']?.toString() ?? '',
      fertilization: json['fertilization']?.toString() ?? '',
    );
  }
}

class Task {
  final String taskName;
  final String description;
  final ReminderConfig reminderConfig;

  Task({
    required this.taskName,
    required this.description,
    required this.reminderConfig,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['taskName']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      reminderConfig: json['reminderConfig'] != null
          ? ReminderConfig.fromJson(json['reminderConfig'] as Map<String, dynamic>)
          : ReminderConfig.fromJson({}), // Provide empty map as default
    );
  }
}

class ReminderConfig {
  final String timeFrame;
  final String repeatInterval;
  final String alertDuration;

  ReminderConfig({
    required this.timeFrame,
    required this.repeatInterval,
    required this.alertDuration,
  });

  factory ReminderConfig.fromJson(Map<String, dynamic> json) {
    return ReminderConfig(
      timeFrame: json['timeFrame']?.toString() ?? '',
      repeatInterval: json['repeatInterval']?.toString() ?? '',
      alertDuration: json['alertDuration']?.toString() ?? '',
    );
  }
}