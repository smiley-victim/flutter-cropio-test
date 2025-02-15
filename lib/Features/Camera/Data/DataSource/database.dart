// import 'package:appwrite/appwrite.dart';
// import 'package:myapp/Core/Get_it/get_it.dart';
// import 'package:myapp/Features/Camera/Data/modals/plantdatamodal.dart';

// abstract class DatabaseService {
//   Future<void> sendAnalysisDataToDB();
//   Future<void> storeDataintoLocalDB();
// }

// abstract class StorageService {
//   Future<void> sendImageToStorage();
// }

// class PlantAnalysisDatabaseService extends DatabaseService {
//   final Databases databases = servicelocator.get<Databases>();
//   @override
//   Future<void> sendAnalysisDataToDB() {
//     return databases.createDocument(
//         databaseId: '674bfa4d003c4c6ee1dd',
//         collectionId: '674bfaa7002f3adb666a',
//         documentId: ID.unique(),
//         data:PlantAnalysisdata(data: 'data', time: DateTime.now()).toMap());
  
//   }

//   @override
//   Future<void> storeDataintoLocalDB() {
//     // TODO: implement storeDataintoLocalDB
//     throw UnimplementedError();
//   }
// }
