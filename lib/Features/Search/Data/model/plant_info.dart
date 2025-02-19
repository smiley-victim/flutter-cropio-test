// class PlantInfo {
//   final String id;
//   final String name;
//   final List<String> imageUrl;
//   final String description;
//   final String type;

//   PlantInfo({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.type,
//   });

//   factory PlantInfo.fromJson(Map<String, dynamic> json) {
//     return PlantInfo(
//       id: json['id'],
//       name: json['name'],
//       imageUrl: json['image_url'] != null ? List<String>.from(json['image_url']) : [],
//       description: json['description'],
//       type: json['type'],
//     );
//   }
// }



import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'plant_info.g.dart'; // This is necessary for code generation

@HiveType(typeId: 0)
class PlantInfo  extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String plant;

   @HiveField(2)
  final String type;
  // final String plantClass;
  // final String scientificName;
    @HiveField(3)
  final List<String> imageUrl;
  // final CareInfo careInfo;
    @HiveField(4)
  final String description;
  // final GrowingConditions growingConditions;
  // final List<Disease> diseases;
  // final List<GrowthStage> growthStages;
  // final List<CareProcedure> careProcedures;
  // final SeasonalCare seasonalCare;

  PlantInfo({
    required this.id,
    required this.plant,
    required this.type,
    // required this.plantClass,
    // required this.scientificName,
    required this.imageUrl,
    // required this.careInfo,
    required this.description,
    // required this.growingConditions,
    // required this.diseases,
    // required this.growthStages,
    // required this.careProcedures,
    // required this.seasonalCare,
  });

  factory PlantInfo.fromJson(Map<String, dynamic> json) {
    return PlantInfo(
      id: json['id'],
      plant: json['plant'],
      type: json['type'],
      // plantClass: json['class'],
      // scientificName: json['scientificName'],
      imageUrl: List<String>.from(json['imageUrl']),
      // careInfo: CareInfo.fromJson(json['careInfo']),
      description: json['description'],
      // growingConditions: GrowingConditions.fromJson(json['growing_conditions']),
      // diseases: (json['disease'] as List)
      //     .map((e) => Disease.fromJson(e))
      //     .toList(),
      // growthStages: (json['growthStages'] as List)
      //     .map((e) => GrowthStage.fromJson(e))
      //     .toList(),
      // careProcedures: (json['careProcedures'] as List)
      //     .map((e) => CareProcedure.fromJson(e))
      //     .toList(),
      // seasonalCare: SeasonalCare.fromJson(json['seasonalCare']),
    );
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
}

class GrowingConditions {
  final String sunlight;
  final String water;

  GrowingConditions({
    required this.sunlight,
    required this.water,
  });

  factory GrowingConditions.fromJson(Map<String, dynamic> json) {
    return GrowingConditions(
      sunlight: json['sunlight'],
      water: json['water'],
    );
  }
}

class Disease {
  final String name;
  final List<String> symptoms;
  final List<String> remedy;

  Disease({
    required this.name,
    required this.symptoms,
    required this.remedy,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['name'],
      symptoms: List<String>.from(json['symptoms']),
      remedy: List<String>.from(json['remedy']),
    );
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
}

class SeasonalCare {
  final Season spring;
  final Season summer;
  final Season fall;
  final Season winter;

  SeasonalCare({
    required this.spring,
    required this.summer,
    required this.fall,
    required this.winter,
  });

  factory SeasonalCare.fromJson(Map<String, dynamic> json) {
    return SeasonalCare(
      spring: Season.fromJson(json['spring']),
      summer: Season.fromJson(json['summer']),
      fall: Season.fromJson(json['fall']),
      winter: Season.fromJson(json['winter']),
    );
  }
}

class Season {
  final String icon;
  final List<String> tasks;

  Season({
    required this.icon,
    required this.tasks,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      icon: json['icon'],
      tasks: List<String>.from(json['tasks']),
    );
  }
}

// Function to parse JSON list into a list of PlantInfo objects
// List<PlantInfo> parsePlantInfoList(String jsonString) {
//   final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
//   return (parsed['crops'] as List)
//       .map((json) => PlantInfo.fromJson(json))
//       .toList();
// }
