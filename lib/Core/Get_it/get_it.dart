import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../Features/GardenV2/Data/DataSource/dataservice.dart';
import '../../Features/GardenV2/Data/Models/objectbox.g.dart';

final servicelocator = GetIt.instance;

Future<void> setupAndInitDependencies() async {

  // const isrunningwasm = bool.fromEnvironment('dart.tool.dart2asm');
  
  await Hive.initFlutter();
  await Hive.openBox('plantBox');
  // Register the PlantInfo adapter
  Hive.registerAdapter(PlantInfoAdapter());
  Hive.registerAdapter(CareInfoAdapter());

  /// here the error handling logic for removing the grey screen in
  /// the release mode =>
  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Container(
        padding: const EdgeInsets.all(6.0),
        alignment: Alignment.center,
        child: Text("Error\n${details.exception}"),
      );
    };
  }

  /// here the storage is inilialized =>
  final docDir = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: p.join(docDir.path, 'objectbox'));

  // Register ObjectBox instance with GetIt
  final objectboxInstance = ObjectBox(store);
  servicelocator.registerSingleton<ObjectBox>(objectboxInstance);

  // Register MyDataService (it will now get ObjectBox from GetIt)
  servicelocator.registerSingleton<MyDataService>(MyDataService());
}

class ObjectBox {
  final Store store;
  ObjectBox(this.store);
}
