// import 'package:flutter/material.dart';
// import '../Data/DataSource/reminder_database_helper.dart';
// import '../Data/modals/plantevent_model.dart';


// class PlantEventService {
//   final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

//   Future<List<PlantEvent>> getPlantEventsForDate(DateTime date) async {
//     return await _databaseHelper.getPlantEventsForDate(date);
//   }

//   Future<int> addPlantEvent(PlantEvent event) async {
//     return await _databaseHelper.insertPlantEvent(event);
//   }

//   Future<int> updatePlantEvent(PlantEvent event) async {
//     return await _databaseHelper.updatePlantEvent(event);
//   }

//   Future<int> deletePlantEvent(int id) async {
//     return await _databaseHelper.deletePlantEvent(id);
//   }

//   // Example method to initialize with some default data (optional, for first run)
//   Future<void> initializeDefaultEvents() async {
//     DateTime now = DateTime.now();
//     DateTime today = DateTime(now.year, now.month, now.day);

//     List<PlantEvent> defaultEvents = [
//       PlantEvent(
//         plantName: 'Philodendron Plant',
//         condition: 'GOOD',
//         careType: 'Water',
//         careDetails: 'Medium',
//         duration: 'Alternative Days',
//         time: '7:30 AM',
//         image: '',
//         icon: Icons.water_drop,
//         eventDate: today,
//       ),
//       PlantEvent(
//         plantName: 'Bonsai Plant',
//         condition: 'EXCELLENT',
//         careType: 'Water',
//         careDetails: 'Low',
//         duration: '2 Days A Week',
//         time: '7:30 AM',
//         image: '',
//         icon: Icons.water_drop,
//         eventDate: today,
//       ),
//       PlantEvent(
//         plantName: 'Philodendron Plant',
//         condition: 'BAD',
//         careType: 'Fertilize',
//         careDetails: 'Medium',
//         duration: 'Alternative Days',
//         time: '7:30 AM',
//         image: '',
//         icon: Icons.grain,
//         eventDate: today,
//       ),
//       PlantEvent(
//         plantName: 'Sansevieria Plant',
//         condition: 'GOOD',
//         careType: 'Water',
//         careDetails: 'Medium',
//         duration: 'Alternative Days',
//         time: '7:30 AM',
//         image: '',
//         icon: Icons.water_drop,
//         eventDate: today,
//       ),
//     ];

//     // Check if database is empty, if so, insert default events (optional)
//     if ((await _databaseHelper.getPlantEventsForDate(today)).isEmpty) {
//       for (var event in defaultEvents) {
//         await _databaseHelper.insertPlantEvent(event);
//       }
//     }
//   }
// }