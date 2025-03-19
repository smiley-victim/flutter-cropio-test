// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import '../modals/plantevent_model.dart';
// import 'package:path/path.dart' as p;

// class DatabaseHelper {
//   static const _databaseName = "PlantReminderDatabase.db";
//   static const _databaseVersion = 1;
//   static const plantEventTable = 'plant_events';

//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static Database? _database;
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = p.join(documentsDirectory.path, _databaseName);
//     return await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $plantEventTable (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         plantName TEXT NOT NULL,
//         condition TEXT,
//         careType TEXT,
//         careDetails TEXT,
//         duration TEXT,
//         time TEXT,
//         image TEXT,
//         iconCodePoint INTEGER,
//         eventDate INTEGER
//       )
//       ''');
//   }

//   Future<int> insertPlantEvent(PlantEvent event) async {
//     Database db = await instance.database;
//     return await db.insert(plantEventTable, _plantEventToMap(event));
//   }

//   Future<List<PlantEvent>> getPlantEventsForDate(DateTime date) async {
//     Database db = await instance.database;
//     int startOfDay =
//         DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
//     int endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999)
//         .millisecondsSinceEpoch;

//     final List<Map<String, dynamic>> maps = await db.query(
//       plantEventTable,
//       where: 'eventDate >= ? AND eventDate <= ?',
//       whereArgs: [startOfDay, endOfDay],
//     );

//     return List.generate(maps.length, (i) {
//       return _plantEventFromMap(maps[i]);
//     });
//   }

//   Future<int> updatePlantEvent(PlantEvent event) async {
//     Database db = await instance.database;
//     return await db.update(
//       plantEventTable,
//       _plantEventToMap(event),
//       where: "id = ?",
//       whereArgs: [event.id],
//     );
//   }

//   Future<int> deletePlantEvent(int id) async {
//     Database db = await instance.database;
//     return await db.delete(
//       plantEventTable,
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }

//   Map<String, dynamic> _plantEventToMap(PlantEvent event) {
//     return {
//       'plantName': event.plantName,
//       'condition': event.condition,
//       'careType': event.careType,
//       'careDetails': event.careDetails,
//       'duration': event.duration,
//       'time': event.time,
//       'image': event.image,
//       'iconCodePoint': event.icon.codePoint,
//       'eventDate': event.eventDate.millisecondsSinceEpoch,
//     };
//   }

//    PlantEvent _plantEventFromMap(Map<String, dynamic> map) {
//     return PlantEvent(
//       id: map['id'],
//       plantName: map['plantName'],
//       condition: map['condition'],
//       careType: map['careType'],
//       careDetails: map['careDetails'],
//       duration: map['duration'],
//       time: map['time'],
//       image: map['image'],
//       icon: _getIconData(map['iconCodePoint']), // Use the helper function to get constant IconData
//       eventDate: DateTime.fromMillisecondsSinceEpoch(map['eventDate']),
//     );
//   }

//   // Helper function to get constant IconData based on codePoint
//   IconData _getIconData(int iconCodePoint) {
//     switch (iconCodePoint) {
//       case 984482: // Icons.water_drop.codePoint
//         return Icons.water_drop;
//       case 58082: // Icons.grain.codePoint (Seed icon you used)
//         return Icons.grain;
//       // Add cases for other icons you use in your app, get codePoint from IconData.codePoint
//       default:
//         return Icons.error_outline; // Default icon if codePoint doesn't match
//     }
//   }
// }
