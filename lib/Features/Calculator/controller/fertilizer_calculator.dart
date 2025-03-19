import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FertilizerCalculator extends GetxController {
  var crops = [].obs; // Store fetched crops
  var stages = [].obs; // Store selected crop stages
  var selectedCrop = Rxn<Map>(); // Selected Crop
  var selectedStage = Rxn<Map>(); // Selected Stage
  var isLoading = true.obs;
  var nitrogen = 0.0.obs;
  var phosphorus = 0.0.obs;
  var potassium = 0.0.obs;
  var urea = 0.0.obs;
  var tsp = 0.0.obs;
  var mop = 0.0.obs;
  var plotSize = 1.0.obs;
  var selectedAreaUnit = "Acre".obs;
  var areaValue = 1.0.obs;
  var plotSizeController = TextEditingController().obs;
  var isCalculated = false.obs;

// Controllers for input fields
  late TextEditingController nitrogenController;
  late TextEditingController phosphorusController;
  late TextEditingController potassiumController;

  Timer? frameRateTimer;

  @override
  void onInit() {
    super.onInit();
    optimizeFrameRate();
    nitrogenController = TextEditingController();
    phosphorusController = TextEditingController();
    potassiumController = TextEditingController();
    plotSizeController.value.text = plotSize.value.toString();

    once(isCalculated, (calculated) {
      if (calculated == true) {
        ever(selectedAreaUnit, (_) => calculateFertilizer1());
        ever(plotSize, (_) => calculateFertilizer1());
        ever(areaValue, (_) => calculateFertilizer1());
        ever(soilPH, (_) => calculateFertilizer1());
      }
    });

    fetchCrops();
  }

  void optimizeFrameRate() {
    frameRateTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      update(); // Reduce updates to avoid excessive rendering
    });
  }

  void updateSelectedAreaUnit(String unit) {
    selectedAreaUnit.value = unit;
    // isCalculated.value = false;
  }

  void updatePlotSize(double size) {
    plotSize.value = size;
    //isCalculated.value = false;
  }

  void increment() {
    plotSize.value += 1;
    plotSizeController.value.text = plotSize.value.toString();
    //isCalculated.value = false;
    //calculateFertilizer1();
  }

  void decrement() {
    if (plotSize.value > 1) {
      plotSize.value -= 1;
      plotSizeController.value.text = plotSize.value.toString();
      //isCalculated.value = false;
      // calculateFertilizer1();
    }
  }

  void updateArea(double value) {
    areaValue.value = value;
    // isCalculated.value = false;
    // calculateFertilizer1();
  }

  var soilPH = 7.0.obs; // Default neutral pH level

  void updateSoilPH(double value) {
    soilPH.value = value;
    // isCalculated.value = false;
    //  calculateFertilizer1();
  }

  void updateFertilizerControllers() {
    if (selectedStage.value != null) {
      nitrogenController.text = selectedStage.value!["fertilizerQuantity"]
              ['stage']["NPK"]["nitrogen"] ??
          "";
      phosphorusController.text = selectedStage.value!["fertilizerQuantity"]
              ['stage']["NPK"]["phosphorus"] ??
          "";
      potassiumController.text = selectedStage.value!["fertilizerQuantity"]
              ['stage']["NPK"]["potassium"] ??
          "";
    }
  }

  @override
  void onClose() {
    frameRateTimer?.cancel();
    nitrogenController.dispose();
    phosphorusController.dispose();
    potassiumController.dispose();
    plotSizeController.value.dispose();
    super.onClose();
  }

  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMzk1ODcyLCJpYXQiOjE3Mzk4MDM4NzIsImp0aSI6ImI1YzJmYmYwODg3MTQxNzhhZDc2MGFmZGQ5YmJmZjAzIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.CBf7zvQU3O3BW3JgMH9kitBRsgmDmzfDMIf4sVQXVz8";

  // API Call to Fetch Crop Data
  Future<void> fetchCrops() async {
    try {
      var response = await Dio().get(
        "https://beta-api.cropio.in/fertilizer/",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      crops.assignAll(response.data['crops']);
    } catch (e) {
      debugPrint("Error fetching crops: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectCrop(Map crop) {
    selectedCrop.value = crop;

    // Debugging: debugPrint API Response
    debugPrint("API Response for Selected Crop: ${jsonEncode(crop)}");

    // Ensure 'fertilizerCalculation' and 'stages' exist before assigning them
    if (crop['fertilizerCalculation']?['stages'] != null &&
        crop['fertilizerCalculation']['stages'] is List) {
      stages.assignAll(crop["fertilizerCalculation"]["stages"]);
    } else {
      stages.clear();
      debugPrint("Error: No stages found for this crop.");
    }

    selectedStage.value = null; // Reset selected stage
  }

  void selectStage(Map stage) {
    selectedStage.value = stage;

    // Ensure 'fertilizerQuantity' and 'NPK' exist before accessing them
    if (stage['fertilizerQuantity']?['NPK'] != null) {
      var npk = stage['fertilizerQuantity']['NPK'];
      debugPrint("Extracted NPK Values: $npk"); // Debugging

      // Function to clean and parse values correctly
      String cleanValue(dynamic value) {
        return value.toString().replaceAll(RegExp(r'[^0-9.]'), '');
      }

      // Assign values only when a stage is selected
      nitrogen.value = double.tryParse(cleanValue(npk['nitrogen'])) ?? 0.0;
      phosphorus.value = double.tryParse(cleanValue(npk['phosphorus'])) ?? 0.0;
      potassium.value = double.tryParse(cleanValue(npk['potassium'])) ?? 0.0;

      nitrogenController.text = nitrogen.value.toString();
      phosphorusController.text = phosphorus.value.toString();
      potassiumController.text = potassium.value.toString();
      update();
    } else {
      debugPrint("Error: No NPK data found in the selected stage.");
      Get.snackbar("Error", "No NPK data found for this stage.");
    }
  }

  void calculateFertilizer1() {
    if (nitrogen.value == 0.0 &&
        phosphorus.value == 0.0 &&
        potassium.value == 0.0) {
      debugPrint(
          " NPK values are still zero. Check if text controllers have values.");
      return;
    }

    double areaFactor = selectedAreaUnit.value == "Acre"
        ? 1
        : selectedAreaUnit.value == "Hectare"
            ? 2.47 // 1 Hectare = 2.47 Acres
            : 0.025; // Gunta = 1/40th of an acre

    double phAdjustmentFactor = getPhFactor(soilPH.value);

    debugPrint("🔹 Selected Area Unit: ${selectedAreaUnit.value}");
    debugPrint("🔹 Area Factor: $areaFactor");
    debugPrint("🔹 Plot Size: ${plotSize.value}");
    debugPrint("🔹 Area Value: ${areaValue.value}");
    debugPrint("🔹 Soil pH: ${soilPH.value}");
    debugPrint("🔹 pH Adjustment Factor: $phAdjustmentFactor");

    urea.value = (nitrogen.value * 2.17 * phAdjustmentFactor) *
        areaValue.value *
        areaFactor *
        plotSize.value;
    tsp.value = (phosphorus.value * 2.0 * phAdjustmentFactor) *
        areaValue.value *
        areaFactor *
        plotSize.value;
    mop.value = (potassium.value * 1.67 * phAdjustmentFactor) *
        areaValue.value *
        areaFactor *
        plotSize.value;

    debugPrint(" Fertilizer Calculations:");
    debugPrint("🔹 Urea: ${urea.value}, TSP: ${tsp.value}, MOP: ${mop.value}");

    isCalculated.value = true;
  }

  double getPhFactor(double soilPH) {
    if (soilPH < 5.5) {
      return 1.2; // Acidic soil needs 20% more fertilizer
    } else if (soilPH >= 5.5 && soilPH <= 7.5) {
      return 1.0; // Neutral soil needs normal fertilizer
    } else {
      return 0.8; // Alkaline soil needs 20% less fertilizer
    }
  }
}
