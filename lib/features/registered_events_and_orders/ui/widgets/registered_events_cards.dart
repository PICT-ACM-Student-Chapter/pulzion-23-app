import 'package:flutter/material.dart';

import 'ticket_widget.dart';

class RegisteredEventsCards extends StatelessWidget {
  final List registeredEvents;
  const RegisteredEventsCards({super.key, required this.registeredEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => MyTicketView(
        name: registeredEvents[index],
      ),
      itemCount: registeredEvents.length,
    );
  }
}
