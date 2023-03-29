part of 'event_slots_cubit.dart';

@immutable
abstract class EventSlotsState {}

class EventSlotsInitial extends EventSlotsState {}

class EventSlotsLoading extends EventSlotsState {}

class EventSlotsLoaded extends EventSlotsState {
  final dynamic data;
  EventSlotsLoaded(this.data);
}

class EventSlotsError extends EventSlotsState {
  final String message;
  EventSlotsError(this.message);
}

