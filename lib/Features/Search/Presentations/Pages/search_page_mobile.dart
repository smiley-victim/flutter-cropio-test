import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/Features/Plant%20info%20panel/Presentations/Pages/plants_info_detailview.dart';
import 'package:myapp/Features/Search/Data/model/plant_info.dart';
import 'package:myapp/Features/Search/Data/services/fetch_all_plant_name.dart';
import 'package:myapp/Features/Search/Data/services/search_service.dart';

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
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _loadCrops();
    _searchResults = List.from(_allCrops);
    selectedType = 'All';
    fetchAllPlantName();
    fetchPlantTypes();
  }

  Future<void> fetchPlantTypes() async {
    List<String> fetchPlantTypes = await FetchPlantTypes.fetchingPlantTypes();

    if (fetchPlantTypes.isNotEmpty) {
      setState(() {
        plantTypes = ['All', ...fetchPlantTypes];
        selectedType = 'All';
        debugPrint(plantTypes.toString());
      });
    } else {
      debugPrint("No plant types found.");
    }
  }

  Future<void> fetchAllPlantName() async {
    List<String> fetchPlantNames =
        await FetchAllPlantName.fetchingAllPlantName();

    if (fetchPlantNames.isNotEmpty && mounted) {
      // Check if widget is mounted before setState
      setState(() {
        plantNames = fetchPlantNames;
      });

      if (plantNames.isNotEmpty) {
        _timer?.cancel(); // Cancel any existing timer before creating a new one
        _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
          if (!mounted) {
            // Cancel timer if widget is not mounted
            timer.cancel();
            return;
          }
          setState(() {
            int dividedLength = plantNames.length ~/ 2;
            currentIndex = (currentIndex + 1) % dividedLength;
          });
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer in dispose
    _searchController.dispose(); // Also dispose the TextEditingController
    super.dispose();
  }

  Future<void> _loadCrops({String? query}) async {
    try {
      List<PlantInfo> crops = await SearchService.fetchPlants(
        query: query?.isEmpty ?? true
            ? null
            : query, // Fetch all if query is empty
        type: selectedType == 'All' ? null : selectedType, // Consider filter
      );

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

  void _onSearchChanged(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
    });

    if (query.isEmpty) {
      _loadCrops(); // Reset to show all plants
    } else {
      _loadCrops(query: query);
    }
  }

  void _onPlantTypeChanged(String type) {
    setState(() {
      selectedType = type;

      if (type == "All") {
        // Show all plants when "All" is selected
        _searchResults =
            List.from(_allCrops); // Assuming `allPlants` is the original list
      } else {
        // Filter plants based on selected type
        _searchResults =
            _allCrops.where((plant) => plant.type == type).toList();
      }
    });

//  _loadCrops();
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
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            title: const Text(
              'Plants Dictionary',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            // padding: const EdgeInsets.all(16.0),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                // Search Bar
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                              color: Colors.grey[300]!,
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
                                color: Colors.grey,
                                // fontWeight: FontWeight.w600,
                                fontSize: 14),
                            hintText: plantNames.isNotEmpty
                                ? plantNames[currentIndex]
                                : "Rose",
                            border: InputBorder.none,
                            filled: false,
                            errorBorder: InputBorder.none,
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
                  ],
                ),
                const SizedBox(height: 10),

                /// Filter Chips in a Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: plantTypes.map((type) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          checkmarkColor: Colors.white,
                          label: Text(type),
                          selected: selectedType == type,
                          onSelected: (bool selected) {
                            if (selected) {
                              _onPlantTypeChanged(type);
                            }
                          },
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: selectedType == type
                                ? Colors.white
                                : Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Adjust the radius as needed
                            side: BorderSide(
                                color: selectedType == type
                                    ? Colors.black
                                    : Colors.grey.shade300),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Expanded(
                  child: selectedType == "All " && _searchResults.isEmpty
                      ? _allCrops.isEmpty
                          ? Center(child: Text("No plants available"))
                          : ListView.builder(
                              itemCount: _allCrops.length,
                              itemBuilder: (context, index) {
                                PlantInfo plant = _allCrops[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CropDetailScreen(
                                          crop: plant,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: EdgeInsets.all(10),
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 10)
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  plant.imageUrl[0]),
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
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    plant.description,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                      : _searchResults.isEmpty
                          ? Center(child: Text("No plants found"))
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
                                            CropDetailScreen(crop: plant),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: EdgeInsets.all(10),
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 10)
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  plant.imageUrl[0]),
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
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    plant.description,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
