part of 'registered_events_and_orders_cubit.dart';

abstract class RegisteredEventsAndOrdersState {}

class RegisteredEventsAndOrdersLoaded extends RegisteredEventsAndOrdersState {
  List<RegisteredEvent> registeredOrders;
  List<Events> registeredEvents;
  // temporary
  List<String> registeredCombos;
  RegisteredEventsAndOrdersLoaded(
    this.registeredEvents,
    this.registeredOrders,
    this.registeredCombos,
  );
}

class RegisteredEventsAndOrdersError extends RegisteredEventsAndOrdersState {
  final String errorMessage;

  RegisteredEventsAndOrdersError(this.errorMessage);
}

class RegisteredEventsAndOrdersLoading extends RegisteredEventsAndOrdersState {}

class RegisteredEvents extends RegisteredEventsAndOrdersState {
  List<BookedSlotModel> bookedEventList;
  RegisteredEvents(this.bookedEventList);
}

class RegisteredOrdersandEventsUpdates extends RegisteredEventsAndOrdersState {}
