import 'package:flutter/material.dart';

class TimelineIcon extends StatelessWidget {
  final IconData icon;

  const TimelineIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 16.0,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
