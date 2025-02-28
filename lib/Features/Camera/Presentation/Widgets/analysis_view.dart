import 'package:flutter/material.dart';
import 'package:myapp/Features/Camera/Data/modals/plantdatamodal.dart';
import 'package:myapp/Features/Camera/Presentation/Widgets/plant_analysis_detail_view.dart';

class PlantAnalysisResultView extends StatelessWidget {
  final PlantData response;
  final String? image;
  const PlantAnalysisResultView(
      {super.key, required this.response, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlantsAnalysisDetailview(
                  plantData: response, image: image.toString()))),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 17,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.blueGrey, width: 2),
                        color: const Color.fromARGB(255, 136, 239, 139)),
                    child: Icon(
                      Icons.grass,
                      size: 30,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        response.plantIdentification.species,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: Text(
                          response.plantDescription.description,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Text('Condition'),
                          Chip(
                              label: Text(
                                response.healthAssessment.overallHealth,
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              color: WidgetStateProperty.resolveWith(
                                (s) {
                                  return Colors.green;
                                },
                              )),
                        ],
                      )
                    ],
                  )
                ]),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Common Problems"),
                Column(
                  children: response.commonProblems.problems
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.issue,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(e.remedy)
                            ],
                          ))
                      .toList(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
