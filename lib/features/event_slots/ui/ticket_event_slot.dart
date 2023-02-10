import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTicketView(),
    );
  }
}

class MyTicketView extends StatelessWidget {
  const MyTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var th;
    var tw;
    th = height / 2.4;
    tw = width / 1.2;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: TicketWidget(
          width: tw,
          height: th,
          color: Colors.black54,
          isCornerRounded: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.blueAccent.withOpacity(0.4),
                  Colors.blue,
                  Colors.blueAccent.withOpacity(0.4),
                  Colors.transparent
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: height / 35, left: width / 22),
              child: TicketData(),
            ),
          ),
        ),
        // color: Colors.transparent,
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size, height, width, th, tw;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    th = height / 2.4;
    tw = width / 1.2;
    return Stack(
      children: [
        Positioned(
          left: tw / 36,
          top: th / 20,
          child: Container(
            child: Text(
              'FANDOM',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: th / 7,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: tw / 36,
          top: th / 4.4,
          child: Container(
            child: Text(
              'Non Technical',
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: tw / 60,
          top: th / 2.8,
          child: Container(
            child: Text(
              "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
              style: TextStyle(
                fontSize: th / 14,
                fontWeight: FontWeight.w900,
                letterSpacing: tw / 250,
              ),
            ),
          ),
        ),
        Positioned(
          left: tw / 35,
          top: th / 2,
          child: Container(
            child: Text(
              "Registered at: You haven't ",
              style: TextStyle(fontSize: th / 15, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          left: tw / 35,
          top: th / 1.7,
          child: Container(
            child: Text(
              "booked a slot for this event",
              style: TextStyle(fontSize: th / 15, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          left: tw / 5.6,
          top: th / 1.37,
          right: tw / 4,
          child: Container(
              child: SizedBox(
            height: th / 8,
            width: th / 2.2,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
              onPressed: () {},
              child: Text(
                "Book Slot",
                style: TextStyle(fontSize: th / 17),
              ),
            ),
          )),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
