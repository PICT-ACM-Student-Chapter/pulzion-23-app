import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../logic/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int index;
  final int listLength;
  const EventCard(this.event, this.listLength, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final double cardWidth =
        MediaQuery.of(context).size.width * 0.85 - 12 * index;
    final double cardHeight = MediaQuery.of(context).size.height * 0.47;
    return Container(
      padding: const EdgeInsets.all(16),
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(event.imageAddress),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: cardHeight * 0.3,
            width: cardWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(215, 255, 255, 255),
              border: Border.all(
                color: Colors.black,
                width: 0.01,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: cardHeight * 0.205,
                        width: cardWidth * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                event.description,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: cardWidth * 0.16,
                        height: cardHeight * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(200, 255, 255, 255),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.01,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              DateFormat.E()
                                  .format(event.date)
                                  .substring(0, 3)
                                  .toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.d().format(event.date),
                              style: const TextStyle(
                                color: Color.fromRGBO(77, 16, 158, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Register Now',
                          style: TextStyle(
                            color: Color.fromRGBO(49, 19, 91, 1),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: FittedBox(
                              child: Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
