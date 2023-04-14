import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../event_slots/logic/booked_slot_cubit.dart';
import 'booked_window.dart';
import 'not_booked_window.dart';

class EventBookingPage extends StatelessWidget {
  static const routeName = '/event-page';
  const EventBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventSlotsCubit, EventSlotStateCubit>(
      bloc: EventSlotsCubit()..getBookingDetails(),
      builder: (context, state) {
        if (state is BookedSlotState) {
          return const BookedWindow();
        } else if (state is NotBookedSlotState) {
          return const NotBookedWindow();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
