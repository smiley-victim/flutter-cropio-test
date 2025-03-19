import 'package:flutter/material.dart';


import '../../Data/modals/plantdatamodelv2.dart';
import 'plant_analysis_detail_view.dart';


class PlantAnalysisResultView extends StatelessWidget {
  final PlantAnalysisData response;
  final String? image;

  const PlantAnalysisResultView({super.key, required this.response, this.image});

  @override
  Widget build(BuildContext context) {
    final PlantIdentification? plantIdentification = response.plantIdentification.target;
    final PlantDescription? plantDescription = response.plantDescription.target;
    final HealthAssessment? healthAssessment = response.healthAssessment.target;
    final CommonProblems? commonProblems = response.commonProblems.target;

    return GestureDetector(
      onTap: () => _showAnalysisDetailBottomSheet(context, response, image),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2),
                    color: const Color.fromARGB(255, 136, 239, 139).withOpacity(0.6),
                  ),
                  child: const Icon(
                    Icons.grass,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plantIdentification?.species ?? 'N/A', // Use null-aware operator
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plantDescription?.description ?? 'N/A', // Use null-aware operator
                        style: const TextStyle(fontSize: 12),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      const SizedBox(height: 8),

                      /// **Fixed Condition Box to Show Only One Condition**
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Condition:',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: _getConditionColor(healthAssessment?.overallHealth), // Use null-aware operator
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _getConditionText(healthAssessment?.overallHealth), // Use null-aware operator
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.orange),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        (commonProblems?.problems.isNotEmpty ?? false) // Null-safe check for problems list
                            ? commonProblems?.problems.first.issue ?? "N/A" // Null-safe access to first problem and its issue
                            : "No common problems",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                if ((commonProblems?.problems.isNotEmpty ?? false) && // Null-safe check before accessing first problem
                    (commonProblems?.problems.first.remedy != "N/A")) // Null-safe access to first problem's remedy
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      commonProblems?.problems.first.remedy ?? '', // Null-safe access to remedy
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// **BottomSheet Display Function**
  void _showAnalysisDetailBottomSheet(BuildContext context, PlantAnalysisData response, String? image) {
    showModalBottomSheet(
      showDragHandle: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Dragger
                    _buildBottomSheetDragger(),
                    Expanded(
                      child: PlantsAnalysisDetailview(
                        plantData: response,
                        image: image.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomSheetBackButton(context),
            _buildBottomSheetBookmarkButton(context),
          ],
        );
      },
    );
  }

  /// **Dragger Widget**
  Widget _buildBottomSheetDragger() {
    return Container(
      width: double.infinity,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
      ),
      child: Center(
        child: Container(
          width: 60,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  /// **Back Button Widget**
  Positioned _buildBottomSheetBackButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.09,
      left: 20,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        elevation: 5,
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  /// **Bookmark Button Widget**
  Positioned _buildBottomSheetBookmarkButton(BuildContext ctx) {
    return Positioned(
      top: MediaQuery.of(ctx).size.height * 0.09,
      right: 20,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          // Bookmark functionality
        },
        child: const Icon(Icons.bookmark_border, color: Colors.black),
      ),
    );
  }


  /// **Helper Function to Determine Text**
  String _getConditionText(String? overallHealth) {
    if (overallHealth == null || overallHealth.isEmpty) return "N/A";
    switch (overallHealth.toLowerCase()) {
      case "healthy":
        return "Good";
      case "moderate":
        return "Not Well";
      case "unhealthy":
        return "Bad";
      default:
        return overallHealth; // If any other unexpected value is received
    }
  }

  /// **Helper Function to Set Color Based on Condition**
  Color _getConditionColor(String? overallHealth) {
    if (overallHealth == null || overallHealth.isEmpty) return Colors.grey;
    switch (overallHealth.toLowerCase()) {
      case "healthy":
        return Colors.green;
      case "moderate":
        return Colors.orange;
      case "unhealthy":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}