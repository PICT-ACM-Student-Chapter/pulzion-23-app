part of 'mcq_event_list_cubit.dart';

abstract class EventListState {}

class EventPageLoading extends EventListState {}

class EventPageError extends EventListState {
  final String message;
  EventPageError(this.message);
}

class EventPageEmpty extends EventListState {}

class EventPageCurrentEvents extends EventListState {}
