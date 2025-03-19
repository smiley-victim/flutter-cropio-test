import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/Core/Get_it/get_it.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdata_model.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDataService {
  late final ObjectBox _objectBox;

  late final Box<PlantDataEntity> plantBox; // Add late here
  late final Box<GrowingConditionsEntity> growingConditionsBox; // Add late here
  late final Box<ClimateSuitabilityEntity>
      climateSuitabilityBox; // Add late here
  late final Box<NutrientRequirementsEntity>
      nutrientRequirementsBox; // Add late here
  late final Box<MacronutrientsEntity> macronutrientsBox; // Add late here
  late final Box<ReminderConfigEntity> reminderConfigBox; // Add late here
  late final Box<TaskEntity> taskBox; // Add late here
  late final Box<CareInstructionsEntity> careInstructionsBox; // Add late here
  late final Box<GrowthStageEntity> growthStagesBox; // Add late here
  late final Box<CalculationMethodologyEntity>
      calculationMethodologyBox; // Add late here
  late final Box<FertilizerCalculationEntity>
      fertilizerCalculationBox; // Add late here
  late final Box<SoilAdjustmentEntity> soilAdjustmentBox; // Add late here
  late final Box<ClimateAdjustmentEntity> climateAdjustmentBox; // Add late here
  late final Box<NpkEntity> npkBox; // Add late here
  late final Box<FertilizerQuantityEntity>
      fertilizerQuantityBox; // Add late here
  late final Box<StageFertilizerEntity> stageFertilizerBox; // Add late here
  late final Box<TraditionalUsesEntity> traditionalUsesBox; // Add late here
  late final Box<GeneticVarietyEntity> geneticVarietiesBox; // Add late here
  late final Box<ClimateChangeAdaptationEntity>
      climateChangeAdaptationBox; // Add late here
  late final Box<CompanionPlantEntity> companionPlantsBox; // Add late here
  late final Box<DiseaseEntity> diseaseBox; // Add late here
  late final Box<PestEntity> pestBox; // Add late here
  late final Box<PropagationMethodsEntity>
      propagationMethodsBox; // Add late here
  late final Box<StorageEntity> storageBox; // Add late here
  late final Box<EconomicAnalysisEntity> economicAnalysisBox; // Add late here
  late final Box<HarvestInfoEntity> harvestInfoBox; // Add late here
  late final Box<PollinationEntity> pollinationBox; // Add late here
  late final Box<FertilizerApplicationEntity>
      fertilizerApplicationBox; // Add late here
  late final Box<MicronutrientsEntity> micronutrientsBox; // Add late here

  MyDataService() : _objectBox = GetIt.instance.get<ObjectBox>() {
    plantBox = _objectBox.store.box<PlantDataEntity>();
    growingConditionsBox = _objectBox.store.box<GrowingConditionsEntity>();
    climateSuitabilityBox = _objectBox.store.box<ClimateSuitabilityEntity>();
    nutrientRequirementsBox =
        _objectBox.store.box<NutrientRequirementsEntity>();
    macronutrientsBox = _objectBox.store.box<MacronutrientsEntity>();
    reminderConfigBox = _objectBox.store.box<ReminderConfigEntity>();
    taskBox = _objectBox.store.box<TaskEntity>();
    careInstructionsBox = _objectBox.store.box<CareInstructionsEntity>();
    growthStagesBox = _objectBox.store.box<GrowthStageEntity>();
    calculationMethodologyBox =
        _objectBox.store.box<CalculationMethodologyEntity>();
    fertilizerCalculationBox =
        _objectBox.store.box<FertilizerCalculationEntity>();
    soilAdjustmentBox = _objectBox.store.box<SoilAdjustmentEntity>();
    climateAdjustmentBox = _objectBox.store.box<ClimateAdjustmentEntity>();
    npkBox = _objectBox.store.box<NpkEntity>();
    fertilizerQuantityBox = _objectBox.store.box<FertilizerQuantityEntity>();
    stageFertilizerBox = _objectBox.store.box<StageFertilizerEntity>();
    traditionalUsesBox = _objectBox.store.box<TraditionalUsesEntity>();
    geneticVarietiesBox = _objectBox.store.box<GeneticVarietyEntity>();
    climateChangeAdaptationBox =
        _objectBox.store.box<ClimateChangeAdaptationEntity>();
    companionPlantsBox = _objectBox.store.box<CompanionPlantEntity>();
    diseaseBox = _objectBox.store.box<DiseaseEntity>();
    pestBox = _objectBox.store.box<PestEntity>();
    propagationMethodsBox = _objectBox.store.box<PropagationMethodsEntity>();
    storageBox = _objectBox.store.box<StorageEntity>();
    economicAnalysisBox = _objectBox.store.box<EconomicAnalysisEntity>();
    harvestInfoBox = _objectBox.store.box<HarvestInfoEntity>();
    pollinationBox = _objectBox.store.box<PollinationEntity>();
    fertilizerApplicationBox =
        _objectBox.store.box<FertilizerApplicationEntity>();
    micronutrientsBox = _objectBox.store.box<MicronutrientsEntity>();
  }

 Future<void> addPlantData(PlantData yourPlantData) async {
  debugPrint("DataService - addPlantData START - Plant Name from PlantData: ${yourPlantData.plant}"); // Log at the very beginning

  MacronutrientsEntity macronutrientsEntity = MacronutrientsEntity(
    nitrogen: yourPlantData.nutrientRequirements.macronutrients.nitrogen,
    phosphorus: yourPlantData.nutrientRequirements.macronutrients.phosphorus,
    potassium: yourPlantData.nutrientRequirements.macronutrients.potassium,
  );
  macronutrientsBox.put(macronutrientsEntity);

  MicronutrientsEntity micronutrientsEntity = MicronutrientsEntity(
    calcium: yourPlantData.nutrientRequirements.micronutrients.calcium,
    magnesium: yourPlantData.nutrientRequirements.micronutrients.magnesium,
    zinc: yourPlantData.nutrientRequirements.micronutrients.zinc,
    iron: yourPlantData.nutrientRequirements.micronutrients.iron,
  );
  micronutrientsBox.put(micronutrientsEntity);

  NutrientRequirementsEntity nutrientRequirementsEntity =
      NutrientRequirementsEntity();
  nutrientRequirementsEntity.macronutrients.target = macronutrientsEntity;
  nutrientRequirementsEntity.micronutrients.target = micronutrientsEntity;
  nutrientRequirementsBox.put(nutrientRequirementsEntity);

  GrowingConditionsEntity growingConditionsEntity = GrowingConditionsEntity(
    sunlight: yourPlantData.growingConditions.sunlight,
    water: yourPlantData.growingConditions.water,
    temperature: yourPlantData.growingConditions.temperature,
    humidity: yourPlantData.growingConditions.humidity,
    soilType: yourPlantData.growingConditions.soilType,
    soilPH: yourPlantData.growingConditions.soilPH,
    windResistance: yourPlantData.growingConditions.windResistance,
    frostTolerance: yourPlantData.growingConditions.frostTolerance,
    droughtTolerance: yourPlantData.growingConditions.droughtTolerance,
  );
  growingConditionsBox.put(growingConditionsEntity);

  List<ClimateSuitabilityEntity> climateSuitabilityEntities = [];
  for (var cs in yourPlantData.growingConditions.climateSuitability) {
    ClimateSuitabilityEntity csEntity = ClimateSuitabilityEntity(
      region: cs.region,
      climate: cs.climate,
    );
    climateSuitabilityBox.put(csEntity);
    climateSuitabilityEntities.add(csEntity);
  }
  growingConditionsEntity.climateSuitability
      .addAll(climateSuitabilityEntities);
  growingConditionsBox.put(growingConditionsEntity);

  PollinationEntity pollinationEntity = PollinationEntity(
      type: yourPlantData.pollination.type,
      pollinators: yourPlantData.pollination.pollinators,
      floweringSeason: yourPlantData.pollination.floweringSeason,
      importance: yourPlantData.pollination.importance);
  pollinationBox.put(pollinationEntity);

  EconomicAnalysisEntity economicAnalysisEntity = EconomicAnalysisEntity(
      costOfCultivation:
          yourPlantData.harvestInfo.economicAnalysis.costOfCultivation,
      expectedRevenue:
          yourPlantData.harvestInfo.economicAnalysis.expectedRevenue,
      profitMargin: yourPlantData.harvestInfo.economicAnalysis.profitMargin,
      roi: yourPlantData.harvestInfo.economicAnalysis.roi);
  economicAnalysisBox.put(economicAnalysisEntity);

  StorageEntity storageEntity = StorageEntity(
      shelfLife: yourPlantData.harvestInfo.storage.shelfLife,
      bestStorageConditions:
          yourPlantData.harvestInfo.storage.bestStorageConditions,
      storageInnovations:
          yourPlantData.harvestInfo.storage.storageInnovations);
  storageBox.put(storageEntity);

  HarvestInfoEntity harvestInfoEntity = HarvestInfoEntity(
      season: yourPlantData.harvestInfo.season,
      bestHarvestTime: yourPlantData.harvestInfo.bestHarvestTime,
      method: yourPlantData.harvestInfo.method,
      yieldPerTree: yourPlantData.harvestInfo.yieldPerTree,
      yieldPerAcre: yourPlantData.harvestInfo.yieldPerAcre);
  harvestInfoEntity.economicAnalysis.target = economicAnalysisEntity;
  harvestInfoEntity.storage.target = storageEntity;
  harvestInfoBox.put(harvestInfoEntity);

  PropagationMethodsEntity propagationMethodsEntity =
      PropagationMethodsEntity(
          seeds: yourPlantData.propagationMethods.seeds,
          grafting: yourPlantData.propagationMethods.grafting,
          airLayering: yourPlantData.propagationMethods.airLayering,
          tissueCulture: yourPlantData.propagationMethods.tissueCulture);
  propagationMethodsBox.put(propagationMethodsEntity);

  ClimateChangeAdaptationEntity climateChangeAdaptationEntity =
      ClimateChangeAdaptationEntity(
          floodResistance:
              yourPlantData.climateChangeAdaptation.floodResistance,
          extremeHeatResistance:
              yourPlantData.climateChangeAdaptation.extremeHeatResistance,
          stormProtection:
              yourPlantData.climateChangeAdaptation.stormProtection);
  climateChangeAdaptationBox.put(climateChangeAdaptationEntity);

  TraditionalUsesEntity traditionalUsesEntity = TraditionalUsesEntity(
      ayurveda: yourPlantData.traditionalUses.ayurveda,
      folkMedicine: yourPlantData.traditionalUses.folkMedicine,
      culinaryUses: yourPlantData.traditionalUses.culinaryUses);
  traditionalUsesBox.put(traditionalUsesEntity);

  CalculationMethodologyEntity calculationMethodologyEntity =
      CalculationMethodologyEntity(
          fertilizerRequirementFormula: yourPlantData.fertilizerCalculation
              .calculationMethodology.fertilizerRequirementFormula);
  calculationMethodologyBox.put(calculationMethodologyEntity);

  FertilizerCalculationEntity fertilizerCalculationEntity =
      FertilizerCalculationEntity();
  fertilizerCalculationEntity.calculationMethodology.target =
      calculationMethodologyEntity;
  fertilizerCalculationBox.put(fertilizerCalculationEntity);

  PlantDataEntity plantDataEntity = PlantDataEntity(
    id: yourPlantData.id,
    plant: yourPlantData.plant,
    type: yourPlantData.type,
    plantClass: yourPlantData.plantClass,
    scientificName: yourPlantData.scientificName,
    imageUrl: yourPlantData.imageUrl,
    description: yourPlantData.description,
  );
    debugPrint("DataService - Before target assignments - Plant Name from PlantDataEntity: ${plantDataEntity.plant}"); // Log before target assignments

  plantDataEntity.growingConditions.target = growingConditionsEntity;
  plantDataEntity.nutrientRequirements.target = nutrientRequirementsEntity;
  plantDataEntity.pollination.target = pollinationEntity;
  plantDataEntity.harvestInfo.target = harvestInfoEntity;
  plantDataEntity.propagationMethods.target = propagationMethodsEntity;
  plantDataEntity.climateChangeAdaptation.target =
      climateChangeAdaptationEntity;
  plantDataEntity.traditionalUses.target = traditionalUsesEntity;
  plantDataEntity.fertilizerCalculation.target = fertilizerCalculationEntity;

    debugPrint("DataService - Before plantBox.put - Plant Name from PlantDataEntity: ${plantDataEntity.plant}"); // Log right before put
  plantBox.put(plantDataEntity);
  debugPrint("DataService - After plantBox.put: Plant Name - ${plantDataEntity.plant}"); // Log right after put


  List<PestEntity> pestEntities = [];
  for (var pest in yourPlantData.pests) {
    PestEntity pestEntity = PestEntity(
      name: pest.name,
      symptoms: pest.symptoms,
      controlMethods: pest.controlMethods,
      biologicalControl: pest.biologicalControl,
    );
    pestBox.put(pestEntity);
    pestEntities.add(pestEntity);
  }
  plantDataEntity.pests.addAll(pestEntities);
  plantBox.put(plantDataEntity);

  List<DiseaseEntity> diseaseEntities = [];
  for (var disease in yourPlantData.disease) {
    DiseaseEntity diseaseEntity = DiseaseEntity(
      name: disease.name,
      symptoms: disease.symptoms,
      remedy: disease.remedy,
    );
    diseaseBox.put(diseaseEntity);
    diseaseEntities.add(diseaseEntity);
  }
  plantDataEntity.disease.addAll(diseaseEntities);
  plantBox.put(plantDataEntity);

  List<CompanionPlantEntity> companionPlantEntities = [];
  for (var plant in yourPlantData.companionPlants) {
    CompanionPlantEntity companionPlantEntity = CompanionPlantEntity(
      plant: plant.plant,
      benefit: plant.benefit,
    );
    companionPlantsBox.put(companionPlantEntity);
    companionPlantEntities.add(companionPlantEntity);
  }
  plantDataEntity.companionPlants.addAll(companionPlantEntities);
  plantBox.put(plantDataEntity);

  List<GeneticVarietyEntity> geneticVarietyEntities = [];
  for (var variety in yourPlantData.geneticVarieties) {
    GeneticVarietyEntity geneticVarietyEntity = GeneticVarietyEntity(
      variety: variety.variety,
      characteristics: variety.characteristics,
    );
    geneticVarietiesBox.put(geneticVarietyEntity);
    geneticVarietyEntities.add(geneticVarietyEntity);
  }
  plantDataEntity.geneticVarieties.addAll(geneticVarietyEntities);
  plantBox.put(plantDataEntity);

  List<GrowthStageEntity> growthStageEntities = [];
  for (var stage in yourPlantData.growthStages) {
    GrowthStageEntity growthStageEntity = GrowthStageEntity(
      stage: stage.stage,
      duration: stage.duration,
    );
    CareInstructionsEntity careInstructionsEntity = CareInstructionsEntity(
        temperature: stage.careInstructions.temperature,
        soilType: stage.careInstructions.soilType,
        watering: stage.careInstructions.watering,
        sunlight: stage.careInstructions.sunlight,
        fertilization: stage.careInstructions.fertilization);
    careInstructionsBox.put(careInstructionsEntity);
    growthStageEntity.careInstructions.target = careInstructionsEntity;
    growthStagesBox.put(growthStageEntity);
    growthStageEntities.add(growthStageEntity);

    List<TaskEntity> taskEntities = [];
    for (var task in stage.tasks) {
      TaskEntity taskEntity =
          TaskEntity(taskName: task.taskName, description: task.description);
      ReminderConfigEntity reminderConfigEntity = ReminderConfigEntity(
          timeFrame: task.reminderConfig.timeFrame,
          repeatInterval: task.reminderConfig.repeatInterval,
          alertDuration: task.reminderConfig.alertDuration);
      reminderConfigBox.put(reminderConfigEntity);
      taskEntity.reminderConfig.target = reminderConfigEntity;
      taskBox.put(taskEntity);
      taskEntities.add(taskEntity);
    }
    growthStageEntity.tasks.addAll(taskEntities);
    growthStagesBox.put(growthStageEntity);
  }
  plantDataEntity.growthStages.addAll(growthStageEntities);
  plantBox.put(plantDataEntity);

  List<StageFertilizerEntity> stageFertilizerEntities = [];
  for (var stage in yourPlantData.fertilizerCalculation.stages) {
    StageFertilizerEntity stageFertilizerEntity = StageFertilizerEntity(
        stage: stage.stage,
        fertilizerType: stage.fertilizerType,
        importance: stage.importance);
    FertilizerQuantityEntity fertilizerQuantityEntity =
        FertilizerQuantityEntity(
            compost: stage.fertilizerQuantity.compost,
            frequency: stage.fertilizerQuantity.frequency);
    NpkEntity npkEntity = NpkEntity(
        nitrogen: stage.fertilizerQuantity.npk.nitrogen,
        phosphorus: stage.fertilizerQuantity.npk.phosphorus,
        potassium: stage.fertilizerQuantity.npk.potassium);
    npkBox.put(npkEntity);
    fertilizerQuantityEntity.npk.target = npkEntity;
    fertilizerQuantityBox.put(fertilizerQuantityEntity);
    stageFertilizerEntity.fertilizerQuantity.target =
        fertilizerQuantityEntity;

    SoilAdjustmentEntity soilAdjustmentEntity =
        SoilAdjustmentEntity(soilType: stage.soilAdjustment.soilType);
    ClimateAdjustmentEntity climateAdjustmentEntity = ClimateAdjustmentEntity(
        temperature: stage.soilAdjustment.climateAdjustment.temperature,
        humidity: stage.soilAdjustment.climateAdjustment.humidity);
    climateAdjustmentBox.put(climateAdjustmentEntity);
    soilAdjustmentEntity.climateAdjustment.target = climateAdjustmentEntity;
    soilAdjustmentBox.put(soilAdjustmentEntity);
    stageFertilizerEntity.soilAdjustment.target = soilAdjustmentEntity;
    stageFertilizerBox.put(stageFertilizerEntity);
    stageFertilizerEntities.add(stageFertilizerEntity);
  }
  fertilizerCalculationEntity.stages.addAll(stageFertilizerEntities);
  fertilizerCalculationBox.put(fertilizerCalculationEntity);

  debugPrint('Plant data added to ObjectBox.');
}
  PlantDataEntity? getPlantDataById(int objectBoxId) {
    return plantBox.get(objectBoxId);
  }

  List<PlantDataEntity> getAllPlantData() {
    return plantBox.getAll();
  }

  // List<PlantDataEntity> getPlantsByType(String type) {
  //   final query = plantBox.query(PlantDataEntity_.type.equals(type)).build();
  //   final results = query.find();
  //   query.close();
  //   return results;
  // }
}

Future<Map<String, dynamic>?> fetchPlantDetails(String plantId) async {
  try {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzkzNTc5LCJpYXQiOjE3Mzk4MDE1NzksImp0aSI6ImFhMTI1N2QyZjU0OTQzNjViZThiOTcwMGU0ZWQ0YWQ4IiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.8t8CSE0q5PttQ8KDuQ_NVxHqHtBjzVD5ofA4wAZxZzc',
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'GET',
      Uri.parse('https://beta-api.cropio.in/admin-panel/manage-crops/$plantId/'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      debugPrint("fetchPlantDetails - Raw Response Body: $responseBody"); // <-- Added Log here
      return jsonDecode(responseBody);
    } else {
      debugPrint('Error: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    debugPrint('Error during API call: $e');
    return null;
  }
}