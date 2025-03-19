// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// class PlantEvent extends Equatable {
//   final int? id; // Make id nullable and auto-increment in DB
//   final String plantName;
//   final String condition;
//   final String careType;
//   final String careDetails;
//   final String duration;
//   final String time;
//   final String image;
//   final IconData icon;
//   final DateTime eventDate; 

//   const PlantEvent({
//     this.id,
//     required this.plantName,
//     required this.condition,
//     required this.careType,
//     required this.careDetails,
//     required this.duration,
//     required this.time,
//     required this.image,
//     required this.icon,
//     required this.eventDate, 
//   });

//   PlantEvent copyWith({
//     int? id,
//     String? plantName,
//     String? condition,
//     String? careType,
//     String? careDetails,
//     String? duration,
//     String? time,
//     String? image,
//     IconData? icon,
//     DateTime? eventDate,
//   }) {
//     return PlantEvent(
//       id: id ?? this.id,
//       plantName: plantName ?? this.plantName,
//       condition: condition ?? this.condition,
//       careType: careType ?? this.careType,
//       careDetails: careDetails ?? this.careDetails,
//       duration: duration ?? this.duration,
//       time: time ?? this.time,
//       image: image ?? this.image,
//       icon: icon ?? this.icon,
//       eventDate: eventDate ?? this.eventDate,
//     );
//   }


//   @override
//   List<Object?> get props => [id, plantName, condition, careType, careDetails, duration, time, image, icon, eventDate];
// }