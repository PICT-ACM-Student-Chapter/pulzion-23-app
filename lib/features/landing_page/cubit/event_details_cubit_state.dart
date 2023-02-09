part of 'event_details_cubit_cubit.dart';

@immutable
abstract class EventDetailsCubitState {}

class EventDetailsCubitInitial extends EventDetailsCubitState {}

class EventDetailsCubitLoading extends EventDetailsCubitState {}

class EventDetailsCubitLoaded extends EventDetailsCubitState {
  EventDetailsCubitLoaded(EventList events);
}

class EventDetailsCubitError extends EventDetailsCubitState {
  EventDetailsCubitError(String error);
}