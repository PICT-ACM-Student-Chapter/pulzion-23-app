import 'package:flutter/material.dart';

import 'package:panorama/panorama.dart';
import '../../../constants/images.dart';


class BookedWindow extends StatefulWidget {
  const BookedWindow({super.key});

  @override
  State<BookedWindow> createState() => _BookedWindowState();
}

class _BookedWindowState extends State<BookedWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Color> notselected = [

    Colors.white.withOpacity(0.2),
    Colors.black.withOpacity(0.3),

  ];
  List<Color> selected = [
    Colors.white.withOpacity(0.3),
    Colors.white.withOpacity(0.6),
  ];
  List<bool> c = [false, false, false, false];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
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

          height: h * 0.09,
          width: w * 0.2,

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


  Widget EventDate(double h, double w, String eventDate, String eventDay) {

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
                  eventDay,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: h * 0.028,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(h * 0.002),
                child: Text(
                  eventDate,
                  style: TextStyle(fontSize: h * 0.025),
                ),
              ),
            ],
          ),
        ),
        height: h * 0.15,
        width: w * 0.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color.fromARGB(255, 35, 21, 57),
              Colors.black.withOpacity(0.4),
              Colors.white.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(h * 0.095),
          border: Border.all(
            color: Colors.white,
            width: h * 0.001,
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
            Column(
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
                  child: Center(
                      child: Text(
                    "Event logo",
                    style: TextStyle(color: Colors.white),
                  )),
                  height: h * 0.2,
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
                      borderRadius: BorderRadius.circular(h * 0.045),
                      border: Border.all(
                        color: Colors.white,
                        width: h * 0.001,
                      )),
                ),
                SizedBox(height: h * 0.02),
                AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: const Duration(seconds: 5),
                    height: h * 0.1,
                    width: w * 0.4,
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
                        border: Border.all(
                          color: Colors.white,
                          width: h * 0.001,
                        )),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "EVENT NAME ",
                          style: TextStyle(color: Colors.white),
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
                        border: Border.all(
                          color: Colors.white,
                          width: h * 0.001,
                        )),
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
                    child: Text(
                      "Event Date: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: h * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EventDate(h, w, "12", "WED"),
                    EventDate(h, w, "13", "THU"),
                    EventDate(h, w, "14", "FRI"),
                  ],
                ),
                SizedBox(height: h * 0.01),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Slot: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: h * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EventSlot(0, h, w),
                    EventSlot(1, h, w),
                    EventSlot(2, h, w),
                    EventSlot(3, h, w),
                  ],
                ),
                SizedBox(height: h * 0.02),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('SLOT BOOKED'),
                          content: const Text('Your slot has been booked!'),
                          actions: [
                            TextButton(
                              child: const Text('Close'),
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
                        borderRadius: BorderRadius.circular(12),
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
                            Icons.shopping_cart,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
