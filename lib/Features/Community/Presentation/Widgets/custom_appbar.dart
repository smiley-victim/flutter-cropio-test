import 'package:flutter/material.dart';

// class CustomAppbar {
//   static PreferredSize customAppbar() {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(170), // Increase AppBar height
//       child: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         flexibleSpace: Padding(
//           padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       "Community",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.notifications_none, color: Colors.black),
//                     onPressed: () {},
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: const CircleAvatar(
//                       backgroundColor: Colors.black12,
//                       child: Icon(Icons.person, color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                 ],
//               ),
//               const SizedBox(height: 10), // Space between title and search bar
//               Container(
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                 child: const TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search plants, diseases, or tags',
//                     hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: 18,fontWeight: FontWeight.w500, color: Colors.black54,),
//                     prefixIcon: Icon(Icons.search, color: Colors.black54,size: 35,),
//                     border: InputBorder.none, // Removed border
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10,),
//             ],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1.0),
//           child: Container(
//             color: Colors.grey.shade300, // Defines the line color
//             height: 1.0, // Defines the thickness of the line
//           ),
//         ),
//       ),
//     );
//   }
// }




class CustomSliverAppBar {
  static SliverAppBar customSliverAppBar() {
    return SliverAppBar(
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      expandedHeight: 170, // Set the expanded height to match your original PreferredSize
      floating: false, // Or true, depending on desired behavior when scrolling up
      pinned: false,    // Or true, if you want the app bar to remain at the top when collapsed
      snap: false,      // Only effective if floating is true
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero, // Remove default title padding of FlexibleSpaceBar
        background: Padding(
          padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Community",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.black),
                    onPressed: () {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10), // Space between title and search bar
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search plants, diseases, or tags',
                    hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: 18,fontWeight: FontWeight.w500, color: Colors.black54,),
                    prefixIcon: Icon(Icons.search, color: Colors.black54,size: 35,),
                    border: InputBorder.none, // Removed border
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade300, // Defines the line color
          height: 1.0, // Defines the thickness of the line
        ),
      ),
    );
  }
}