import 'package:flutter/material.dart';
import '../logic/event.dart';
import 'event_card.dart';

class EventGridView extends StatelessWidget {
  final List<Event> eventList;
  const EventGridView(this.eventList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: eventList.length,
      itemBuilder: ((context, index) {
        final event = eventList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: EventCard(event),
        );
      }),
    );
  }
}
