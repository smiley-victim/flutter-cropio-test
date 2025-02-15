
import 'package:flutter/material.dart';

class AnalysisInfoDialog extends StatelessWidget {
  const AnalysisInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton.filledTonal(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Information",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            "This feature helps identify plants by analyzing their images. Simply take a clear picture of the plant's leaves or flowers, and our AI-powered system will provide information about the species, potential diseases, and care tips."),
                        const SizedBox(height: 10),
                        const Text(
                            "For best results, ensure the image is well-lit and focuses on the plant's key features. The analysis may take a few moments to complete."),
                        const SizedBox(height: 10),
                        const Text("Happy gardening!"),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          icon: Icon(Icons.info_outline_rounded)),
    );
  }
}
