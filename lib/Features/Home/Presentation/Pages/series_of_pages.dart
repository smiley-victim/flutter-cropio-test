import 'package:flutter/material.dart';
import 'package:myapp/Features/Camera/Presentation/Pages/camera_page.dart';
import 'package:myapp/Features/Community/Presentation/Pages/community_screen.dart';
import 'package:myapp/Features/Home/Presentation/Pages/blank.dart';
import 'package:myapp/Features/Home/Presentation/Pages/homepage.dart';
import 'package:myapp/Features/Search/Presentations/Pages/search_page_mobile.dart';

final glbkey = GlobalKey();

class SeriesOfPages extends StatefulWidget {
  const SeriesOfPages({super.key});

  @override
  State<SeriesOfPages> createState() => _SeriesOfPagesState();
}

class _SeriesOfPagesState extends State<SeriesOfPages> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BottomNavigationBar(
            key: glbkey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            currentIndex: index,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.eco), label: ''),
              BottomNavigationBarItem(icon: SizedBox(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: 'Community'),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
            ],
          ),
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPage(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(Icons.camera_alt, color: Colors.white, size: 36),
              ),
            ),
          ),
        ],
      ),
      body: [
        DashboardScreen(),
        SearchPageMobile(),
        CameraPage(),
        CommunityScreen(),
        BlankPage(),
      ][index],
    );
  }
}
