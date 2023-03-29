import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

class MyTicketView extends StatelessWidget {
  final String name1;
  final String description1;
  final String isBooked1;
  MyTicketView(
      {required this.name1,
      required this.description1,
      required this.isBooked1});

  @override
  Widget build(BuildContext context) {
    var size, height, width, th, tw;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    th = height / 2.4;
    tw = width / 1.2;

    return Padding(
      padding: EdgeInsets.all(tw / 16),
      child: TicketWidget(
        width: tw,
        height: th,
        color: Colors.transparent,
        isCornerRounded: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(th * 0.07),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white24,
                Colors.white24,
              ],
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(top: height / 35, left: width / 22),
              child: SizedBox(
                height: th,
                width: tw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: th / 28, left: tw / 25, right: tw / 15),
                      child: Text(
                        name1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: tw / 6.5,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: th / 70, left: tw / 25),
                      child: Text(
                        description1,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: tw / 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: th / 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: th * 0.101,
                          ),
                          DottedLine(
                            lineThickness: tw / 130,
                            dashGapLength: tw / 40,
                            dashLength: tw / 25,
                          ),
                          Container(
                            margin: EdgeInsets.all(tw / 10),
                            child: Text(
                              "Registered at : You haven't booked a slot for this event",
                              style: TextStyle(
                                fontSize: tw / 17,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              isBooked1,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 4, 30, 64),
                                  fontWeight: FontWeight.bold,
                                  fontSize: tw / 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
