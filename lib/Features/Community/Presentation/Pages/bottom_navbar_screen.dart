import 'package:flutter/material.dart';
import 'package:myapp/Features/Community/Presentation/Pages/community_screen.dart';
import 'package:myapp/Features/Community/Presentation/Pages/create_post_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int selectedIndex = 0;
  List<Widget> screenList = [
    CommunityScreen(), 
    //CreatePostScreen()
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
            backgroundColor: Colors.lightGreen.shade100,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Community"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.add_box), label: "Add Post"),
            ]
            ),
      ),
    );
  }
}
