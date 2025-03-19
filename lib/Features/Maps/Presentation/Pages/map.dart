import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart'; // Import Cupertino package

import 'package:myapp/Features/Maps/Presentation/Widgets/infocard.dart'; // Adjust path if necessary

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
  bool isPolygonDrawn = false;
  MapType mapType = MapType.normal;

  String _realTimeAreaText = '';
  bool _isEditingPolygon = false;
  PolygonId? _selectedPolygonIdForEditing;
  Set<Marker> _editingMarkers = {};
  Set<Marker> _drawingMarkers = {};

  static const double _autoPointDistanceThreshold = 50.0;
  static const double _earthRadiusMeters = 6371000.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoadingLocation = true;
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLoadingLocation = false;
      });
      if (context.mounted) {
        // Show a dialog asking user to enable location services
        showDialog(
          
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Location Disabled'),
              content: const Text(
                  'Location services are disabled. Please turn them on to use this feature.'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await Geolocator.openLocationSettings();
                    _getCurrentLocation();
                  },
                  child: const Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
      if (_isEditingPolygon) {
        return; // Don't add new points in edit mode
      }
      _realTimeAreaText = '';
      _drawingMarkers.add(
        // Add a marker for the tapped point
        Marker(
          markerId:
              MarkerId('drawing_vertex_${polygonLatLngs.length}'), // Unique ID
          position: latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen), // Choose a distinct color
          zIndex:
              2, // Make sure it's above the polygon but below editing markers
          anchor: const Offset(0.5, 0.5), // Center the marker on the tap point
        ),
      );

      if (polygonLatLngs.isNotEmpty) {
        LatLng lastPoint = polygonLatLngs.last;
        double distance = _calculateDistance(lastPoint, latLng);

        if (distance > _autoPointDistanceThreshold) {
          int numPointsToAdd = (distance / _autoPointDistanceThreshold).floor();
          List<LatLng> intermediatePoints =
              _generateIntermediatePoints(lastPoint, latLng, numPointsToAdd);
          polygonLatLngs.addAll(intermediatePoints);
          // Add markers for intermediate points as well (optional, but good for visual consistency)
          for (int i = 0; i < intermediatePoints.length; i++) {
            _drawingMarkers.add(
              Marker(
                markerId: MarkerId(
                    'drawing_intermediate_vertex_${polygonLatLngs.length + i}'), // Unique IDs
                position: intermediatePoints[i],
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                zIndex: 2,
                anchor: const Offset(0.5, 0.5),
              ),
            );
          }
        }
      }
      polygonLatLngs.add(latLng);
      isPolygonDrawn = true;
      _calculateArea();
      _updatePolygon();
    });
  }

  void _updatePolygon() {
    polygons.clear();
    _editingMarkers.clear(); // Clear existing markers

    if (polygonLatLngs.isNotEmpty) {
      Polygon polygon = Polygon(
        // Create the polygon as before
        polygonId: const PolygonId('farmArea'),
        points: polygonLatLngs,
        fillColor: Colors.green.withOpacity(0.3),
        strokeColor: Colors.green,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () {
          if (!_isEditingPolygon) {
            // Don't show options if already editing
            _showPolygonOptions();
          }
        },
      );
      polygons.add(polygon);

      if (_isEditingPolygon &&
          _selectedPolygonIdForEditing == polygon.polygonId) {
        // If in edit mode for this polygon, create markers
        for (int i = 0; i < polygonLatLngs.length; i++) {
          _editingMarkers.add(
            Marker(
              markerId:
                  MarkerId('vertex_$i'), // Unique marker ID for each vertex
              position: polygonLatLngs[i],
              draggable: true,
              zIndex: 3, // Ensure markers are on top of polygons
              onDragEnd: (newPosition) {
                _onMarkerDragEnd(
                    i, newPosition, polygon.polygonId); // Call drag end handler
              },
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue), // Visual cue for editing marker
            ),
          );
        }
      }
      _calculateArea();
    } else {
      area = 0.0;
      recommendedCrops.clear();
      fertilizerRecommendations.clear();
      isPolygonDrawn = false;
      _realTimeAreaText = ''; // Clear real-time area text when polygon cleared
      _drawingMarkers
          .clear(); // Also clear drawing markers when polygon cleared
    }
  }

  void _onMarkerDragEnd(int index, LatLng newPosition, PolygonId polygonId) {
    setState(() {
      if (_isEditingPolygon && polygonId == _selectedPolygonIdForEditing) {
        polygonLatLngs[index] =
            newPosition; // Update the point in polygonLatLngs
        _updatePolygon(); // Re-render the polygon and markers
      }
    });
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

    String formattedArea = _getFormattedAreaForRealTime(
        calculatedAreaHectares); // New function to format for real-time

    setState(() {
      area = calculatedAreaHectares;
      _realTimeAreaText = formattedArea; // Update the real-time text variable
      _recommendCropsAndFertilizers();
    });
  }

  String _getFormattedAreaForRealTime(double areaInHectares) {
    double displayedAreaAcres = areaInHectares * 2.47105; // Hectares to Acres

    return '${NumberFormat('#,##0.00').format(displayedAreaAcres)} ac'; // Display in acres, "ac" unit
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

  void _clearPolygon() {
    setState(() {
      polygonLatLngs.clear();
      _realTimeAreaText = '';
      _drawingMarkers.clear(); // Clear drawing markers here
      _updatePolygon();
    });
  }

  void _removeLastPoint() {
    setState(() {
      if (polygonLatLngs.isNotEmpty) {
        polygonLatLngs.removeLast();
        _drawingMarkers.removeWhere((marker) =>
            marker.markerId ==
            MarkerId(
                'drawing_vertex_${polygonLatLngs.length + 1}')); //remove the last drawing marker
        _updatePolygon();
      }
    });
  }

  void _showPolygonOptions() {
    if (polygonLatLngs.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text(
            'Polygon Options',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: <Widget>[
            if (polygonLatLngs.length >= 3)
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _startPolygonEditing(const PolygonId('farmArea'));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Edit Polygon',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            CupertinoActionSheetAction(
              onPressed: () {
                _clearPolygon();
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.clear_all,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Clear Polygon',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _removeLastPoint();
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.undo,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 8),
                  Text('Remove Last Point', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
          ),
        );
      },
    );
  }

  void _startPolygonEditing(PolygonId polygonId) {
    setState(() {
      _isEditingPolygon = true;
      _selectedPolygonIdForEditing = polygonId;
      _drawingMarkers.clear(); // Clear drawing markers when starting edit
      _updatePolygon();
    });
  }

  void _stopPolygonEditing() {
    setState(() {
      _isEditingPolygon = false;
      _selectedPolygonIdForEditing = null;
      _editingMarkers.clear(); // Clear markers when done editing
      _updatePolygon(); // Rebuild polygon without markers
    });
  }

  double _calculateDistance(LatLng p1, LatLng p2) {
    var lat1 = _degreesToRadians(p1.latitude);
    var lon1 = _degreesToRadians(p1.longitude);
    var lat2 = _degreesToRadians(p2.latitude);
    var lon2 = _degreesToRadians(p2.longitude);

    var dLon = lon2 - lon1;
    var dLat = lat2 - lat1;

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    var distance = _earthRadiusMeters * c;
    return distance;
  }

  List<LatLng> _generateIntermediatePoints(
      LatLng startPoint, LatLng endPoint, int numPoints) {
    List<LatLng> points = [];
    if (numPoints <= 0) {
      return points;
    }

    double latStep =
        (endPoint.latitude - startPoint.latitude) / (numPoints + 1);
    double lngStep =
        (endPoint.longitude - startPoint.longitude) / (numPoints + 1);

    for (int i = 1; i <= numPoints; i++) {
      points.add(LatLng(
        startPoint.latitude + latStep * i,
        startPoint.longitude + lngStep * i,
      ));
    }
    return points;
  }

  void _showWalkthroughGuide() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Make the bottom sheet scrollable if content is long
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Farm Area Mapping Guide',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildWalkthroughStep('1. Start Drawing:',
                    'Tap on the map to start drawing your farm area. Green markers will appear where you tap.'),
                _buildWalkthroughStep('2. Continue Drawing:',
                    'Tap on more locations to define the boundary. Lines will connect the points. Intermediate points will be added automatically for longer distances.'),
                _buildWalkthroughStep('3. Close Polygon (Automatic):',
                    'The polygon will automatically close when you have at least three points. You don\'t need to tap back on the starting point.'),
                _buildWalkthroughStep('4. View Area Details:',
                    'An information card will appear showing the calculated area and other details.'),
                _buildWalkthroughStep('5. Change Area Unit:',
                    'In the information card, use the dropdown to change the displayed area unit (Hectares, Acres, Sq Meters).'),
                _buildWalkthroughStep('6. Edit Polygon Shape:',
                    'Tap *inside* the polygon and select "Edit Polygon" from the menu.'),
                _buildWalkthroughStep('7. Resize Polygon:',
                    'In edit mode, drag the blue markers at each point to reshape the area.'),
                _buildWalkthroughStep('8. Finish Editing:',
                    'Tap "Done Editing" to save changes after resizing.'),
                _buildWalkthroughStep('9. Clear Area:',
                    'Tap inside the polygon and select "Clear Polygon" to remove the drawn area.'),
                _buildWalkthroughStep('10. Remove Last Point:',
                    'Tap inside the polygon and select "Remove Last Point" to undo the last point added.'),
                _buildWalkthroughStep('11. Switch Map View:',
                    'Use the floating button (map/satellite icon) to toggle between map views.'),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Got it!'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWalkthroughStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(description),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentLocation ?? const LatLng(0, 0),
              zoom: 15.0,
            ),
            polygons: polygons,
            markers: {
              ..._drawingMarkers,
              if (_isEditingPolygon) ..._editingMarkers,
            },
            onTap: _onMapTapped,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            mapType: mapType,
          ),
          if (_realTimeAreaText.isNotEmpty)
            Positioned(
              top: 16.0,
              left: 16.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _realTimeAreaText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ),
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
        // Wrap FABs in a Column
        mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
        children: [
          Padding(
            // Add some spacing between FABs
            padding:
                const EdgeInsets.only(bottom: 16.0), // Adjust spacing as needed
            child: FloatingActionButton(
              // Help Guide FAB
              onPressed:
                  _showWalkthroughGuide, // Call the walkthrough guide function
              tooltip: 'Walkthrough Guide', // Help icon
              heroTag: 'help_fab',
              child: const Icon(Icons
                  .help_outline), // Unique heroTag (important if you have multiple FABs)
            ),
          ),
          if (_isEditingPolygon) // "Done Editing" FAB (keep it if you have it)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton.extended(
                onPressed: _stopPolygonEditing,
                label: const Text('Done Editing'),
                icon: const Icon(Icons.check),
                backgroundColor: Colors.green,
                heroTag: 'done_editing_fab', // Unique heroTag
              ),
            ),
          FloatingActionButton(
            // Map Type Toggle FAB (keep it)
            onPressed: _toggleMapType,
            tooltip: 'Change Map View',
            heroTag: 'map_type_fab',
            child: Icon(mapType == MapType.normal
                ? Icons.satellite_alt
                : Icons.map), // Unique heroTag
          ),
        ],
      ),
    );
  }
}

enum AreaUnit {
  hectares,
  acres,
  squareMeters,
}
