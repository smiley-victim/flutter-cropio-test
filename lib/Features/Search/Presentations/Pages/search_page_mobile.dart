import 'package:flutter/material.dart';
import 'package:myapp/Features/Garden/Data/modala/garden_plants.dart';
import 'package:myapp/Features/Plant%20info%20panel/Presentations/Pages/plant_info_listview.dart';
import 'package:myapp/Features/Plant%20info%20panel/Presentations/Pages/plants_info_detailview.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';
import 'package:myapp/Features/Search/Data/search_service.dart';
import '../Widgets/search_chips.dart';

// class SearchPageMobile extends StatefulWidget {
//   const SearchPageMobile({super.key});

//   @override
//   State<SearchPageMobile> createState() => _SearchPageMobileState();
// }

// class _SearchPageMobileState extends State<SearchPageMobile> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: 'searchPage',
//       transitionOnUserGestures: true,
//       createRectTween: (begin, end) {
//         return MaterialRectCenterArcTween(begin: begin, end: end);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Search Plants',
//               style: TextStyle(fontWeight: FontWeight.bold)),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Search Bar
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: const InputDecoration(
//                     hintText: 'Search for plants...',
//                     border: InputBorder.none,
//                     prefixIcon: Icon(Icons.search),
//                     // contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16.0),

//               // Suggestions Section
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: const Text(
//                   'Suggestions:',
//                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                 ),
//               ),

//               const SizedBox(height: 12.0),

//               // Suggestion Chips
//               SearchSuggestionChips(
//                 suggestions: [
//                   'Monstera',
//                   'Succulents',
//                   'Cactus',
//                   'Fern',
//                   'Bonsai'
//                 ],
//               ),
//               const SizedBox(height: 24.0),
//               // Info for the user
//               Center(
//                 child: Column(
//                   children: const [
//                     Text(
//                   'Search for plants by name, type, or characteristic.',
//                       style: TextStyle(fontSize: 14.0, color: Colors.grey),
//                 ),
//                     SizedBox(height: 8.0),
//                     Text('Tap on suggestions for quick search.',
//                         style: TextStyle(fontSize: 14.0, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../Widgets/search_chips.dart';

class SearchPageMobile extends StatefulWidget {
  const SearchPageMobile({super.key});

  @override
  State<SearchPageMobile> createState() => _SearchPageMobileState();
}

class _SearchPageMobileState extends State<SearchPageMobile> {
  final TextEditingController _searchController = TextEditingController();
  List<PlantInfo> _allCrops = [];
  List<PlantInfo> _searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadCrops();
  }

  /// Fetch crops from API
  Future<void> _loadCrops() async {
    List<PlantInfo> crops = await SearchService.fetchCrops();
    setState(() {
      _allCrops = crops;
      _searchResults = crops;
    });
  }

  /// Perform search when user types
  void _onSearchChanged(String query) {
  setState(() {
    if (query.isEmpty) {
      isSearching = false;
      _searchResults = []; // Reset search results to show suggestions
    } else {
      isSearching = true;
      _searchResults = SearchService.searchCrops(query, _allCrops);
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchPage',
      transitionOnUserGestures: true,
      createRectTween: (begin, end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search Plants',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for plants...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              const SizedBox(height: 16.0),

              // Conditionally show suggestions or search results
              Expanded(
                child: isSearching && _searchResults.isEmpty
                    ? const Center(child: Text("No plants found")) : !isSearching ? Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Suggestions:',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12.0),

                          // Search Suggestion Chips
                          SearchSuggestionChips(
                            suggestions: [
                              'Monstera',
                              'Succulents',
                              'Cactus',
                            ],
                          ),

                          const SizedBox(height: 24.0),

                          // Informational Text
                          Center(
                            child: Column(
                              children: const [
                                Text(
                                  'Search for plants by name, type, or characteristic.',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Tap on suggestions for quick search.',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          PlantInfo plant = _searchResults[index];
                          // return ListTile(
                          //   title: Text(plant.name),
                          //   subtitle: Text(plant.description),
                          //   leading: plant.imageUrl.isNotEmpty
                          //       ? Image.network(plant.imageUrl[0],
                          //           width: 50, height: 50)
                          //       : const Icon(Icons.image_not_supported),
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => PlantInfoListviewPage(
                          //           plantName: plant.name,
                          //           imageUrl: plant.imageUrl[0],
                          //           description: plant.description,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlantsInfoDetailview(
                                        plantName: plant.name,
                                        imageUrl: plant.imageUrl[0],
                                        description: plant.description,
                                      ),
                                    ),
                                  );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              padding: EdgeInsets.all(5),
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 252, 240),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(plant.imageUrl[0],
                                              scale: 1),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 8,
                                            top: 10,
                                            bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              plant.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                plant.description,
                                                maxLines:
                                                    5, // Limit the number of lines for the description
                                                overflow: TextOverflow
                                                    .ellipsis, // Add ellipsis if the text overflows
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 10, 104, 13),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class PlantInfoListviewPage extends StatelessWidget {
//   const PlantInfoListviewPage({
//     super.key,
//     required this.plantName,
//     required this.imageUrl,
//     required this.description,
//   });
//   final String plantName;
//   final String imageUrl;
//   final String description;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         title: Text("Details of $plantName"),
//         // title: const Text("Result for 'Plants'"),
//       ),
//       body: ListView.builder(
//         itemCount: 2, // Replace with your actual data length
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PlantsInfoDetailview(
//                   plantName: plantName,
//                   imageUrl: imageUrl,
//                   description: description,
//                 ),
//               ),
//             ),
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
//                         image: DecorationImage(
//                           image: NetworkImage(imageUrl, scale: 1),
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
//                               plantName,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 description,
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
