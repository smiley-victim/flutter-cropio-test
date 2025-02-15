import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myapp/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:myapp/Features/Home/Presentation/Widgets/profile_img_stack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Features/Languages/Presentation/Pages/language_selection_page.dart';
import 'package:myapp/Features/Profile/Presentation/Pages/profile_page.dart';
import '../../../../Core/Constants/appconstants.dart';
import '../../../Garden/Presentation/Pages/garden_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
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
          profileimage: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3',
        ),
        s25,
        // name of the user
        Padding(
          padding: const EdgeInsets.only(right: 90),
          child: Column(
            children: [
              Text(
                'name',
                style: GoogleFonts.inter(
                    fontSize: 17, fontWeight: FontWeight.bold),
              ),
               Text(
                'user id',
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        s10,
        /// here  the drawer menus [Profile,Languages,My Garden]

        ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            leading: const Icon(Icons.person_2_outlined),
            title: Text(
              "Profile",
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FarmerProfilePage()))),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyGardenPage())),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          leading: const Icon(Icons.backpack),
          title: Text(
            "My Garden",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () => {},
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          leading: const Icon(Icons.settings_outlined),
          title: Text(
            "Settings",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => LanguageSelectionPage())),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          leading: const Icon(Icons.language_outlined),
          title: Text(
            "Languages",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        /// here the dark button
      ]),
    );
  }
}
