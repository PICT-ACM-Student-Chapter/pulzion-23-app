import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatefulWidget {

  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool a= false;


  bool ?_updateState(){
    setState(() {
      a = true;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animation',
        color: Colors.black,
        home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[


                      Container(
                        height: h*0.9,
                        width: w,
                        child: Stack(

                            children:[
                              Positioned(
                                top: 100,

                                height: 200,
                                child: AnimatedAlign(
                                    duration: Duration(milliseconds: 2400),
                                    alignment:
                                    a == true?Alignment.bottomCenter:Alignment.topCenter,

                                    child: Transform.rotate(
                                      angle: pi,
                                      child: Image(
                                        width: 100,
                                        height: 100,
                                        image: AssetImage('images/rocket3.gif'),
                                      ),
                                    )
                                ),
                              ),
                            ]
                        ),
                      ),
                      Container(
                        height: h*0.1,
                        width: w,
                        child: FloatingActionButton(onPressed: (){
                          _updateState();
                        },backgroundColor: Colors.black,
                            child: Text("animate")),

                      ),
                    ]
                )
            )
        )
    );
  }
}
