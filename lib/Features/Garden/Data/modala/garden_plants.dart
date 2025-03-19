// plant_models.dart
import 'package:flutter/material.dart';

class Crop {
  final String id;
  final String name;
  final String imageUrl;
  final CareInfo careInfo;
  final List<GrowthStage> growthStages;
  final List<CareProcedure> careProcedures;
  final SeasonalCare seasonalCare;
  final List<CommonIssue> commonIssues;

  Crop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.careInfo,
    required this.growthStages,
    required this.careProcedures,
    required this.seasonalCare,
    required this.commonIssues,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      careInfo: CareInfo.fromJson(json['careInfo']),
      growthStages: (json['growthStages'] as List)
          .map((stage) => GrowthStage.fromJson(stage))
          .toList(),
      careProcedures: (json['careProcedures'] as List)
          .map((procedure) => CareProcedure.fromJson(procedure))
          .toList(),
      seasonalCare: SeasonalCare.fromJson(json['seasonalCare']),
      commonIssues: (json['commonIssues'] as List)
          .map((issue) => CommonIssue.fromJson(issue))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'careInfo': careInfo.toJson(),
      'growthStages': growthStages.map((stage) => stage.toJson()).toList(),
      'careProcedures': careProcedures.map((procedure) => procedure.toJson()).toList(),
      'seasonalCare': seasonalCare.toJson(),
      'commonIssues': commonIssues.map((issue) => issue.toJson()).toList(),
    };
  }
}



class CareInfo {
  final String waterNeeds;
  final String light;
  final String temperature;
  final String maxHeight;
  final String humidity;

  CareInfo({
    required this.waterNeeds,
    required this.light,
    required this.temperature,
    required this.maxHeight,
    required this.humidity,
  });

  factory CareInfo.fromJson(Map<String, dynamic> json) {
    return CareInfo(
      waterNeeds: json['waterNeeds'],
      light: json['light'],
      temperature: json['temperature'],
      maxHeight: json['maxHeight'],
      humidity: json['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waterNeeds': waterNeeds,
      'light': light,
      'temperature': temperature,
      'maxHeight': maxHeight,
      'humidity': humidity,
    };
  }
}

class GrowthStage {
  final String stage;
  final String duration;
  final String description;
  final List<String> careInstructions;

  GrowthStage({
    required this.stage,
    required this.duration,
    required this.description,
    required this.careInstructions,
  });

  factory GrowthStage.fromJson(Map<String, dynamic> json) {
    return GrowthStage(
      stage: json['stage'],
      duration: json['duration'],
      description: json['description'],
      careInstructions: List<String>.from(json['careInstructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stage': stage,
      'duration': duration,
      'description': description,
      'careInstructions': careInstructions,
    };
  }
}

class CareProcedure {
  final String title;
  final String description;
  final List<String> tips;
  final String icon;

  CareProcedure({
    required this.title,
    required this.description,
    required this.tips,
    required this.icon,
  });

  factory CareProcedure.fromJson(Map<String, dynamic> json) {
    return CareProcedure(
      title: json['title'],
      description: json['description'],
      tips: List<String>.from(json['tips']),
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tips': tips,
      'icon': icon,
    };
  }
}

class SeasonalCare {
  final SeasonalTasks spring;
  final SeasonalTasks summer;
  final SeasonalTasks fall;
  final SeasonalTasks winter;

  SeasonalCare({
    required this.spring,
    required this.summer,
    required this.fall,
    required this.winter,
  });

  factory SeasonalCare.fromJson(Map<String, dynamic> json) {
    return SeasonalCare(
      spring: SeasonalTasks.fromJson(json['spring']),
      summer: SeasonalTasks.fromJson(json['summer']),
      fall: SeasonalTasks.fromJson(json['fall']),
      winter: SeasonalTasks.fromJson(json['winter']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spring': spring.toJson(),
      'summer': summer.toJson(),
      'fall': fall.toJson(),
      'winter': winter.toJson(),
    };
  }
}

class SeasonalTasks {
  final String icon;
  final List<String> tasks;

  SeasonalTasks({
    required this.icon,
    required this.tasks,
  });

  factory SeasonalTasks.fromJson(Map<String, dynamic> json) {
    return SeasonalTasks(
      icon: json['icon'],
      tasks: List<String>.from(json['tasks']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'tasks': tasks,
    };
  }
}

class CommonIssue {
  final String issue;
  final List<String> causes;
  final String solution;

  CommonIssue({
    required this.issue,
    required this.causes,
    required this.solution,
  });

  factory CommonIssue.fromJson(Map<String, dynamic> json) {
    return CommonIssue(
      issue: json['issue'],
      causes: List<String>.from(json['causes']),
      solution: json['solution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issue': issue,
      'causes': causes,
      'solution': solution,
    };
  }
}


///?? here the sample for testing purposes
final Crop monstera = Crop(
    id: "676ebbf9a6c62a7ad5a6a935",
    name: "Sunflower",
    imageUrl: "https://example.com/sunflower.jpg",
    careInfo: CareInfo(
      waterNeeds: "High",
      light: "Full sun",
      temperature: "15-30°C",
      maxHeight: "1-3 meters",
      humidity: "Low",
    ),
    growthStages: [
      GrowthStage(
        stage: "Seedling",
        duration: "1-2 weeks",
        description: "First leaves emerge.",
        careInstructions: ["Keep soil moist", "Provide ample light"],
      ),
      GrowthStage(
        stage: "Vegetative",
        duration: "4-6 weeks",
        description: "Rapid growth of stem and leaves.",
        careInstructions: ["Regular watering", "Fertilize weekly"],
      ),
      GrowthStage(
        stage: "Flowering",
        duration: "2-3 weeks",
        description: "Development of the iconic flower head.",
        careInstructions: ["Support stem if needed", "Monitor for pests"],
      ),
    ],
    careProcedures: [
      CareProcedure(
        title: "Watering",
        description: "Water deeply and regularly, especially during hot weather.",
        tips: ["Water at the base", "Avoid overhead watering"],
        icon: "water_drop",
      ),
      CareProcedure(
        title: "Light",
        description: "Requires at least 6-8 hours of direct sunlight daily.",
        tips: ["Plant in a sunny location"],
        icon: "wb_sunny",
      ),
    ],
    seasonalCare: SeasonalCare(
      spring: SeasonalTasks(
        icon: "local_florist",
        tasks: ["Sow seeds outdoors", "Prepare soil"],
      ),
      summer: SeasonalTasks(
        icon: "wb_sunny",
        tasks: ["Provide support", "Monitor for pests"],
      ),
      fall: SeasonalTasks(
        icon: "eco",
        tasks: ["Harvest seeds", "Cut down stalks"],
      ),
      winter: SeasonalTasks(
        icon: "ac_unit",
        tasks: ["No specific care needed for annual varieties"],
      ),
    ),
    commonIssues: [
      CommonIssue(
        issue: "Downy Mildew",
        causes: ["High humidity", "Poor air circulation"],
        solution: "Improve air circulation, apply fungicide.",
      ),
    ],
    // scientificName: "Helianthus annuus",
    // description: "A tall annual plant with a large, bright flower head.",
    // type: "Annual Flower",
    // additionalInfo: AdditionalInfo(
    //   uses: ["Oil production", "Birdseed", "Ornamental"],
    //   symbolism: "Adoration, loyalty, longevity",
    //),
  );





/// ?? here the helper fot the [care Procedure] attributes icons in enum
/// format
/// 
 IconData getIconData(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'thermostat':
        return Icons.thermostat;
      case 'straighten':
        return Icons.straighten;
      case 'eco':
        return Icons.eco;
      // Add more cases as needed
      default:
        return Icons.help_outline; // Default icon if name not found
    }
  }