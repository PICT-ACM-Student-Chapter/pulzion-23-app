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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: h/2,
                      child: Lottie.asset("assets/images/space.json",fit: BoxFit.fill)),
                  Container(
                    height: h/2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.deepPurple.withOpacity(0.3),Colors.black])
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Padding(padding: const EdgeInsets.all(8.0),
                  child:Container(

                    child: Row(
                      children: [
                        Container(
                          color: Colors.pinkAccent,
                        ),
                        Container(
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
              ),
                  Padding(padding: const EdgeInsets.all(8.0),
                      child:Container(
                        color: Colors.grey,
                        child: Text("Description......."),
                      ),
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                    child:Container(
                      color: Colors.red,
                      child: Text("kuch toh"),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                    child:Container(
                      color: Colors.deepOrangeAccent,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.lightBlueAccent,
                          ),
                          Container(
                            color: Colors.lightGreen,
                          )
                        ],
                      ),
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
