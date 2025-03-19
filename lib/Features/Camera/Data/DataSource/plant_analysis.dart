import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';

import '../modals/plantdatamodelv2.dart';

class PlantAnalysisWithGemini {
  late final GenerativeModel _model;
  final String apikey = 'AIzaSyDFi8lfCybcJPIGgJkpEOnlJXzENlhQ184';

  void initializeAI() {
    final config = GenerationConfig(
      temperature: 1,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
      responseSchema: Schema(
        SchemaType.object,
        description: "Detailed information about a plant",
        enumValues: [],
        requiredProperties: ["plant_identification", "plant_description", "health_assessment", "growing_conditions", "common_problems"],
        properties: {
          "plant_identification": Schema(
            SchemaType.object,
            description: "Information about plant identification",
            enumValues: [],
            requiredProperties: ["species"],
            properties: {
              "species": Schema(
                SchemaType.string,
                description: "The species of the plant",
              ),
            },
          ),
          "plant_description": Schema(
            SchemaType.object,
            description: "Description of the plant",
            enumValues: [],
            requiredProperties: ["description"],
            properties: {
              "description": Schema(
                SchemaType.string,
                description: "Botanical description of the plant",
              ),
            },
          ),
          "health_assessment": Schema(
            SchemaType.object,
            description: "Assessment of the plant's health",
            enumValues: [],
            requiredProperties: ["overall_health", "potential_issues"],
            properties: {
              "overall_health": Schema(
                SchemaType.string,
                description: "General assessment of the plant's health (e.g., Good, Fair, Poor)",
              ),
              "potential_issues": Schema(
                SchemaType.array,
                description: "Array of potential health issues and remedies",
                items: Schema(
                  SchemaType.object,
                  enumValues: [],
                  requiredProperties: ["issue", "remedy"],
                  properties: {
                    "issue": Schema(
                      SchemaType.string,
                      description: "Potential health issue (disease, pest, deficiency), can be null if no issue",
                      nullable: true,
                    ),
                    "remedy": Schema(
                      SchemaType.string,
                      description: "Remedy for the potential issue, can be null if no issue",
                      nullable: true,
                    ),
                  },
                ),
              ),
            },
          ),
          "growing_conditions": Schema(
            SchemaType.object,
            description: "Optimal growing conditions for the plant",
            enumValues: [],
            requiredProperties: ["sunlight", "watering", "soil_type"],
            properties: {
              "sunlight": Schema(
                SchemaType.string,
                description: "Optimal sunlight exposure for the plant",
              ),
              "watering": Schema(
                SchemaType.string,
                description: "Watering requirements for the plant",
              ),
              "soil_type": Schema(
                SchemaType.string,
                description: "Optimal soil type for the plant",
              ),
            },
          ),
          "common_problems": Schema(
            SchemaType.object,
            description: "Common problems associated with the plant",
            enumValues: [],
            requiredProperties: ["problems"],
            properties: {
              "problems": Schema(
                SchemaType.array,
                description: "Array of common problems and remedies for the plant",
                items: Schema(
                  SchemaType.object,
                  enumValues: [],
                  requiredProperties: ["issue", "remedy"],
                  properties: {
                    "issue": Schema(
                      SchemaType.string,
                      description: "Common problem that may arise with the plant",
                    ),
                    "remedy": Schema(
                      SchemaType.string,
                      description: "Remedy for the common problem",
                    ),
                  },
                ),
              ),
            },
          ),
        },
      ),
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
      model: 'gemini-2.0-flash',
      apiKey: apikey,
      systemInstruction: Content.system('You are a helpful and informative plant expert. Your task is to analyze images and provide detailed information, specifically about plants. This includes:\n\n  Plant species identification: Based on the image, identify the plant species. If no plant is detected in the image, return "no plant detected" for the species.\n\n  Plant description: Provide a concise botanical description of the plant, including its typical appearance, size, and other distinguishing characteristics.\n\n  Plant health assessment: Provide a general assessment of the plant\'s health, including potential diseases, pests, or nutrient deficiencies. If issues are detected, provide a remedy.\n\n  Growing conditions and care: Recommend the optimal growing conditions for the plant, such as sunlight exposure, watering requirements, and soil type.\n\n  Common problems: Suggest common issues that may arise with this specific plant and how to address them. Provide a remedy for each problem.\n\n  If no plant image is provided, or if the image does not contain a plant, return a JSON object with the same structure as below. In such cases, the "species" field within "plant_identification" should specifically be "no plant detected", and other fields can contain empty or default values as appropriate.\n\n  Ensure that your responses are concise, accurate, and formatted as a JSON object.\n\n  Updated Example JSON Structure:\n\n  {\n    "plant_identification": {\n    "species": "Example Plant Species"  // or "no plant detected" if no plant is in the image\n    },\n    "plant_description": {\n    "description": "A concise botanical description of the plant. Including typical appearance, size, and other distinguishing characteristics."\n    },\n    "health_assessment": {\n    "overall_health": "Good/Fair/Poor",\n    "potential_issues": [\n      {\n      "issue": "Disease A",\n      "remedy": "Specific remedy for Disease A"\n      },\n      {\n      "issue": "Pest B",\n      "remedy": "Specific remedy for Pest B"\n      },\n      {\n      "issue": "Nutrient Deficiency C",\n      "remedy": "Specific remedy for Deficiency C"\n      }\n    ]\n    },\n    "growing_conditions": {\n    "sunlight": "Full sun/Partial shade/Full shade",\n    "watering": "Regular/Moderate/Low",\n    "soil_type": "Well-draining/Loamy/Sandy"\n    },\n    "common_problems": {\n    "problems": [\n      {\n      "issue": "Problem 1",\n      "remedy": "Specific remedy for Problem 1"\n      },\n      {\n      "issue": "Problem 2",\n      "remedy": "Specific remedy for Problem 2"\n      }\n    ]\n    }\n  }'),
      generationConfig: config,
    );
  }


  Future<PlantAnalysisData> plantAnalysisV2(Future<Uint8List> image) async {
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
        final Map<String, dynamic> jsonData = json.decode(text);
        return PlantAnalysisData.fromJson(jsonData);
      } else {
        throw Exception('Empty response from AI.');
      }
    } catch (e) {
      debugPrint('Error in plantAnalysis: $e'); // More specific error handling
      rethrow; // Rethrow to allow higher-level error handling if needed
    }
  }
}



