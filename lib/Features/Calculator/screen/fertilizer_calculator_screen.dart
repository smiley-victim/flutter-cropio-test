import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Features/Calculator/widget/btn_widget.dart';
import '../controller/fertilizer_calculator.dart';


class FertilizerCalculatorScreen extends StatelessWidget {
  final FertilizerCalculator fertilizerCalculator =
      Get.put(FertilizerCalculator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fertilizer Calculator")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (fertilizerCalculator.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    image: fertilizerCalculator
                                .selectedCrop.value?["imageUrl"] !=
                            null
                        ? DecorationImage(
                            image: NetworkImage(
                              fertilizerCalculator
                                      .selectedCrop.value!["imageUrl"] is List
                                  ? fertilizerCalculator
                                      .selectedCrop.value!["imageUrl"].first
                                      .toString() // Extract first URL if it's a list
                                  : fertilizerCalculator
                                      .selectedCrop.value!["imageUrl"]
                                      .toString(), // Convert to string
                            ),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              print("Image load failed: $exception");
                            },
                          )
                        : DecorationImage(
                            image: AssetImage('assets/images/placeholder.png'),
                            fit: BoxFit.cover,
                          ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(
                  height: 4,
                ),

                //  Crop Selection Dropdown
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<Map<dynamic, dynamic>>(
                    hint: Text("Select Crop"),
                    value: fertilizerCalculator.selectedCrop.value,
                    isExpanded: true,
                    items: fertilizerCalculator.crops.map((crop) {
                      return DropdownMenuItem<Map<dynamic, dynamic>>(
                        value: crop,
                        child: Text(crop["plant"]),
                      );
                    }).toList(),
                    underline: SizedBox.shrink(),
                    onChanged: (crop) {
                      if (crop != null) fertilizerCalculator.selectCrop(crop);
                    },
                  ),
                ),
                SizedBox(height: 5),

                // 🔹 Stage Selection Dropdown
                if (fertilizerCalculator.selectedCrop.value != null)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<Map<dynamic, dynamic>>(
                      hint: Text("Select Growth Stage"),
                      value: fertilizerCalculator.selectedStage.value,
                      isExpanded: true,
                      items: fertilizerCalculator.stages
                          .map<DropdownMenuItem<Map>>((stage) {
                        return DropdownMenuItem(
                          value: stage,
                          child: Text(stage["stage"] ?? "unknown"),
                        );
                      }).toList(),
                      underline: SizedBox.shrink(),
                      onChanged: (stage) {
                        if (stage != null) {
                          fertilizerCalculator.selectStage(stage);
                          fertilizerCalculator.updateFertilizerControllers();
                        }
                      },
                    ),
                  ),

                SizedBox(height: 10),

                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white, // Shadow color
                          blurRadius: 10, // Soften the shadow
                          spreadRadius: 2, // Extend the shadow
                          offset: Offset(0, 4), // Move shadow downwards
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Slider(
                          value: fertilizerCalculator.soilPH.value,
                          min: 0,
                          max: 14,
                          divisions: 14,
                          activeColor: const Color.fromARGB(255, 2, 141, 6),
                          inactiveColor: Colors.grey,
                          label: fertilizerCalculator.soilPH.value
                              .toStringAsFixed(1),
                          onChanged: (value) =>
                              fertilizerCalculator.updateSoilPH(value),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Acidic(0)",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700),
                            ),
                            Text(
                              "Neutral(7)",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700),
                            ),
                            Text(
                              "Alkaline(14)",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4),
                // Display Soil pH Value
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Obx(() => Text(
                        "pH Level: ${fertilizerCalculator.soilPH.value.toStringAsFixed(1)}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                ),

                SizedBox(height: 10),

                // 📏 Area Selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text("Select Area Unit:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ["Acre", "Hectare", "Gunta"].map((unit) {
                        return Row(
                          children: [
                            Radio(
                              value: unit,
                              groupValue:
                                  fertilizerCalculator.selectedAreaUnit.value,
                              onChanged: (value) {
                                fertilizerCalculator.selectedAreaUnit.value =
                                    value.toString();
                              },
                            ),
                            Text(unit),
                          ],
                        );
                      }).toList(),
                    )),
                SizedBox(
                  height: 5,
                ),

                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Remove Button
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: fertilizerCalculator.decrement,
                      ),
                      // Text Field
                      SizedBox(
                        width: 180,
                        child: TextField(
                          controller:
                              fertilizerCalculator.plotSizeController.value,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            fertilizerCalculator.plotSize.value =
                                double.tryParse(value) ?? 1.0;
                          },
                        ),
                      ),
                      // Add Button
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: fertilizerCalculator.increment,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                // Editable NPK Input Fields

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, // Shadow color
                        blurRadius: 10, // Soften the shadow
                        spreadRadius: 2, // Extend the shadow
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: fertilizerCalculator.nitrogenController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 1, 111, 5),
                              width: 2),
                        ),
                        labelText: "Nitrogen (N)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => fertilizerCalculator.nitrogen.value =
                        double.tryParse(value) ?? 0.0,
                  ),
                ),

                SizedBox(height: 4),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, // Shadow color
                        blurRadius: 10, // Soften the shadow
                        spreadRadius: 2, // Extend the shadow
                        offset: Offset(0, 4), // Move shadow downwards
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: fertilizerCalculator.phosphorusController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          // Border when focused
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 1, 111, 5),
                              width: 2),
                        ),
                        labelText: "Phosphorus (P)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => fertilizerCalculator
                        .phosphorus.value = double.tryParse(value) ?? 0.0,
                  ),
                ),

                SizedBox(height: 4),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, // Shadow color
                        blurRadius: 6, // Soften the shadow
                        spreadRadius: 2, // Extend the shadow
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: fertilizerCalculator.potassiumController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 1, 111, 5),
                              width: 2),
                        ),
                        labelText: "Potassium (K)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => fertilizerCalculator.potassium.value =
                        double.tryParse(value) ?? 0.0,
                  ),
                ),

                SizedBox(height: 20),

                // Calculate Button
                Center(
                    child: FadeScaleButton(
                        text: "Calculate",
                        onPressed: () {
                          fertilizerCalculator.isCalculated.value = true;
                          fertilizerCalculator.calculateFertilizer1();
                        })),

                SizedBox(height: 20),

                // Result Section
                Obx(() {
                  if (fertilizerCalculator.isCalculated.value) {
                    return Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 200, 244, 201),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Fertilizer Required Mix:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Urea :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Obx(
                                    () => Text(
                                        "${fertilizerCalculator.urea.value.toStringAsFixed(0)} kg",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("TSP :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Obx(
                                    () => Text(
                                        "${fertilizerCalculator.tsp.value.toStringAsFixed(0)} kg",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("MOP :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Obx(
                                    () => Text(
                                        "${fertilizerCalculator.mop.value.toStringAsFixed(0)} kg",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              // fetch recommended  fertilizer
                              Text(
                                "Fertilizer Type - ${fertilizerCalculator.selectedStage.value!["fertilizerType"]}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),

                SizedBox(height: 4),

                // Show NPK Values
                if (fertilizerCalculator.isCalculated.value == true)
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: const Color.fromARGB(255, 243, 246, 242),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("** NOTE **",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(
                                  "🌱  Stage  - ${fertilizerCalculator.selectedStage.value!["stage"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              SizedBox(height: 2),
                              Text(
                                  "🔄  Frequency  - ${fertilizerCalculator.selectedStage.value!["fertilizerQuantity"]["frequency"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              SizedBox(height: 2),
                              Text(
                                  "🧑‍🌾  Soil Type  - ${fertilizerCalculator.selectedStage.value!["soilAdjustment"]["soilType"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              SizedBox(height: 2),
                              Text(
                                  "🌡️  Temperature  - ${fertilizerCalculator.selectedStage.value!["soilAdjustment"]["climateAdjustment"]["temperature"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              SizedBox(height: 2),
                              Text(
                                  "💦  Humidity  - ${fertilizerCalculator.selectedStage.value!["soilAdjustment"]["climateAdjustment"]["humidity"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              SizedBox(height: 2),
                              Text(
                                  "⭐  Importance -  ${fertilizerCalculator.selectedStage.value!["importance"]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
