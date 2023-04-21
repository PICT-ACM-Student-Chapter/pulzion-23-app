part of 'registered_events_and_orders_cubit.dart';

abstract class RegisteredEventsAndOrdersState {}

class RegisteredEventsAndOrdersLoaded extends RegisteredEventsAndOrdersState {
  List<RegisteredEvent> registeredOrders;
  List<Events> registeredEvents;
  RegisteredEventsAndOrdersLoaded(this.registeredEvents, this.registeredOrders);
}

class RegisteredEventsAndOrdersError extends RegisteredEventsAndOrdersState {
  final String errorMessage;

  RegisteredEventsAndOrdersError(this.errorMessage);
}

class RegisteredEventsAndOrdersLoading extends RegisteredEventsAndOrdersState {}

class OrdersLoading extends RegisteredEventsAndOrdersState {}


class OrdersLoaded extends RegisteredEventsAndOrdersState {
  List<String> l;
  OrdersLoaded(this.l);
}
