import 'package:objectbox/objectbox.dart';

@Entity()
class PlantDataEntity {
  // Use objectBoxId as the primary ObjectBox ID (int, auto-incrementing)
  @Id()
  int objectBoxId;
  String id; // Keep your String ID for external references (not ObjectBox ID anymore)
  String plant;
  String type;
  String plantClass;
  String scientificName;
  List<String> imageUrl;
  String description;

  final growingConditions = ToOne<GrowingConditionsEntity>();
  final nutrientRequirements = ToOne<NutrientRequirementsEntity>();
  final pollination = ToOne<PollinationEntity>();
  final harvestInfo = ToOne<HarvestInfoEntity>();
  final propagationMethods = ToOne<PropagationMethodsEntity>();
  final pests = ToMany<PestEntity>();
  final disease = ToMany<DiseaseEntity>();
  final companionPlants = ToMany<CompanionPlantEntity>();
  final climateChangeAdaptation = ToOne<ClimateChangeAdaptationEntity>();
  final geneticVarieties = ToMany<GeneticVarietyEntity>();
  final traditionalUses = ToOne<TraditionalUsesEntity>();
  final fertilizerCalculation = ToOne<FertilizerCalculationEntity>();
  final growthStages = ToMany<GrowthStageEntity>();

  PlantDataEntity({
    this.objectBoxId = 0, // Initialize with default value for auto-increment
    required this.id, // Keep your String ID
    required this.plant,
    required this.type,
    required this.plantClass,
    required this.scientificName,
    required this.imageUrl,
    required this.description,
  });
}

@Entity()
class GrowingConditionsEntity {
  @Id()
  int id = 0;
  String sunlight;
  String water;
  String temperature;
  String humidity;
  String soilType;
  String soilPH;
  final climateSuitability = ToMany<ClimateSuitabilityEntity>();
  String windResistance;
  String frostTolerance;
  String droughtTolerance;

  GrowingConditionsEntity({
    this.id = 0,
    required this.sunlight,
    required this.water,
    required this.temperature,
    required this.humidity,
    required this.soilType,
    required this.soilPH,
    required this.windResistance,
    required this.frostTolerance,
    required this.droughtTolerance,
  });
}

@Entity()
class ClimateSuitabilityEntity {
  @Id()
  int id = 0;
  String region;
  String climate;

  ClimateSuitabilityEntity({
    this.id = 0,
    required this.region,
    required this.climate,
  });
}

@Entity()
class NutrientRequirementsEntity {
  @Id()
  int id = 0;
  final macronutrients = ToOne<MacronutrientsEntity>();
  final micronutrients = ToOne<MicronutrientsEntity>();
  final fertilizerApplication = ToMany<FertilizerApplicationEntity>();

  NutrientRequirementsEntity({
    this.id = 0,
  });
}

@Entity()
class MacronutrientsEntity {
  @Id()
  int id = 0;
  String nitrogen;
  String phosphorus;
  String potassium;

  MacronutrientsEntity({
    this.id = 0,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
  });
}

@Entity()
class MicronutrientsEntity {
  @Id()
  int id = 0;
  String calcium;
  String magnesium;
  String zinc;
  String iron;

  MicronutrientsEntity({
    this.id = 0,
    required this.calcium,
    required this.magnesium,
    required this.zinc,
    required this.iron,
  });
}

@Entity()
class FertilizerApplicationEntity {
  @Id()
  int id = 0;
  String stage;
  String fertilizerType;
  String applicationFrequency;
  String importance;

  FertilizerApplicationEntity({
    this.id = 0,
    required this.stage,
    required this.fertilizerType,
    required this.applicationFrequency,
    required this.importance,
  });
}

@Entity()
class PollinationEntity {
  @Id()
  int id = 0;
  String type;
  List<String> pollinators;
  String floweringSeason;
  String importance;

  PollinationEntity({
    this.id = 0,
    required this.type,
    required this.pollinators,
    required this.floweringSeason,
    required this.importance,
  });
}

@Entity()
class HarvestInfoEntity {
  @Id()
  int id = 0;
  String season;
  String bestHarvestTime;
  String method;
  String yieldPerTree;
  String yieldPerAcre;
  final economicAnalysis = ToOne<EconomicAnalysisEntity>();
  final storage = ToOne<StorageEntity>();

  HarvestInfoEntity({
    this.id = 0,
    required this.season,
    required this.bestHarvestTime,
    required this.method,
    required this.yieldPerTree,
    required this.yieldPerAcre,
  });
}

@Entity()
class EconomicAnalysisEntity {
  @Id()
  int id = 0;
  String costOfCultivation;
  String expectedRevenue;
  String profitMargin;
  String roi;

  EconomicAnalysisEntity({
    this.id = 0,
    required this.costOfCultivation,
    required this.expectedRevenue,
    required this.profitMargin,
    required this.roi,
  });
}

@Entity()
class StorageEntity {
  @Id()
  int id = 0;
  String shelfLife;
  String bestStorageConditions;
  List<String> storageInnovations;

  StorageEntity({
    this.id = 0,
    required this.shelfLife,
    required this.bestStorageConditions,
    required this.storageInnovations,
  });
}

@Entity()
class PropagationMethodsEntity {
  @Id()
  int id = 0;
  String seeds;
  String grafting;
  String airLayering;
  String tissueCulture;

  PropagationMethodsEntity({
    this.id = 0,
    required this.seeds,
    required this.grafting,
    required this.airLayering,
    required this.tissueCulture,
  });
}

@Entity()
class PestEntity {
  @Id()
  int id = 0;
  String name;
  List<String> symptoms;
  List<String> controlMethods;
  String biologicalControl;

  PestEntity({
    this.id = 0,
    required this.name,
    required this.symptoms,
    required this.controlMethods,
    required this.biologicalControl,
  });
}

@Entity()
class DiseaseEntity {
  @Id()
  int id = 0;
  String name;
  List<String> symptoms;
  List<String> remedy;

  DiseaseEntity({
    this.id = 0,
    required this.name,
    required this.symptoms,
    required this.remedy,
  });
}

@Entity()
class CompanionPlantEntity {
  @Id()
  int id = 0;
  String plant;
  String benefit;

  CompanionPlantEntity({
    this.id = 0,
    required this.plant,
    required this.benefit,
  });
}

@Entity()
class ClimateChangeAdaptationEntity {
  @Id()
  int id = 0;
  String floodResistance;
  String extremeHeatResistance;
  String stormProtection;

  ClimateChangeAdaptationEntity({
    this.id = 0,
    required this.floodResistance,
    required this.extremeHeatResistance,
    required this.stormProtection,
  });
}

@Entity()
class GeneticVarietyEntity {
  @Id()
  int id = 0;
  String variety;
  String characteristics;

  GeneticVarietyEntity({
    this.id = 0,
    required this.variety,
    required this.characteristics,
  });
}

@Entity()
class TraditionalUsesEntity {
  @Id()
  int id = 0;
  String ayurveda;
  String folkMedicine;
  List<String> culinaryUses;

  TraditionalUsesEntity({
    this.id = 0,
    required this.ayurveda,
    required this.folkMedicine,
    required this.culinaryUses,
  });
}

@Entity()
class FertilizerCalculationEntity {
  @Id()
  int id = 0;
  final stages = ToMany<StageFertilizerEntity>();
  final calculationMethodology = ToOne<CalculationMethodologyEntity>();

  FertilizerCalculationEntity({
    this.id = 0,
  });
}

@Entity()
class StageFertilizerEntity {
  @Id()
  int id = 0;
  String stage;
  String fertilizerType;
  final fertilizerQuantity = ToOne<FertilizerQuantityEntity>();
  final soilAdjustment = ToOne<SoilAdjustmentEntity>();
  String importance;

  StageFertilizerEntity({
    this.id = 0,
    required this.stage,
    required this.fertilizerType,
    required this.importance,
  });
}

@Entity()
class FertilizerQuantityEntity {
  @Id()
  int id = 0;
  final npk = ToOne<NpkEntity>();
  String compost;
  String frequency;

  FertilizerQuantityEntity({
    this.id = 0,
    required this.compost,
    required this.frequency,
  });
}

@Entity()
class NpkEntity {
  @Id()
  int id = 0;
  String nitrogen;
  String phosphorus;
  String potassium;

  NpkEntity({
    this.id = 0,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
  });
}

@Entity()
class SoilAdjustmentEntity {
  @Id()
  int id = 0;
  String soilType;
  final climateAdjustment = ToOne<ClimateAdjustmentEntity>();

  SoilAdjustmentEntity({
    this.id = 0,
    required this.soilType,
  });
}

@Entity()
class ClimateAdjustmentEntity {
  @Id()
  int id = 0;
  String temperature;
  String humidity;

  ClimateAdjustmentEntity({
    this.id = 0,
    required this.temperature,
    required this.humidity,
  });
}

@Entity()
class CalculationMethodologyEntity {
  @Id()
  int id = 0;
  String fertilizerRequirementFormula;

  CalculationMethodologyEntity({
    this.id = 0,
    required this.fertilizerRequirementFormula,
  });
}

@Entity()
class GrowthStageEntity {
  @Id()
  int id = 0;
  String stage;
  String duration;
  final careInstructions = ToOne<CareInstructionsEntity>();
  final tasks = ToMany<TaskEntity>();

  GrowthStageEntity({
    this.id = 0,
    required this.stage,
    required this.duration,
  });
}

@Entity()
class CareInstructionsEntity {
  @Id()
  int id = 0;
  String temperature;
  String soilType;
  String watering;
  String sunlight;
  String fertilization;

  CareInstructionsEntity({
    this.id = 0,
    required this.temperature,
    required this.soilType,
    required this.watering,
    required this.sunlight,
    required this.fertilization,
  });
}

@Entity()
class TaskEntity {
  @Id()
  int id = 0;
  String taskName;
  String description;
  final reminderConfig = ToOne<ReminderConfigEntity>();

  TaskEntity({
    this.id = 0,
    required this.taskName,
    required this.description,
  });
}

@Entity()
class ReminderConfigEntity {
  @Id()
  int id = 0;
  String timeFrame;
  String repeatInterval;
  String alertDuration;

  ReminderConfigEntity({
    this.id = 0,
    required this.timeFrame,
    required this.repeatInterval,
    required this.alertDuration,
  });
}
