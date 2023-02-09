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
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h / 10,
                  color: Colors.lightBlueAccent,
                  child: Text("ajshajshajshadfdeddsdjhsha"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h / 10,
                  color: Colors.lightGreen,
                  child: Text("hshakjskhjashakjsh"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: h / 2,
                      child: Lottie.asset("assets/images/space.json",
                          fit: BoxFit.fill)),
                  Container(
                    height: h / 2,
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: Container(


                              height: h / 10,
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),

                              child: Text("placehgfhghfgg info"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: h / 10,
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              child: Text("sdhgudhdjahasjahhjhj"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: h / 14,
                      width: w,
                      color: Colors.grey,
                      child: Text("Description......."),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: h / 14,
                      width: w,
                      color: Colors.red,
                      child: Text("kuch toh"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: h / 14,
                      width: w,
                      color: Colors.grey,
                      child: Text("Description......."),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
