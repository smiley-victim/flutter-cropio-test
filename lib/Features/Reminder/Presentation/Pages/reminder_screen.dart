import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/modals/plantevent_model.dart';
import '../Widgets/day_button.dart';
import '../Widgets/event_card.dart';
import '../Widgets/timeline.dart';
import '../bloc/reminder_bloc.dart';
import 'create_reminder_screen.dart'; // Adjust import path

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReminderBloc>(context)
        .add(LoadReminders(_selectedDate)); // Initial load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('REMINDER'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              BlocProvider.of<ReminderBloc>(context)
                  .add(SaveReminders()); // Example Save event
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDateSelector(),
          Expanded(
            child: _buildTimelineEvents(),
          ),
          _buildAddEventButton(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildDayButtons(),
      ),
    );
  }

  List<Widget> _buildDayButtons() {
    List<Widget> dayButtons = [];
    for (int i = 0; i < 7; i++) {
      DateTime date =
          DateTime.now().add(Duration(days: i - DateTime.now().weekday + 1));
      dayButtons.add(
        DayButton(
          date: date,
          isSelected: date.day == _selectedDate.day,
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
            BlocProvider.of<ReminderBloc>(context)
                .add(DateChanged(_selectedDate)); // Date changed event
          },
        ),
      );
    }
    return dayButtons;
  }

  Widget _buildTimelineEvents() {
    return BlocBuilder<ReminderBloc, ReminderState>(
      builder: (context, state) {
        if (state is ReminderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReminderError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is ReminderEmpty) {
          return Center(child: Text("No reminders for this day."));
        } else if (state is ReminderLoaded) {
          return _buildTimelineList(state.plantEvents);
        } else {
          return const Center(
              child:
                  Text('Initial State')); // Or handle initial state differently
        }
      },
    );
  }

  Widget _buildTimelineList(List<PlantEvent> plantEvents) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: plantEvents.length,
        itemBuilder: (context, index) {
          final event = plantEvents[index];
          bool isFirst = index == 0;
          bool isLast = index == plantEvents.length - 1;

          return TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.15,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 24,
              height: 24,
              indicator: TimelineIcon(icon: event.icon),
            ),
            beforeLineStyle:
                LineStyle(color: Colors.grey.shade300, thickness: 2),
            afterLineStyle:
                LineStyle(color: Colors.grey.shade300, thickness: 2),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
              child: EventCard(event: event),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddEventButton() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: OutlinedButton.icon(
        onPressed: () {

          // BlocProvider.of<ReminderBloc>(context)
          //     .add(AddNewReminder()); // Example Add event
          // Navigate to Add Event Screen (replace with your actual navigation)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReminderScreen()),
          ).then((value) {
            if (value == true) {
              BlocProvider.of<ReminderBloc>(context)
                  .add(DateChanged(_selectedDate)); // Reload on return
            }
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('ADD EVENT'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(color: const Color.fromARGB(255, 200, 221, 196)),
        ),
      ),
    );
  }
}



