part of 'booked_slot_cubit.dart';

@immutable
abstract class EventSlotStateCubit {}

class EventSlotInitialState extends EventSlotStateCubit {}

class EventSlotLoadingState extends EventSlotStateCubit {}

class BookedSlotState extends EventSlotStateCubit {}

class NotBookedSlotState extends EventSlotStateCubit {}

class EventSlotErrorState extends EventSlotStateCubit {
  EventSlotErrorState(String e);
}
