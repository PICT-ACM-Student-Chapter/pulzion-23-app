part of 'event_details_cubit_cubit.dart';

@immutable
abstract class EventDetailsCubitState {}

class EventDetailsCubitInitial extends EventDetailsCubitState {}

class EventDetailsCubitLoading extends EventDetailsCubitState {}

class EventDetailsCubitLoaded extends EventDetailsCubitState {
  //EventList events;
  List<Events> techEvents;
  List<Events> nonTechEvents;
  EventDetailsCubitLoaded(this.techEvents,this.nonTechEvents);
}

class EventDetailsCubitError extends EventDetailsCubitState {
  EventDetailsCubitError(String error);
}