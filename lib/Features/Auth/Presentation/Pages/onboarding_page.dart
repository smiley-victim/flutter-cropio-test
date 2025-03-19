// import 'dart:ui';

import 'package:flutter/material.dart';


import 'auth_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    'Cropio.in',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 147, 145, 145),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: VerticalDivider(
                    color: const Color.fromARGB(255, 200, 194, 194),
                    thickness: 2,
                    indent: 1,
                    endIndent: 1,
                  ),
                ),
                Text(
                  'Plant a\ntree for\nlife',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ]),
              const SizedBox(height: 32),
              Center(
                  child: Icon(
                Icons.energy_savings_leaf_sharp,
                size: 150,
                color: Colors.teal.shade200,
              )),
              const SizedBox(height: 32),
              const Text(
                'Worldwide delivery\nwithin 10-15 days',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: CircleBorder()),
                child: const Text(
                  'GO',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  



// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F0E1),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5F0E1),
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 24.0), // Adjusted logo padding
//           child: Image.asset(
//             'assets/miro_logo.png',
//             height: 28, // Slightly larger logo
//           ),
//         ),
//         leadingWidth: 120, // Adjusted leading width
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.black),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
//             onPressed: () {},
//           ),
//           const SizedBox(width: 24), // Adjusted action icon spacing
//         ],
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 40.0), // Adjusted top padding for text
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     RichText(
//                       text: const TextSpan(
//                         style: TextStyle(
//                           fontSize: 58, // Adjusted font size
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700, // FontWeight to match better
//                           letterSpacing: -2.0, // Added letter spacing for tighter text
//                         ),
//                         children: [
//                           TextSpan(text: 'MI-RŌ '),
//                           TextSpan(
//                             text: 'X',
//                             style: TextStyle(
//                               color: Color(0xFFC19A6B),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Text(
//                       'G. ZOULIAS',
//                       style: TextStyle(
//                         fontSize: 34, // Adjusted font size
//                         fontWeight: FontWeight.w700, // FontWeight to match better
//                         color: Colors.black,
//                         letterSpacing: -1.0, // Added letter spacing for tighter text
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Connector Line - Adjusted Curve and Position
//           Positioned(
//             left: MediaQuery.of(context).size.width * 0.41,
//             top: MediaQuery.of(context).size.height * 0.28,
//             child: CustomPaint(
//               painter: DashedLinePainter(),
//               size: Size(MediaQuery.of(context).size.width * 0.2, MediaQuery.of(context).size.height * 0.25), // Adjusted size
//             ),
//           ),

//           // Image Circles - Adjusted Positions and Sizes
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.23,
//             left: MediaQuery.of(context).size.width * 0.12,
//             child: const CircularImage(imagePath: 'assets/image1.png', radius: 65), // Slightly larger radius
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.17,
//             right: MediaQuery.of(context).size.width * 0.12,
//             child: const CircularImage(imagePath: 'assets/image2.png', radius: 65), // Slightly larger radius
//           ),
//           Positioned(
//             bottom: MediaQuery.of(context).size.height * 0.27,
//             left: MediaQuery.of(context).size.width * 0.12,
//             child: const CircularImage(imagePath: 'assets/image3.png', radius: 65), // Slightly larger radius
//           ),
//           Positioned(
//             bottom: MediaQuery.of(context).size.height * 0.19,
//             right: MediaQuery.of(context).size.width * 0.12,
//             child: const CircularImage(imagePath: 'assets/image4.png', radius: 65), // Slightly larger radius
//           ),

//           // Bottom Buttons - Adjusted Padding and Styling
//           Positioned(
//             bottom: 40, // Adjusted bottom spacing
//             left: 24, // Adjusted side spacing
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.44,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFC19A6B),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0), // Slightly more rounded
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 18), // Adjusted button padding
//                   textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Adjusted text style
//                 ),
//                 child: const Text('GO TO CATALOG'),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 40, // Adjusted bottom spacing
//             right: 24, // Adjusted side spacing
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.44,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFC19A6B),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0), // Slightly more rounded
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 18), // Adjusted button padding
//                   textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Adjusted text style
//                 ),
//                 child: const Text('GET STARTED'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CircularImage extends StatelessWidget {
//   final String imagePath;
//   final double radius; // Added radius parameter

//   const CircularImage({super.key, required this.imagePath, this.radius = 60}); // Default radius

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: const Color(0xFFC19A6B), width: 5),
//       ),
//       child: CircleAvatar(
//         radius: radius, // Use provided radius
//         backgroundImage: AssetImage(imagePath),
//       ),
//     );
//   }
// }


// class DashedLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFFC19A6B)
//       ..strokeWidth = 3
//       ..strokeCap = StrokeCap.round;

//     double startX = size.width * 0.1;
//     double startY = size.height * 0.15; // Adjusted start Y
//     double endX = size.width * 0.9;
//     double endY = size.height * 0.85; // Adjusted end Y

//     Path path = Path();
//     path.moveTo(startX, startY);

//     // More refined curve - Adjusted control points
//     path.quadraticBezierTo(size.width * 0.5, size.height * 0.05, size.width * 0.75, size.height * 0.4); // First curve
//     path.quadraticBezierTo(size.width * 0.95, size.height * 0.75, endX, endY);      // Second curve


//     Path dashedPath = Path();
//     double dashLength = 10;
//     double dashSpace = 10;
//     double distance = 0;
//     for (PathMetric pathMetric in path.computeMetrics()) {
//       while (distance < pathMetric.length) {
//         dashedPath.addPath(
//           pathMetric.extractPath(distance, distance + dashLength),
//           Offset.zero,
//         );
//         distance += dashLength + dashSpace;
//       }
//     }

//     canvas.drawPath(dashedPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldPainter) {
//     return false;
//   }
// }