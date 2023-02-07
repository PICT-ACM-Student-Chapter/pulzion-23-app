import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import '../models/eventlist.dart';

class EventDescriptionPage extends StatelessWidget {
  const EventDescriptionPage({super.key});

  Widget firstWid() {
    return Column(
      children: [
        DropShadow(
          spread: 1,
          offset: const Offset(15, 8),
          blurRadius: 12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
              child: Image.network(
                Events[0].imgUrl,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropShadow(
                spread: 1,
                blurRadius: 5,
                offset: const Offset(5, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Events[0].title,
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(width: 0.75, color: Colors.yellow),
                  color: const Color.fromARGB(255, 1, 13, 29),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Events[0].isTech
                          ? const Icon(
                              Icons.laptop_chromebook,
                              color: Colors.white,
                              size: 14,
                            )
                          : const Icon(
                              Icons.lightbulb_outline_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                      Text(
                        Events[0].isTech ? "   <TECH>" : "   <NON-TECH>",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget secondWid() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black54,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "  “ ${Events[0].tagline} ”  ",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            Events[0].explaination,
            style: const TextStyle(
              fontSize: 15,
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
            "Round Details",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(
            "Round 1: \n${Events[0].roundDetails["Round 1"]!}",
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Round 2: \n${Events[0].roundDetails["Round 2"]!}",
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
            "Rules",
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
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              ...Events[0].rules.entries.map((entry) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${entry.key}. ${entry.value}\n",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Team Distribution",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                ...Events[0].distribution.entries.map((entry) {
                  return Text(
                    "${entry.key}. ${entry.value}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 15,
            right: 15,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: const Color.fromARGB(255, 1, 13, 29).withBlue(70),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Text(
                          "FEES",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              " \tRs. ${Events[0].fees.toString()}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: const Color.fromARGB(255, 1, 13, 29).withBlue(70),
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        const Text(
                          "CONTACTS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        ...Events[0].contacts.entries.map((entry) {
                          return Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${entry.key}: ${entry.value}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 13, 29),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: firstWid(),
          ),
          Expanded(
            child: secondWid(),
          ),
        ],
      ),
    );
  }
}
