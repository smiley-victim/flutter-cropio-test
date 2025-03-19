 import 'package:flutter/material.dart';

 showWalkthroughGuide(BuildContext ctx) {
   return showModalBottomSheet(
    backgroundColor: Colors.white,
      context: ctx,
      builder: (BuildContext context) {
        return SingleChildScrollView( // Make the bottom sheet scrollable if content is long
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
                _buildWalkthroughStep('1. Start Drawing:', 'Tap on the map to start drawing your farm area. Green markers will appear where you tap.'),
                _buildWalkthroughStep('2. Continue Drawing:', 'Tap on more locations to define the boundary. Lines will connect the points. Intermediate points will be added automatically for longer distances.'),
                _buildWalkthroughStep('3. Close Polygon (Automatic):', 'The polygon will automatically close when you have at least three points. You don\'t need to tap back on the starting point.'),
                _buildWalkthroughStep('4. View Area Details:', 'An information card will appear showing the calculated area and other details.'),
                _buildWalkthroughStep('5. Change Area Unit:', 'In the information card, use the dropdown to change the displayed area unit (Hectares, Acres, Sq Meters).'),
                _buildWalkthroughStep('6. Edit Polygon Shape:', 'Tap *inside* the polygon and select "Edit Polygon" from the menu.'),
                _buildWalkthroughStep('7. Resize Polygon:', 'In edit mode, drag the blue markers at each point to reshape the area.'),
                _buildWalkthroughStep('8. Finish Editing:', 'Tap "Done Editing" to save changes after resizing.'),
                _buildWalkthroughStep('9. Clear Area:', 'Tap inside the polygon and select "Clear Polygon" to remove the drawn area.'),
                _buildWalkthroughStep('10. Remove Last Point:', 'Tap inside the polygon and select "Remove Last Point" to undo the last point added.'),
                _buildWalkthroughStep('11. Switch Map View:', 'Use the floating button (map/satellite icon) to toggle between map views.'),
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