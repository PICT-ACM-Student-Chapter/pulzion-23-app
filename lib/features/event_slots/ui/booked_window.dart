import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';
import '../../../constants/images.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: BookedWindow())));
}

class BookedWindow extends StatefulWidget {
  @override
  State<BookedWindow> createState() => _BookedWindowState();
}

class _BookedWindowState extends State<BookedWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Color> notselected = [
    Colors.white.withOpacity(0.23),
    Colors.white.withOpacity(0.05),
  ];
  List<Color> selected = [
    Colors.white.withOpacity(0.3),
    Colors.white.withOpacity(0.6),
  ];
  List<bool> c = [false, false, false, false];
  List<bool> ed = [false, false, false];
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Widget EventSlot(
    int i,
    double h,
    double w,
  ) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              (h * 0.09),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: c[i] ? selected : notselected,
            ),
          ),
          child: Center(
            child: Text(
              "1 to 2",
              style: TextStyle(
                  color: c[i] ? Colors.black : Colors.white,
                  fontWeight: c[i] ? FontWeight.bold : FontWeight.w100),
            ),
          ),
          height: h * 0.07,
          width: w * 0.25,
        ),
      ),
      onTap: () {
        setState(() {
          for (int k = 0; k < 4; k++) {
            if (k == i) {
              c[i] = true;
            } else {
              c[k] = false;
            }
          }
        });
      },
    );
  }

  Widget EventDate(
      double h, double w, String event_date, String event_day, int i) {
    setState(() {
      int k = 1;
      if (k == i) {
        ed[i] = true;
      } else {
        ed[i] = false;
      }
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: h * 0.03,
              ),
              Padding(
                padding: EdgeInsets.all(h * 0.005),
                child: Text(
                  event_day,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: h * 0.020,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(h * 0.002),
                child: Text(
                  event_date,
                  style: TextStyle(
                    fontSize: h * 0.020,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        height: h * 0.13,
        width: w * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h / 20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ed[i] ? selected : notselected,
          ),
        ),
      ),
    );
  }

  //main ui starts from here
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Panorama(
              sensitivity: 0.4,
              animSpeed: 0.5,
              sensorControl: SensorControl.Orientation,
              child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "BOOK SLOT",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    height: 30,
                    width: double.infinity,
                  ),
                  SizedBox(height: h * 0.03),
                  Container(
                    child: FittedBox(
                      child: Image.network(
                          "https://pulzion-website-images.s3.ap-south-1.amazonaws.com/logos/Codelicious.png"),
                    ),
                    height: h * 0.2,
                    width: h * 0.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(.2),
                          Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
                          Colors.white.withOpacity(.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(h * 0.45),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  AnimatedContainer(
                      curve: Curves.easeIn,
                      duration: const Duration(seconds: 5),
                      height: h * 0.08,
                      width: h * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(.2),
                            Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
                            Colors.white.withOpacity(.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(h * 0.035),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Codelicious",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: w * 0.06,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                      height: h * 0.055,
                      width: w - w * 0.05,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(.2),
                            Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
                            Colors.white.withOpacity(.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(h * 0.035),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(h * 0.01),
                          child: Text(
                            "Welcome to this event of pulzion 2023.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  SizedBox(height: h * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            "Event Date: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: h * 0.025,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EventDate(h, w, "12", "WED", 0),
                      EventDate(h, w, "13", "THU", 1),
                      EventDate(h, w, "14", "FRI", 2),
                    ],
                  ),
                  SizedBox(height: h * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.lock_clock_outlined, color: Colors.white),
                          SizedBox(width: w * 0.02),
                          Text(
                            "Select Slot: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: h * 0.025,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        EventSlot(0, h, w),
                        EventSlot(1, h, w),
                        EventSlot(2, h, w),
                        EventSlot(3, h, w),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('SLOT BOOKED'),
                            content: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  weight: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      const Text('Your slot has been booked!'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'Close',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: w - w * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(h * 0.09),
                          gradient: const LinearGradient(
                              colors: [Color(0xff07f49e), Color(0xff42047e)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "CONFIRM SLOT  ",
                              style: TextStyle(color: Colors.white),
                            ),
                            const Icon(
                              Icons.book,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
