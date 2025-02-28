
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';



final servicelocator = GetIt.instance;

Future<void> setupAndInitDependencies() async {
  
  await Hive.initFlutter();
  await Hive.openBox('plantBox');
    // Register the PlantInfo adapter
  Hive.registerAdapter(PlantInfoAdapter());
  // await PlantEventService().initializeDefaultEvents();

  /// here the storage is inilialized =>



}