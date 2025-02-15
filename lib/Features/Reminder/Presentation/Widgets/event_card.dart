import 'package:flutter/material.dart';

import '../../Data/modals/plantevent_model.dart';

class EventCard extends StatelessWidget {
  final PlantEvent event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: event.image.isNotEmpty
                    ? Image.asset(
                        event.image,
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.green,
                        width: 60.0,
                        height: 60.0,
                      )),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.plantName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                   Text(
                        'Condition: ${event.condition}',
                        style: TextStyle(
                            color: _getConditionColor(event.condition)),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(event.icon, color: Colors.blueGrey, size: 16.0),
                      SizedBox(width: 4.0),
                      Text('${event.careType}: ${event.careDetails}'),
                     
                    ],
                  ), Text('Duration: ${event.duration}'),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.alarm, size: 16.0, color: Colors.grey),
                      SizedBox(width: 4.0),
                      Text(event.time, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toUpperCase()) {
      case 'EXCELLENT':
        return Colors.green;
      case 'GOOD':
        return Colors.blue;
      case 'BAD':
        return Colors.orange;
      default:
        return Colors.black54;
    }
  }
}