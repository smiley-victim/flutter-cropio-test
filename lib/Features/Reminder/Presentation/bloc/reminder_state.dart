// part of 'reminder_bloc.dart';

// abstract class ReminderState extends Equatable {
//   const ReminderState();

//   @override
//   List<Object> get props => [];
// }

// class ReminderInitial extends ReminderState {}

// class ReminderLoading extends ReminderState {}

// class ReminderLoaded extends ReminderState {
//   final List<PlantEvent> plantEvents;
//   final DateTime selectedDate;

//   const ReminderLoaded({required this.plantEvents, required this.selectedDate});

//   @override
//   List<Object> get props => [plantEvents, selectedDate];
// }

// class ReminderError extends ReminderState {
//   final String message;

//   const ReminderError({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// class ReminderEmpty extends ReminderState {
//   final DateTime selectedDate;

//   const ReminderEmpty({required this.selectedDate});

//   @override
//   List<Object> get props => [selectedDate];
// }