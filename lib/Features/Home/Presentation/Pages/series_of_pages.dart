import 'package:flutter/material.dart';
import 'package:myapp/Features/Camera/Presentation/Pages/camera_page.dart';
import 'package:myapp/Features/Community/Presentation/Pages/community_screen.dart';
import 'package:myapp/Features/Home/Presentation/Pages/blank.dart';
import 'package:myapp/Features/Home/Presentation/Pages/homepage.dart';
import 'package:myapp/Features/Search/Presentations/Pages/search_page_mobile.dart';

import '../../../Plant info panel/Presentations/Pages/plant_info_listview.dart';

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
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() => index = value),
        currentIndex: index,
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_sharp),
            backgroundColor:  Colors.green,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_cloudy),
            label: '',
          ),
         
        ],
      ),
      body: [
        MyHomePage(),
        // PlantInfoListviewPage(),
        SearchPageMobile(),
        CameraPage(),
        BlankPage(),
        CommunityScreen()
      ][index],
    );
  }
}
