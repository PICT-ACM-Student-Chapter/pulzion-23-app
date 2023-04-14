import 'package:flutter/material.dart';

import '../../../../constants/widgets/empty_page.dart';
import 'ticket_widget.dart';

class RegisteredEventsCards extends StatelessWidget {
  final List registeredEvents;
  const RegisteredEventsCards({super.key, required this.registeredEvents});

  @override
  Widget build(BuildContext context) {
    return registeredEvents.isEmpty
        ? const Expanded(
            child: Center(
              child: EmptyPage(
                errorMessage:
                    'Go ahead and purchase some events and enjoy Pulzion\'23',
                title: 'No event registered',
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => MyTicketView(
              name: registeredEvents[index],
            ),
            itemCount: registeredEvents.length,
          );
  }
}
