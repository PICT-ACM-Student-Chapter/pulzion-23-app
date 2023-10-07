import 'package:flutter/material.dart';
import 'package:pulzion23/constants/styles.dart';

import '../../../../constants/models/event_model.dart';

class EventMode extends StatelessWidget {
  final Events event;
  const EventMode({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade900.withOpacity(0.9),
            Color.fromARGB(255, 54, 19, 1).withOpacity(0.9),
            // const Color.fromARGB(255, 13, 69, 115).withOpacity(0.1),
            // Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.only(right: 2),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        child: Text(
          event.mode == 'Online' ? 'Online' : 'Offline',
          style: AppStyles.NormalText()
              .copyWith(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
