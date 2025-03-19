import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:myapp/Features/Garden/Presentation/Pages/crop_list_page.dart';
import 'package:myapp/Features/GardenV2/Presentation/Pages/gradenlist_page.dart';
import 'package:myapp/Features/Home/Presentation/Widgets/profile_img_stack.dart';

import 'package:myapp/Features/Languages/Presentation/Pages/language_selection_page.dart';
import 'package:myapp/Features/Profile/Presentation/Pages/profile_page.dart';
import '../../../../Core/Constants/appconstants.dart';
import '../../../Garden/Presentation/Pages/garden_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(children: [
        s10,
        // profile stack image which is in the drawer
        ProfileStackImage(
          profileimage:
              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3',
        ),
        s25,
        // name of the user
        Padding(
          padding: const EdgeInsets.only(right: 90),
          child: Column(
            children: [
              Text(
                'name',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                'user id',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        s10,

        /// here  the drawer menus [Profile,Languages,My Garden]

        ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            leading: const Icon(Icons.person_2_sharp),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FarmerProfilePage()))),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlantListPage())),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          leading: const Icon(LucideIcons.grape),
          title: Text(
            "My Garden",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () => {},
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          leading: const Icon(Icons.settings),
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => LanguageSelectionPage())),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          leading: const Icon(Icons.language),
          title: Text(
            "Languages",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.4.toDouble(),
          ),
          child: Transform.rotate(
            angle: 50,
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 100,
              height: 100,
              // colorBlendMode: BlendMode.color,
              opacity: const AlwaysStoppedAnimation(0.7),
              isAntiAlias: true,
            ),
          ),
        )
      ]),
    );
  }
}
