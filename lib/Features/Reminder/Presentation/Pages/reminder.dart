import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

import 'event_card.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  DateTime _selectedDate = DateTime.now();
  final _plantEvents = [
    {
      "plantName": 'Philodendron Plant',
      "condition": 'GOOD',
      "careType": 'Water',
      "careDetails": 'Medium',
      "duration": 'Alternative Days',
      "time": '7:30 AM',
      "image": 'assets/images/plant1.png',
      "icon": "assets/images/water.png",
    },
    {
      "plantName": 'Bonsai Plant',
      "condition": 'EXCELLENT',
      "careType": 'Water',
      "careDetails": 'Low',
      "duration": '2 Days A Week',
      "time": '7:30 AM',
      "image": 'assets/images/plant2.png',
      "icon": "assets/images/water.png",
    },
    {
      "plantName": 'Philodendron Plant',
      "condition": 'BAD',
      "careType": 'Fertilize',
      "careDetails": 'Medium',
      "duration": 'Alternative Days',
      "time": '7:30 AM',
      "image": 'assets/images/plant3.png',
      "icon": "assets/images/fertilizer.png",
    },
    {
      "plantName": 'Philodendron Plant',
      "condition": 'GOOD',
      "careType": 'Water',
      "careDetails": 'Medium',
      "duration": 'Alternative Days',
      "time": '7:30 AM',
      "image": 'assets/images/plant4.jpg',
      "icon": "assets/images/water.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'REMINDER',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade700,
                    Colors.green.shade300,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // Number of days in a week
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().add(
                  Duration(days: index - DateTime.now().weekday + 1),
                ); // Calculate each date
                log(date.toString());
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: _selectedDate.day == date.day
                            ? Colors.green
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E')
                              .format(date), // Display day (e.g., Mon)
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedDate.day == date.day
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          DateFormat('d')
                              .format(date), // Display date (e.g., 5)
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _selectedDate.day == date.day
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                itemCount: _plantEvents.length,
                itemBuilder: (context, index) {
                  final event = _plantEvents[index];
                  bool isFirst = index == 0;
                  bool isLast = index == _plantEvents.length - 1;
                  return TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.10, // Adjust for icon position
                    isFirst: isFirst,
                    isLast: isLast,
                    indicatorStyle: IndicatorStyle(
                        width: 50,
                        height: 50,
                        indicator: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: event['careType'] == 'Water'
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.brown.shade400,
                                spreadRadius: 0.1,
                                blurRadius: 70,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              event["icon"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    beforeLineStyle:
                        LineStyle(color: Colors.grey.shade300, thickness: 2),
                    afterLineStyle:
                        LineStyle(color: Colors.grey.shade300, thickness: 2),
                    endChild: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: EventCard(event: event),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: DottedBorder(
              borderType: BorderType.RRect, // Can be Circle, Rect, RRect
              radius: Radius.circular(30), // Border radius for rounded edges
              dashPattern: [5, 4], // Dash length and gap
              strokeWidth: 1,
              color: Colors.grey,
              child: Container(
                width: 160,
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "ADD EVENT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
