// --- Reusable Widgets ---

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayButton extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DayButton(
      {super.key, required this.date, this.isSelected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: isSelected ? Border.all(color: Colors.green) : null,
        ),
        child: Column(
          children: [
            Text(
              DateFormat('E').format(date),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.green[800] : Colors.black87,
              ),
            ),
            Text(
              DateFormat('d').format(date),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.green[800] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}