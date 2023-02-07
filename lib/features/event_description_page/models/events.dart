// import 'package:flutter/material.dart';

class Event {
  final String imgUrl;
  final String title;
  final String tagline;
  final String explaination;
  final Map<int, String> rules;
  final Map<String, String> distribution;
  final int fees;
  final bool isTech;
  final Map<String, String> contacts;
  final Map<String, String> roundDetails;

  Event({
    required this.title,
    required this.imgUrl,
    required this.tagline,
    required this.isTech,
    required this.explaination,
    required this.roundDetails,
    required this.rules,
    required this.distribution,
    required this.fees,
    required this.contacts,
  });
}

/*const Divider(
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Registration Fees",
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: Colors.yellow,
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "\tRs. ${Events[0].fees.toString()}",
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Contacts",
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: Colors.yellow,
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                ...Events[0].contacts.entries.map(
                  (entry) {
                    return Text(
                      "${entry.key}: ${entry.value}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ), */
