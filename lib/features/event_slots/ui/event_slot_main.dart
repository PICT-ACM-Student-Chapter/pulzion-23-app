import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ticket_widget/ticket_widget.dart';
import './event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ticket(
        dummy_event: dummy_event,
      ),
    );
  }
}

class Events {
  String? name;
  String? description;
  String? isBooked;

  Events({
    this.name,
    this.description,
    this.isBooked,
  });
}

List<Events> dummy_event = [
  Events(
    name: "FANDOM",
    description: "Non-Technical",
    isBooked: "Not BOOKED",
  ),
  Events(
    name: "WEB AND APP",
    description: "Technical",
    isBooked: "Not BOOKED",
  ),
  Events(
    name: "DEXTROUS",
    description: "Non-Technical",
    isBooked: "BOOKED",
  ),
  Events(
    name: "BUG OFF",
    description: "Technical",
    isBooked: "BOOKED",
  )
];

class Ticket extends StatelessWidget {
  List<Events> dummy_event;
  Ticket({super.key, required this.dummy_event});

  @override
  Widget build(BuildContext context) {
    // final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
    return Scaffold(
      backgroundColor: Colors.blue[900]!.withOpacity(0.3),
      body: ListView.builder(
        itemBuilder: (context, index) => MyTicketView(
            name1: dummy_event[index].name!,
            description1: dummy_event[index].description!,
            isBooked1: dummy_event[index].isBooked!),
        itemCount: dummy_event.length,
      ),
    );
  }
}
