import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';

class PlantAnalysisWithGemini {
  late final GenerativeModel _model;
  final String apikey = 'AIzaSyDFi8lfCybcJPIGgJkpEOnlJXzENlhQ184';

  void initializeAI() {
    final config = GenerationConfig(
      maxOutputTokens: 5000,
      temperature: 1.0,
      topP: 1.0,
      topK: 40,
      // responseSchema: Schema.object(properties: {

      // })
    );

    final promptTemplate = Content.system("""
You are a helpful and informative plant expert. Your task is to analyze images of plants and provide detailed information about them, including:

Plant species identification: Based on the image, identify the plant species.

Plant description: Provide a concise botanical description of the plant, including its typical appearance, size, and other distinguishing characteristics.

Plant health assessment: Provide a general assessment of the plant's health, including potential diseases, pests, or nutrient deficiencies. If issues are detected, provide a remedy.

Growing conditions and care: Recommend the optimal growing conditions for the plant, such as sunlight exposure, watering requirements, and soil type.

Common problems: Suggest common issues that may arise with this specific plant and how to address them. Provide a remedy for each problem.

Ensure that your responses are concise, accurate, and formatted as a JSON object.

Updated Example JSON Structure:

{
  "plant_identification": {
    "species": "Example Plant Species"
  },
   "plant_description": {
    "description": "A concise botanical description of the plant. Including typical appearance, size, and other distinguishing characteristics."
   },
  "health_assessment": {
    "overall_health": "Good/Fair/Poor",
    "potential_issues": [
      {
        "issue": "Disease A",
        "remedy": "Specific remedy for Disease A"
      },
     {
        "issue": "Pest B",
        "remedy": "Specific remedy for Pest B"
      },
       {
        "issue": "Nutrient Deficiency C",
        "remedy": "Specific remedy for Deficiency C"
      }
    ]
  },
  "growing_conditions": {
    "sunlight": "Full sun/Partial shade/Full shade",
    "watering": "Regular/Moderate/Low",
    "soil_type": "Well-draining/Loamy/Sandy"
  },
   "common_problems": {
    "problems": [
        {
            "issue": "Problem 1",
            "remedy": "Specific remedy for Problem 1"
        },
        {
            "issue": "Problem 2",
           "remedy": "Specific remedy for Problem 2"
        }
    ]
  }
}

       """);

    _model = GenerativeModel(
      model: 'gemini-1.5-flash-002',
      apiKey: apikey,
      systemInstruction: promptTemplate,
      generationConfig: config,
    );
  }

  Future<String> plantAnalysis(Future<Uint8List> image) async {
    try {
      final imagelist = await image;

      // Ensure the image is in the correct format (MIME type)
      final mimeType = lookupMimeType('', headerBytes: imagelist);

      // Check if the MIME type is valid
      if (mimeType == null ||
          !(mimeType.startsWith('image/jpeg') ||
              mimeType.startsWith('image/png'))) {
        throw Exception(
            'Invalid image format. Please provide a JPEG or PNG image.');
      }

      final content = [
        Content.multi([
          DataPart('image/$mimeType', imagelist),
          TextPart('analysis this image')
        ])
      ];

      final response = await _model.generateContent(content);
      final text = response.text;

      if (text != null && text.isNotEmpty) {
        debugPrint(text);
        return text;
      } else {
        throw Exception('Empty response from AI.');
      }
    } catch (e) {
      debugPrint('Error in plantAnalysis: $e'); // More specific error handling
      rethrow; // Rethrow to allow higher-level error handling if needed
    }
  }

  Future<String> plantAnalysisV2(Future<Uint8List> image) async {
    try {
      final imagelist = await image;

      // Ensure the image is in the correct format (MIME type)
      final mimeType = lookupMimeType('', headerBytes: imagelist);

      // Check if the MIME type is valid
      if (mimeType == null ||
          !(mimeType.startsWith('image/jpeg') ||
              mimeType.startsWith('image/png'))) {
        throw Exception(
            'Invalid image format. Please provide a JPEG or PNG image.');
      }

      final content = [
        Content.multi([
          DataPart('image/$mimeType', imagelist),
          TextPart('analysis this image')
        ])
      ];

      final response = await _model.generateContent(content);
      final text = response.text;

      if (text != null && text.isNotEmpty) {
        debugPrint(text);
        return text;
      } else {
        throw Exception('Empty response from AI.');
      }
    } catch (e) {
      debugPrint('Error in plantAnalysis: $e'); // More specific error handling
      rethrow; // Rethrow to allow higher-level error handling if needed
    }
  }
}
