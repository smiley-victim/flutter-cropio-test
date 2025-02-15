import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PlantAnalysisResultView extends StatelessWidget {
  final String response;
  const PlantAnalysisResultView({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Icons.forest_sharp,
                    size: 28,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plant Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: Text(
                        response,
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
                              'Good',
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
        ],
      ),
    );
  }
}
