// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../Data/modals/plantevent_model.dart';
// import '../../Domain/plantevent_service.dart';


// part 'reminder_event.dart';
// part 'reminder_state.dart';

// class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
//   final PlantEventService _plantEventService;

//   ReminderBloc({PlantEventService? plantEventService})
//       : _plantEventService = plantEventService ?? PlantEventService(),
//         super(ReminderInitial()) {
//     on<LoadReminders>(_onLoadReminders);
//     on<DateChanged>(_onDateChanged);
//     on<AddNewReminder>(_onAddNewReminder);
//     on<SaveReminders>(_onSaveReminders);
//   }

//   Future<void> _onLoadReminders(LoadReminders event, Emitter<ReminderState> emit) async {
//     emit(ReminderLoading());
//     try {
//       final plantEvents = await _plantEventService.getPlantEventsForDate(event.selectedDate);
//       if (plantEvents.isEmpty) {
//         emit(ReminderEmpty(selectedDate: event.selectedDate));
//       } else {
//         emit(ReminderLoaded(plantEvents: plantEvents, selectedDate: event.selectedDate));
//       }
//     } catch (e) {
//       emit(ReminderError(message: 'Failed to load reminders: ${e.toString()}'));
//     }
//   }

//   Future<void> _onDateChanged(DateChanged event, Emitter<ReminderState> emit) async {
//     emit(ReminderLoading());
//     try {
//       final plantEvents = await _plantEventService.getPlantEventsForDate(event.selectedDate);
//       if (plantEvents.isEmpty) {
//         emit(ReminderEmpty(selectedDate: event.selectedDate));
//       } else {
//         emit(ReminderLoaded(plantEvents: plantEvents, selectedDate: event.selectedDate));
//       }
//     } catch (e) {
//       emit(ReminderError(message: 'Failed to load reminders: ${e.toString()}'));
//     }
//   }

//   Future<void> _onAddNewReminder(AddNewReminder event, Emitter<ReminderState> emit) async {
//     // Logic to navigate to add reminder screen or trigger add reminder flow
//     debugPrint('Add New Reminder Event triggered');
//   }

//   Future<void> _onSaveReminders(SaveReminders event, Emitter<ReminderState> emit) async {
//     // Logic to save reminders (potentially update or insert)
//     debugPrint('Save Reminders Event triggered');
//   }
// }