

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';
// import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/controller/plant_controller.dart';

// class GrowthStagesTimeline extends StatefulWidget {
//  final PlantDataEntity plantData; 

//   GrowthStagesTimeline({Key? key, required this.plantData}) : super(key: key);

//   @override
//   _GrowthStagesTimelineState createState() => _GrowthStagesTimelineState();
// }

// class _GrowthStagesTimelineState extends State<GrowthStagesTimeline> {
//   final PlantController plantController = Get.find();
//   final RxBool showAllStages = false.obs;
//   final List<GlobalKey> cardKeys = [];

//   @override
//   void initState() {
//     super.initState();
//    // plantController.fetchGrowthStages(widget.plantId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (plantController.isLoading.value) {
//         return Center(child: CircularProgressIndicator());
//       }

//       if (plantController.growthStages.isEmpty) {
//         return Center(
//             child: Text(
//           "No Growth Stages Available",
//           style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//         ));
//       }

//       // Assign keys to track height
//       cardKeys.clear();
//       cardKeys.addAll(List.generate(plantController.growthStages.length, (index) => GlobalKey()));

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("🌱 Growth Stages",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Obx(() => TextButton(
//                       onPressed: () {
//                         showAllStages.toggle();
//                       },
//                       child: Text(showAllStages.value ? "View less" : "View All"),
//                     )),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: plantController.growthStages
//                     .asMap()
//                     .entries
//                     .map((entry) =>
//                         buildVerticalStage(entry.value, entry.key, cardKeys[entry.key]))
//                     .toList(),
//               ),
//             ),
//           )
//         ],
//       );
//     });
//   }

//   Widget buildVerticalStage(Map<String, dynamic> stage, int index, GlobalKey key) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Icon(Icons.local_florist, size: 20, color: Colors.grey),
//            // if (index != plantController.growthStages.length - 1)
//               FutureBuilder<double>(
//                 future: getCardHeight(key),
//                 builder: (context, snapshot) {
//                   return Container(
//                     width: 2,
//                     height: snapshot.data ?? 60, // Dynamic height
//                     color:  Colors.grey.withOpacity(0.5),
//                   );
//                 },
//               ),
//           ],
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           child: Card(
//             key: key,
//             color: Colors.white,
//             margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(stage["stage"],
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 4),
//                   Text("Duration: ${stage["duration"]}",
//                       style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
//                   Divider(),
//                   Text("Tasks",
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   ...stage["tasks"]
//                       .map<Widget>((task) => buildTaskCard(task))
//                       .toList(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<double> getCardHeight(GlobalKey key) async {
//     await Future.delayed(Duration(milliseconds: 100)); // Wait for UI build
//     final context = key.currentContext;
//     if (context != null) {
//       final renderBox = context.findRenderObject() as RenderBox;
//       return renderBox.size.height;
//     }
//     return 60; // Default height
//   }

//   Widget buildTaskCard(Map<String, dynamic> task) {
//     return Card(
//       color: Colors.grey.shade100,
//       elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: 4),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: ListTile(
//         title: Text(task["taskName"]),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(task["description"], style: TextStyle(fontSize: 13)),
//             SizedBox(height: 4),
//             Text("🕒  ${task["reminderConfig"]["timeFrame"]}",
//                 style: TextStyle(fontSize: 13, color: Colors.black87)),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Features/GardenV2/Data/Models/plantdataentity_model.dart';

class GrowthStagesTimeline extends StatefulWidget {
  final PlantDataEntity plantData;

  GrowthStagesTimeline({Key? key, required this.plantData}) : super(key: key);

  @override
  _GrowthStagesTimelineState createState() => _GrowthStagesTimelineState();
}

class _GrowthStagesTimelineState extends State<GrowthStagesTimeline> {
  final RxBool showAllStages = false.obs;
  final List<GlobalKey> cardKeys = [];

  @override
  Widget build(BuildContext context) {
    // Check if plantData has growth stages
    if (widget.plantData.growthStages.isEmpty) {
      return Center(
        child: Text(
          "No Growth Stages Available",
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      );
    }

    // Assign keys to track height
    cardKeys.clear();
    cardKeys.addAll(List.generate(widget.plantData.growthStages.length, (index) => GlobalKey()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("🌱 Growth Stages",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Obx(() => TextButton(
                    onPressed: () {
                      showAllStages.toggle();
                    },
                    child: Text(showAllStages.value ? "View less" : "View All"),
                  )),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.plantData.growthStages
                  .asMap()
                  .entries
                  .map((entry) => buildVerticalStage(entry.value, entry.key, cardKeys[entry.key]))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget buildVerticalStage(GrowthStageEntity stage, int index, GlobalKey key) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.local_florist, size: 20, color: Colors.grey),
            FutureBuilder<double>(
              future: getCardHeight(key),
              builder: (context, snapshot) {
                return Container(
                  width: 2,
                  height: snapshot.data ?? 60, // Dynamic height
                  color: Colors.grey.withOpacity(0.5),
                );
              },
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Card(
            key: key,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stage.stage,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Duration: ${stage.duration}",
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
                  Divider(),
                  Text("Tasks",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ...stage.tasks.map((task) => buildTaskCard(task)).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<double> getCardHeight(GlobalKey key) async {
    await Future.delayed(Duration(milliseconds: 100)); // Wait for UI build
    final context = key.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }
    return 60; // Default height
  }

  Widget buildTaskCard(TaskEntity task) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(task.taskName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, style: TextStyle(fontSize: 13)),
            SizedBox(height: 4),
            Text("🕒  ${task.reminderConfig.target?.timeFrame}",
                style: TextStyle(fontSize: 13, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

