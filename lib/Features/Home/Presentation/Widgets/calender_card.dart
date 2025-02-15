import 'package:flutter/material.dart';

class CaringCalendarCard extends StatelessWidget {
  const CaringCalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 218, 255, 221),
              border: Border.all(
                color: Colors.blueGrey,
                width: 1,
              ),
            ),
            width: 100,
            height: 140,
            child: Center(
              child: Icon(Icons.engineering),
            ),
          ),
          // Image.asset(
          //   'assets/plant_calendar.png',
          //   height: 60,
          // ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.water_drop_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Next watering on',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Text(
                '22 Jun, 2021',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.local_florist_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Fertilize on',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Text(
                'Sep, 2021',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}