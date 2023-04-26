part of 'booked_slot_cubit.dart';

// @immutable
abstract class EventSlotStateCubit {}

class EventSlotInitialState extends EventSlotStateCubit {}

class EventSlotLoadingState extends EventSlotStateCubit {}

class BookedSlotState extends EventSlotStateCubit {}

class NotBookedSlotState extends EventSlotStateCubit {
  final EventSlot slot_list;
  
  NotBookedSlotState(this.slot_list);
}

class EventSlotErrorState extends EventSlotStateCubit {
  EventSlotErrorState(String e);
}

class BookingSuccessful extends EventSlotStateCubit {}
