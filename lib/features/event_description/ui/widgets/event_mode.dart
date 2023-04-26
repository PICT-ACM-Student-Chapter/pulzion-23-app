import 'package:flutter/material.dart';

import '../../../../constants/models/event_model.dart';

class EventMode extends StatelessWidget {
  final Events event;
  const EventMode({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.only(right: 2),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        child: Text(
          event.mode == 'Online' ? 'Online' : 'Offline',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'QuickSand',
          ),
        ),
      ),
    );
  }
}
