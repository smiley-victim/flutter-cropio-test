
// import 'package:flutter/material.dart';
// import 'package:myapp/Features/Plant%20info%20panelv2/Presentations/Pages/plants_info_detailview.dart';

// class PlantInfoListviewPage extends StatelessWidget {
//   const PlantInfoListviewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         title: const Text("Result for 'Plants'"),
//       ),
//       body: ListView.builder(
//         itemCount: 10, // Replace with your actual data length
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const PlantsInfoDetailview(
//                         plantName: 'plant',
//                         scientificName:'plant scientific name',
//                         imageUrl: "https://picsum.photos/200/300",
//                         description: 'plant description',
                      
//                       ))),
//             child: Container(
//               margin: const EdgeInsets.all(2),
//               padding: EdgeInsets.all(5),
//               height: 150,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 239, 252, 240),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.onPrimaryContainer,
//                         borderRadius: BorderRadius.circular(10),
//                         image: const DecorationImage(
//                           image: NetworkImage("", scale: 1),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 8, top: 10, bottom: 8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Plant Name",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                             ),
//                              Text(
//                               " Scientific Plant Name",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "Plant Description - This is a sample description for the plant. It can be multi-line.",
//                                 maxLines:
//                                     5, // Limit the number of lines for the description
//                                 overflow: TextOverflow
//                                     .ellipsis, // Add ellipsis if the text overflows
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromARGB(255, 10, 104, 13),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


