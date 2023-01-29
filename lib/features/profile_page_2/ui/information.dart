import 'package:flutter/material.dart';

class EventDetails {
  String Eventname = "";
  String Slot = "";
  String date = "";

  EventDetails(
      {required this.Eventname, required this.Slot, required this.date});
}

Map<String, int> Year = {"FE": 0, "SE": 1, "TE": 2, "BE": 3};

class Info {
  String Name = "";
  String contact_no = "";
  String email = "";
  String userid = "";
  String year = "";
  int No_of_events_reg = 0;
  List<EventDetails> eventregistered = [];

  Info(
      {required this.Name,
      required this.No_of_events_reg,
      required this.contact_no,
      required this.email,
      required this.eventregistered,
      required this.userid,
      required this.year});
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
