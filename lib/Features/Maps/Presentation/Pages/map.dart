import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:myapp/Features/Maps/Presentation/Widgets/infocard.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Polygon> polygons = {};
  List<LatLng> polygonLatLngs = [];
  double area = 0.0;
  AreaUnit _selectedAreaUnit = AreaUnit.hectares;
  List<String> recommendedCrops = [];
  Map<String, Map<String, double>> fertilizerRecommendations = {};

  LatLng? currentLocation;
  bool isLoadingLocation = false;
  bool isPolygonDrawn = false; // Track if a polygon has been started
  MapType mapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoadingLocation = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLoadingLocation = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('Location services are disabled. Please enable them.')));
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          isLoadingLocation = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        isLoadingLocation = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
      }
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        isLoadingLocation = false;
      });
      _animateToCurrentLocation();
    } catch (e) {
      setState(() {
        isLoadingLocation = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: ${e.toString()}')));
    }
  }

  void _animateToCurrentLocation() {
    if (currentLocation != null && mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        currentLocation!,
        17,
      ));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (currentLocation != null) {
      _animateToCurrentLocation();
    }
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      polygonLatLngs.add(latLng);
      isPolygonDrawn = true; // Polygon drawing started
      _updatePolygon();
    });
  }

  void _updatePolygon() {
    polygons.clear();
    if (polygonLatLngs.isNotEmpty) {
      polygons.add(Polygon(
        polygonId: const PolygonId('farmArea'),
        points: polygonLatLngs,
        fillColor: Colors.green.withOpacity(0.3),
        strokeColor: Colors.green,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () {
          _showPolygonOptions(); // Show options only on polygon tap now
        },
      ));
      _calculateArea();
    } else {
      area = 0.0;
      recommendedCrops.clear();
      fertilizerRecommendations.clear();
      isPolygonDrawn = false;
    }
  }

  void _toggleMapType() {
    setState(() {
      mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  double _calculateAreaInHectares() {
    if (polygonLatLngs.length < 3) {
      return 0.0;
    }

    double areaInMeters = 0.0;
    final numPoints = polygonLatLngs.length;
    final earthRadiusMeters = 6371000.0; // Earth radius in meters

    for (int i = 0; i < numPoints; i++) {
      final p1 = polygonLatLngs[i];
      final p2 = polygonLatLngs[(i + 1) % numPoints]; // Next point, wrap around

      final lat1 = _degreesToRadians(p1.latitude);
      final lon1 = _degreesToRadians(p1.longitude);
      final lat2 = _degreesToRadians(p2.latitude);
      final lon2 = _degreesToRadians(p2.longitude);

      areaInMeters += (lon2 - lon1) * (2 + math.sin(lat1) + math.sin(lat2));
    }

    areaInMeters = areaInMeters * earthRadiusMeters * earthRadiusMeters / 2.0;
    return (areaInMeters.abs() /
        10000); // Convert to hectares and return absolute value
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  void _calculateArea() {
    debugPrint('--- _calculateArea() called ---');
    debugPrint('polygonLatLngs: $polygonLatLngs');

    double calculatedAreaHectares =
        _calculateAreaInHectares(); // Calling the reverted function
    debugPrint(
        'Calculated Area (Hectares) before setState: $calculatedAreaHectares');
    setState(() {
      area = calculatedAreaHectares;
      _recommendCropsAndFertilizers();
    });
  }

  void _recommendCropsAndFertilizers() {
    final double areaInHectares = area; // Use the calculated area directly
    recommendedCrops.clear();
    fertilizerRecommendations.clear();

    if (areaInHectares > 0) {
      recommendedCrops.addAll(['Wheat', 'Rice', 'Corn']);
      for (var crop in recommendedCrops) {
        if (crop == 'Wheat') {
          fertilizerRecommendations[crop] = {
            'Nitrogen': 120.0,
            'Phosphorus': 60.0,
            'Potassium': 40.0
          };
        } else if (crop == 'Rice') {
          fertilizerRecommendations[crop] = {
            'Nitrogen': 150.0,
            'Phosphorus': 70.0,
            'Potassium': 50.0
          };
        } else if (crop == 'Corn') {
          fertilizerRecommendations[crop] = {
            'Nitrogen': 180.0,
            'Phosphorus': 80.0,
            'Potassium': 60.0
          };
        }
      }
    }
  }

  String _getFormattedArea() {
    double displayedArea = area; // Area is still stored in hectares internally

    switch (_selectedAreaUnit) {
      case AreaUnit.acres:
        displayedArea = area * 2.47105; // Hectares to Acres conversion
        break;
      case AreaUnit.squareMeters:
        displayedArea = area * 10000; // Hectares to Square Meters conversion
        break;
      case AreaUnit.hectares:
      default:
        break;
    }

    String unitString = '';
    switch (_selectedAreaUnit) {
      case AreaUnit.acres:
        unitString = 'Acres';
        break;
      case AreaUnit.squareMeters:
        unitString = 'Sq Meters';
        break;
      case AreaUnit.hectares:
      default:
        unitString = 'Hectares';
        break;
    }

    return '${NumberFormat('#,##0.00').format(displayedArea)} $unitString';
  }

  void _clearPolygon() {
    setState(() {
      polygonLatLngs.clear();
      _updatePolygon();
    });
  }

  void _removeLastPoint() {
    setState(() {
      if (polygonLatLngs.isNotEmpty) {
        polygonLatLngs.removeLast();
        _updatePolygon();
      }
    });
  }

  void _showPolygonOptions() {
    if (polygonLatLngs.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('Clear Polygon'),
              onTap: () {
                _clearPolygon();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.undo),
              title: const Text('Remove Last Point'),
              onTap: () {
                _removeLastPoint();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: const Text('Farm Area Definition'),
      // ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentLocation ?? const LatLng(0, 0),
              zoom: 15.0,
            ),
            polygons: polygons,
            onTap: _onMapTapped,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            mapType: mapType, // Use the current map type,
          ),
          if (isLoadingLocation)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (polygonLatLngs.isNotEmpty)
            ExpandableFarmCard(
              area: area,
              selectedUnit: _selectedAreaUnit,
              recommendedCrops: recommendedCrops,
              fertilizerRecommendations: fertilizerRecommendations,
              onClearArea: _clearPolygon,
              onUnitChanged: (unit) {
                setState(() {
                  _selectedAreaUnit = unit;
                });
              },
              onSavePlot: () {
                // Implement save functionality
              },
              isDrawing: polygonLatLngs.length >= 3,
            ),
        ],
      ),
      floatingActionButton: Column(
        // Use a Column to position multiple FABs if needed later
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _toggleMapType, // Call a new function to toggle map type
            tooltip: 'Change Map View',
            child: Icon(mapType == MapType.normal
                ? Icons.satellite_alt
                : Icons.map), // Icon changes based on current map type
          ),
          // if (isPolygonDrawn) // Keep the polygon options FAB, but position it above the map type toggle
          //   Padding(
          //     padding: const EdgeInsets.only(top: 16.0), // Add some spacing
          //     child: FloatingActionButton(
          //       onPressed: _showPolygonOptions,
          //       tooltip: 'Polygon Options',
          //       child: const Icon(Icons.settings),
          //     ),
          //   ),
        ],
      ), //Hide FAB if no polygon drawn yet
    );
  }
}

enum AreaUnit {
  hectares,
  acres,
  squareMeters,
}
