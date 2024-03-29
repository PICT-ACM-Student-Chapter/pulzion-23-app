import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import '../../../../constants/widgets/empty_page.dart';
import 'ticket_widget.dart';

class RegisteredEventsCards extends StatelessWidget {
  final List<Events> registeredEvents;
  RegisteredEventsCards({super.key, required this.registeredEvents});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var th = height / 2.4;

    return registeredEvents.isEmpty
        ? const Center(
            child: EmptyPage(
              errorMessage:
                  'Go ahead and purchase some events and enjoy Pulzion\'23',
              title: 'No event registered',
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => MyTicketView(
              id: registeredEvents[index].id!,
              name: registeredEvents[index].name!,
              description: registeredEvents[index].description!,
              eventType: registeredEvents[index].type!,
              logo: registeredEvents[index].logo!,
              isBooked: registeredEvents[index].fk_slot,
            ),
            itemCount: registeredEvents.length,
          );
    // : ListWheelScrollView.useDelegate(
    //     itemExtent: th,
    //     physics: const FixedExtentScrollPhysics(),
    //     perspective: 0.0012,
    //     diameterRatio: 1.2,
    //     childDelegate: ListWheelChildBuilderDelegate(
    //       childCount: registeredEvents.length,
    //       builder: (context, index) => MyTicketView(
    //         id: registeredEvents[index].id!,
    //         name: registeredEvents[index].name!,
    //         description: registeredEvents[index].description!,
    //         eventType: registeredEvents[index].type!,
    //         logo: registeredEvents[index].logo!,
    //       ),
    //     ),
    //   );
  }
}
