import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Data/modals/plantevent_model.dart';
import '../../Domain/plantevent_service.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key, this.selectedDate});

  final DateTime? selectedDate; // Optional selected date to pre-populate

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plantNameController = TextEditingController();
  final _conditionController = TextEditingController();
  CareType? _selectedCareType;
  final _careDetailsController = TextEditingController();
  final _durationController = TextEditingController();
  TimeOfDay _selectedTime =
      const TimeOfDay(hour: 7, minute: 30); // Default time
  DateTime _selectedEventDate = DateTime.now(); // Default to today
  IconData selectedIcon = Icons
      .water_drop; // Default icon - can be improved to be based on CareType

  @override
  void initState() {
    super.initState();
    _selectedEventDate =
        widget.selectedDate ?? DateTime.now(); // Use passed date or today
  }

  @override
  void dispose() {
    _plantNameController.dispose();
    _conditionController.dispose();
    _careDetailsController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEventDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedEventDate) {
      setState(() {
        _selectedEventDate = pickedDate;
      });
    }
  }

  void _saveReminder(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final newEvent = PlantEvent(
        plantName: _plantNameController.text,
        condition: _conditionController.text,
        careType: _selectedCareType?.name ??
            'Water', // Default to 'Water' if not selected
        careDetails: _careDetailsController.text,
        duration: _durationController.text,
        time: DateFormat('h:mm a').format(DateTime(
            _selectedEventDate.year,
            _selectedEventDate.month,
            _selectedEventDate.day,
            _selectedTime.hour,
            _selectedTime.minute)), // Format time
        image: '', // Image selection not implemented yet
        icon:
            selectedIcon, // Icon selection not implemented yet - default water drop
        eventDate: _selectedEventDate,
      );

      int result = await PlantEventService().addPlantEvent(newEvent);
      if (result > 0) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reminder Saved!')),
          );
          Navigator.pop(context, true);
        }
// Go back and signal data change
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save reminder.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(
                context); // Just pop, no data signal needed for cancel
          },
        ),
        title: const Text('Add Reminder'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _saveReminder(context),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _plantNameController,
              decoration: const InputDecoration(labelText: 'Plant Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter plant name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _conditionController,
              decoration:
                  const InputDecoration(labelText: 'Condition (Optional)'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<CareType>(
              decoration: const InputDecoration(labelText: 'Care Type'),
              value: _selectedCareType,
              items: CareType.values.map((CareType value) {
                return DropdownMenuItem<CareType>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (CareType? newValue) {
                setState(() {
                  _selectedCareType = newValue;
                  // You could potentially update _selectedIcon based on care type here if you implement icon selection
                });
              },
              validator: (value) =>
                  value == null ? 'Please select care type' : null,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _careDetailsController,
              decoration: const InputDecoration(
                  labelText: 'Care Details (e.g., Medium, Low)'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                  labelText:
                      'Duration (e.g., Alternative Days, 2 Days a Week)'),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        hintText: 'Select Time',
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            DateFormat('h:mm a').format(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                _selectedTime.hour,
                                _selectedTime.minute)),
                          ),
                          const Icon(Icons.access_time),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'Select Date',
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            DateFormat('MMM d, yyyy')
                                .format(_selectedEventDate),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Enum for CareType ---
enum CareType {
  water,
  fertilize,
  // Add more care types as needed
}

extension CareTypeName on CareType {
  String get name {
    switch (this) {
      case CareType.water:
        return 'Water';
      case CareType.fertilize:
        return 'Fertilize';

      // ignore: unreachable_switch_default
      default:
        return 'NoT Define';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
