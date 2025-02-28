import 'package:flutter/material.dart';
import 'package:myapp/Features/Plant%20info%20panel/Presentations/Pages/plant_info_listview.dart';
import 'package:myapp/Features/Weather/Presentation/Pages/weather_page.dart';


/// !!! here is my custom design bottom bar !!!
// class BottomBar extends StatelessWidget {
//   const BottomBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.onPrimaryContainer,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.home_outlined,
//               color: Colors.white,
//             ),
//             // color: Colors.white,
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => PlantInfoListviewPage()));
//             },
//             icon: const Icon(
//               Icons.chat_bubble_outline_outlined,
//               color: Colors.white,
//             ),
//             color: Colors.white,
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => WeatherPage()));
//             },
//             icon: const Icon(
//               Icons.terrain_outlined,
//               color: Colors.white,
//             ),
//             color: Colors.white,
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.map_outlined,
//               color: Colors.white,
//             ),
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }

/// !! here the salomon style bottom bar is used !!
// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key});

//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   int index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SalomonBottomBar(
//         unselectedItemColor: Colors.white,
//         selectedItemColor: Colors.white,
//         backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
//         currentIndex: index,
//         onTap: (i) {
//           setState(() {
//             index = i;
//           });
//           if (i == 1) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const PlantInfoListviewPage()));
//           } else if (i == 2) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => WeatherPage()));
//           }
//         },
//         items: [
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.home_outlined),
//             title: const Text("Home"),
//             // selectedColor: Theme.of(context).colorScheme.primary,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.chat_bubble_outline_outlined),
//             title: const Text("Chat"),
//             // selectedColor: Theme.of(context).colorScheme.primary,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.terrain_outlined),
//             title: const Text("Weather"),
//             // selectedColor: Theme.of(context).colorScheme.primary,
//           ),
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.map_outlined),
//             title: const Text("Map"),
//             // selectedColor: Theme.of(context).colorScheme.primary,
//           ),
//         ]);
//   }
// }

///!!! here the default material U style bottom navgation bar code places
/// ?? here the th problems began its autually pretty weird from the other as it some ui 
/// ?? redesign for these implement
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        height: 60,
        // backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
          if (value == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlantInfoListviewPage()));
          } else if (value == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WeatherPage()));
          } else if (value == 1) {
            
          }
        },
        selectedIndex: 0,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline_outlined), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Map'),
          NavigationDestination(
              icon: Icon(Icons.cloud_outlined), label: "Weather")
        ]);
  }
}
