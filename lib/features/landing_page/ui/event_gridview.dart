import 'package:flutter/material.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import '../logic/event.dart';
import 'event_card.dart';

class EventGridView extends StatelessWidget {
  final List<Events> eventList;
  const EventGridView(this.eventList, {super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: eventList.length,
      itemBuilder: ((context, index) {
        final event = eventList[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width*0.02),
          child: EventCard(event),
        );
      }),
    );
  }
}
