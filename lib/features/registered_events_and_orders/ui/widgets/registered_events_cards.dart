
import 'package:flutter/material.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import '../../../../constants/widgets/empty_page.dart';
import 'ticket_widget.dart';

class RegisteredEventsCards extends StatelessWidget {
  final List<Events> registeredEvents;
  final List<String> regsieteredCombos;
  const RegisteredEventsCards({
    super.key,
    required this.registeredEvents,
    required this.regsieteredCombos,
  });

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
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return index < registeredEvents.length
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: MyTicketView(
                        id: registeredEvents[index].id!,
                        name: registeredEvents[index].name!,
                        description: registeredEvents[index].description!,
                        eventType: registeredEvents[index].type!,
                        logo: registeredEvents[index].logo!,
                        isBooked: registeredEvents[index].fk_slot,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: MyTicketView(
                        id: null,
                        name:
                            regsieteredCombos[index - registeredEvents.length],
                        description: null,
                        eventType: null,
                        logo: null,
                        isBooked: null,
                      ),
                    );
            },
            itemCount: registeredEvents.length + regsieteredCombos.length,
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
