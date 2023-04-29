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
  final message;
  EventSlotErrorState(this.message);
}

class BookingSuccessful extends EventSlotStateCubit {
  late final BookedSlotModel bookedSlotModel;
  BookingSuccessful(this.bookedSlotModel);
}

class NoAvailableSlots extends EventSlotStateCubit {}
