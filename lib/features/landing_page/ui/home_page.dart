import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final fontSizeFactor = h / w;
    return Scaffold(
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: Text("Add to cart"),
      //   icon: Icon(Icons.shopping_cart),
      //   extendedPadding: EdgeInsets.all(MediaQuery.of(context).size.width*1/10),
      //
      // ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.black, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 3,
            blurRadius: 9,
            offset: Offset(0, -4), // changes position of shadow
          ),
        ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: h / 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: Text("PRICE",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs. 30",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "/person",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Color(0xff07f49e), Color(0xff42047e)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add to Cart  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: h / 3,
                      child: Lottie.asset("assets/images/space.json",
                          fit: BoxFit.fill)),
                  Container(
                    height: h / 2.8,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.deepPurple.withOpacity(0.3),
                          Colors.black
                        ])),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/icon.png",
                            scale: 6,
                          ),
                          Text(
                            "Pulzion Event Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSizeFactor * 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 12),
                            //height: h / 10,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 12),

                            //height: h / 10,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              "Rounds",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 12),

                            //height: h / 10,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              "Rules",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Container(
                          child: Text(
                            "\"Logic is the fragrance of a coder\'s garden.\"",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontFamily: 'Montserrat',
                              fontSize: fontSizeFactor * 8,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFfafafa),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        child: Text(
                          "Before diving into the jargon of every programming language available, one must first establish a sharp sense of how to approach problems. Recode It gives you a chance to put your logical and analytical skills to the test, which are crucial for becoming a strong coder.",
                          style: TextStyle(
                            //fontFamily: 'Montserrat',
                            fontSize: fontSizeFactor * 8,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Round Details:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //fontFamily: 'Montserrat',
                          fontSize: fontSizeFactor * 8.5,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '''Round 1: This is the MCQ round. The participants will be allowed to use a computer to code the solution if required, or they can solve it on paper.
Round 2: The second round will be conducted on our platform where participants can run the executable files any number of times against the input they want. From the given custom inputs and received outputs, the participant needs to figure out the logic of the code of the executable file and code it.''',
                      style: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontSize: fontSizeFactor * 8,
                        color: const Color(0xFFfafafa),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Rules',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //fontFamily: 'Montserrat',
                          fontSize: fontSizeFactor * 8.5,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '''1. Both groups, FE-SE and TE-BE would be given a maximum of 30 minutes to complete the questions of the first round.
2. Both the groups, FE-SE and TE-BE, will be given a maximum of 120 minutes to complete the questions of the second round.
3. Permitted languages will be C, C+, Python and Java.
4. Use of unfair means will result in direct disqualification.
5. The decision of the organizers will be considered final and binding for all participants.''',
                      style: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontSize: fontSizeFactor * 8,
                        color: const Color(0xFFfafafa),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Team Details :',
                        style: TextStyle(
                          //fontFamily: 'Montserrat',
                          fontSize: fontSizeFactor * 8.5,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '''FE-SE (Junior Category): Individual participation
TE-BE (Senior Category): Individual participation''',
                      style: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontSize: fontSizeFactor * 8,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: h / 12,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
