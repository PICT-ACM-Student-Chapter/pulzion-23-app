import 'package:flutter/material.dart';
import '../../../../constants/models/event_model.dart';

import '../../../../constants/widgets/empty_page.dart';
import 'ticket_widget.dart';

class RegisteredEventsCards extends StatelessWidget {
  final List<Events> registeredEvents;
  const RegisteredEventsCards({super.key, required this.registeredEvents});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    // var width = size.width;
    var th = height / 2.4;
    // var tw = width / 1.2;

    return registeredEvents.isEmpty
        ? const Center(
            child: EmptyPage(
              errorMessage:
                  'Go ahead and purchase some events and enjoy Pulzion\'23',
              title: 'No event registered',
            ),
          )
        // : ListView.builder(
        //     itemBuilder: (context, index) =>
        //         MyTicketView(name: 'Wed and App Dev'),
        //     itemCount: 5,
        //   );
        : ListWheelScrollView.useDelegate(
            itemExtent: th,
            physics: const FixedExtentScrollPhysics(),
            perspective: 0.0012,
            diameterRatio: 1.2,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: registeredEvents.length,
              builder: (context, index) => MyTicketView(
                name: registeredEvents[index].name!,
                description: registeredEvents[index].description!,
                eventType: registeredEvents[index].type!,
              ),
            ),
          );
  }
}
