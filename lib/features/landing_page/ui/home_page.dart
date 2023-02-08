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
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: h/3,
                  child: Lottie.asset("assets/images/space.json",fit: BoxFit.fill)),
              Padding(
                padding: EdgeInsets.only(top: h/4+20),
                child: Container(
                  height: h/9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.deepPurple.withOpacity(0.3),Colors.black])
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: h/3,
            color: Colors.black,
          ),
          Container(
            height: h/3,
            color: Colors.pinkAccent,
          ),
          Container(
            height: h/3,
            color: Colors.red,
          ),
          Container(
            height: h/3,
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }
}
