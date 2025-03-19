import 'package:flutter/material.dart';
import 'package:myapp/Features/Home/Presentation/Pages/homepage.dart';
import 'package:myapp/Features/Home/Presentation/Pages/series_of_pages.dart';


class ResponsiveHomepage extends StatelessWidget {
  const ResponsiveHomepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return SeriesOfPages();
      } else {
        return Scaffold(
          backgroundColor: Colors.green[100], // Soft green background
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.forest, size: 170, color: Colors.green[800]),
                SizedBox(height: 30),
                Text(
                  'This view is under construction!',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800]),
                ),
                SizedBox(height: 15),
                Text(
                  "We're working hard to bring you a fantastic large screen experience.",
                  style: TextStyle(fontSize: 18, color: Colors.green[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
