import 'package:flutter/material.dart';

class DoYouKnow extends StatelessWidget {
  const DoYouKnow({super.key});

  @override
  Widget build(BuildContext context) {
    return // Did you know card
        Stack(
      children: [
        Transform.rotate(
          angle: 0.03,
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 128, 165, 130),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade800,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                // right: 0,
                left: 150,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 45, 104, 48).withAlpha(1),
                      shape: BoxShape.circle),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb,
                        color: Color.fromARGB(255, 255, 255, 165),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Houseplants Love Stability',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: Text(
                      'Plants thrive once they are used to their surroundings!\nLight and temperature are important!',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
