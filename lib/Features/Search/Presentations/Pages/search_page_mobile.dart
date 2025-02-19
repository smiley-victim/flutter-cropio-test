import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/Features/Plant%20info%20panel/Presentations/Pages/plants_info_detailview.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';
import 'package:myapp/Features/Search/Data/services/fetch_all_plant_name.dart';
import 'package:myapp/Features/Search/Data/services/search_service.dart';
import '../Widgets/search_chips.dart';

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
  List<String> plantTypes = [];
  String? selectedType;
  List<String> plantNames = [];
  int currentIndex = 0;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadCrops();
    selectedType = 'All';
    fetchAllPlantName();
    fetchPlantTypes();
  }

  Future<void> fetchPlantTypes() async {
    List<String> fetchPlantTypes = await FetchPlantTypes.fetchingPlantTypes();

    if (fetchPlantTypes.isNotEmpty) {
      setState(() {
        plantTypes = ['All', ...fetchPlantTypes];
        print(plantTypes);
      });
    } else {
      print("No plant types found.");
    }
  }

  Future<void> fetchAllPlantName() async {
    List<String> fetchPlantNames =
        await FetchAllPlantName.fetchingAllPlantName();

    if (fetchPlantNames.isNotEmpty) {
      setState(() {
        plantNames = fetchPlantNames;
      });
      if (plantNames.isNotEmpty) {
        _timer = Timer.periodic(Duration(seconds: 2), (timer) {
          if (mounted) {
            setState(() {
              int dividedLength = plantNames.length ~/ 2;
              currentIndex = (currentIndex + 1) % dividedLength;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when widget is disposed
    super.dispose();
  }

  /// Fetch crops from API
  Future<void> _loadCrops({String? query}) async {
    try {
      List<PlantInfo> crops =
          await SearchService.fetchPlants(query: query, type: selectedType);

      if (mounted) {
        setState(() {
          _allCrops = crops;
          _searchResults = crops;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to fetch plants: $e")),
        );
      }
    }
  }

  /// search when user type the keyword
  void _onSearchChanged(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
    });

    _loadCrops(query: query); // Fetching filtered crops from API
  }

  /// Update filtering when dropdown selection changes
  void _onPlantTypeChanged(String? value) {
    if (value != null && mounted) {
      setState(() {
        selectedType = value;
      });
      _loadCrops(
          query: _searchController.text); // Apply filter with selected type
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchPage',
      transitionOnUserGestures: true,
      createRectTween: (begin, end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search Plants',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            // padding: const EdgeInsets.all(16.0),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                // Search Bar
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.grey[200],
                        //   borderRadius: BorderRadius.circular(8.0),
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                            ),
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: Colors.grey[100]!,
                              // inset: true,
                            ),
                          ],
                        ),
                        child: TextField(
                          autofocus: false,
                          cursorWidth: 0.80,
                          // cursorHeight: ,

                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xff1A5319),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            hintText: plantNames.isNotEmpty
                                ? plantNames[currentIndex]
                                : "Rose",
                            border: InputBorder.none,
                            filled: false,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 3),
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            _onSearchChanged(value);
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              selectedType!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.filter_alt_rounded,
                              color: Colors.grey[700],
                            ),
                            popUpAnimationStyle: AnimationStyle(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 500)),
                            menuPadding: EdgeInsets.symmetric(horizontal: 30),
                            position: PopupMenuPosition.over,
                            iconColor: const Color.fromARGB(255, 1, 49, 2),
                            borderRadius: BorderRadius.circular(20),
                            onSelected: (value) => _onPlantTypeChanged(value),
                            itemBuilder: (BuildContext context) {
                              return plantTypes.map((String type) {
                                return PopupMenuItem<String>(
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                  ),
                                  value: type,
                                  child: ListTile(
                                    dense: true,
                                    title: Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    trailing: type == selectedType
                                        ? Icon(Icons.check, color: Colors.green)
                                        : null,
                                  ),
                                );
                              }).toList();
                            },
                            // icon: Icon(
                            //   Icons.filter_alt_rounded,
                            //   color: Colors.grey[700],
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            offset: Offset(0, 50),
                          ),
                        ],
                      ),

                      // child: DropdownButton(
                      //   // isExpanded: true,

                      //   isDense: true,
                      //   alignment: Alignment.center,
                      //   borderRadius: BorderRadius.circular(10),
                      //   underline: Container(
                      //     color: Colors.grey,
                      //   ),
                      //   icon: Icon(
                      //     Icons.filter_alt_rounded,
                      //     color: Colors.grey,
                      //   ),
                      //   value: selectedType,
                      //   items: plantTypes.map((type) {
                      //     return DropdownMenuItem(
                      //       value: type,
                      //       child: Text(type),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) => _onPlantTypeChanged(value),
                      // ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // Conditionally showing suggestions or search results
                Expanded(
                  child: isSearching && _searchResults.isEmpty
                      ? const Center(child: Text("No plants found"))
                      : !isSearching
                          ? Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Suggestions:',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
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

                                //  Default Text
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

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlantsInfoDetailview(
                                          selectedPlant: plant,
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
                                      color: const Color.fromARGB(
                                          255, 239, 252, 240),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    plant.imageUrl[0],
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
                                                    plant.plant,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
      ),
    );
  }
}
