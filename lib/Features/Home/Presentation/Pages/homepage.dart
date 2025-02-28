import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Features/AI%20chat%20interaction/Presentation/Pages/ai_home_page.dart';
import 'package:myapp/Features/Calculator/screen/fertilizer_calculator_screen.dart';
import 'package:myapp/Features/Garden/Presentation/Pages/garden_page.dart';
import 'package:myapp/Features/Home/Presentation/Widgets/app_drawer.dart';
import 'package:myapp/Features/Home/Presentation/Widgets/do_you_know.dart';
import 'package:myapp/Features/Home/Presentation/Widgets/square_card_button.dart';
import 'package:myapp/Features/Maps/Presentation/Pages/map.dart';
import 'package:myapp/Features/Reminder/Presentation/Pages/reminder.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning!',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0 tasks today',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // MaterialButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => SearchPageMobile()));
                        //   },
                        //   elevation: 2,
                        //   color: Colors.white,
                        //   visualDensity:
                        //       VisualDensity(horizontal: 1.0, vertical: 1.0),
                        //   shape: CircleBorder(),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: Icon(Icons.search),
                        //   ),
                        // ),
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3',
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                DoYouKnow(),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  // height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 247, 247),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SquareCardButton(
                              icon: Icons.window,
                              title: 'Reminder',
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReminderScreen()))),
                          SquareCardButton(
                              icon: Icons.grass,
                              title: 'AI chat',
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AIHomePage()))),
                        ],
                      ),
                      Column(
                        children: [
                          SquareCardButton(
                              icon: Icons.water_drop_sharp,
                              title: 'Calculator',
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FertilizerCalculatorScreen()))),
                          SquareCardButton(
                              icon: Icons.map_rounded,
                              title: 'Area map',
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen()))),
                        ],
                      )
                    ],
                  ),
                ),

                // My Garden Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Garden',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GardenScreen())),
                      child: const Text('See all'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Plant Cards
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      PlantCard(
                        name: 'Ficus Benjamina',
                        image:
                            'https://images.unsplash.com/5/unsplash-kitsune-4.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9&s=fb86e2e09fceac9b363af536b93a1275',
                      ),
                      PlantCard(
                        name: 'Zamioculcas',
                        image: '',
                      ),
                      PlantCard(
                        name: 'Ficus Lyrata',
                        image: '',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Caring Calendar
                const Text(
                  'Caring calendar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CaringCalendarCard(),
                const SizedBox(height: 24),
                const Text(
                  'Recent Scans',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 247, 247),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6,
                    children: [
                      Text('No recent activity'),
                      Icon(
                        Icons.grass_sharp,
                        color: const Color.fromARGB(255, 85, 134, 30),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String name;
  final String image;

  const PlantCard({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 100,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 218, 255, 221),
              border: Border.all(
                color: const Color.fromARGB(255, 167, 197, 212),
                width: 1,
              ),
            ),
            width: 100,
            height: 140,
            child: Center(
              child: image.isEmpty
                  ? Icon(Icons.forest_sharp)
                  : Image.network(
                      image,
                      height: 140,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CaringCalendarCard extends StatelessWidget {
  const CaringCalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 218, 255, 221),
              border: Border.all(
                color: Colors.blueGrey,
                width: 1,
              ),
            ),
            width: 100,
            height: 140,
            child: Center(
              child: Icon(Icons.engineering),
            ),
          ),
          // Image.asset(
          //   'assets/plant_calendar.png',
          //   height: 60,
          // ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.water_drop_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Next watering on',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Text(
                '22 Jun, 2021',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.local_florist_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Fertilize on',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Text(
                'Sep, 2021',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
