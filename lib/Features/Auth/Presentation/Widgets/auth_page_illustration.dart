import 'package:flutter/material.dart';

class AuthPageIllustration extends StatelessWidget {
  const AuthPageIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 700,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    topLeft: Radius.circular(100)),
                color: const Color.fromARGB(255, 20, 36, 8),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 600,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    topLeft: Radius.circular(100)),
                color: const Color.fromARGB(255, 63, 121, 18),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200, // Set a specific height
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 255, 204, 102),
                        Color.fromARGB(255, 173, 216, 230)
                      ])),
            ),
          ),
          Positioned(
           // top: 10,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/plant.jpg'))
        ],
      ),
    );
  }
}
