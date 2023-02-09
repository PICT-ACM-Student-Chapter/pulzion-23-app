import 'package:flutter/material.dart';

void main() {
  runApp(const Cart());
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // var A = Border(BorderRadius.only(
    //     topLeft: Radius.circular(45), topRight: Radius.circular(45)));
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 9, 28, 43),
        body: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Stack(children: [
            Positioned(
                top: 0,
                height: h * 0.1,
                width: w,
                child: Container(
                    padding: EdgeInsets.only(top: h * 0.01),
                    height: 0.1 * h,
                    color: Color.fromARGB(255, 35, 94, 143),
                    child: Card(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "MY CART",
                          style: TextStyle(
                              fontSize: h * 0.05,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ))),
            Positioned(
              top: 0.1 * h,
              height: h * 0.5,
              width: w,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                height: 0.3 * h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(2),
                          height: h / 5,
                          width: w - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 8, 33, 54),
                                    Colors.blueAccent,
                                    Color.fromARGB(255, 8, 33, 54),
                                  ])),
                          child: Row(children: [
                            Container(
                              height: h / 4,
                              width: w / 4,
                              child: Image.network(
                                  "https://pict.acm.org/pulzion19/About-us/data1/PASClogo.png"),
                            ),
                            SizedBox(
                              height: h / 10,
                              width: w / 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("AMOUNT"),
                                  SizedBox(
                                    height: h / 20,
                                    width: w / 10,
                                  ),
                                  Text("EVENT NAME")
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ])),
                      Divider(
                        thickness: h / 50,
                      ),
                      Container(
                          padding: EdgeInsets.all(4),
                          height: h / 5,
                          width: w - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 8, 33, 54),
                                    Colors.blueAccent,
                                    Color.fromARGB(255, 8, 33, 54),
                                  ])),
                          child: Row(children: [
                            Container(
                              height: h / 5,
                              width: w / 4,
                              child: Image.network(
                                  "https://pict.acm.org/pulzion19/About-us/data1/PASClogo.png"),
                            ),
                            SizedBox(
                              height: h / 10,
                              width: w / 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("AMOUNT"),
                                  SizedBox(
                                    height: h / 20,
                                    width: w / 10,
                                  ),
                                  Text("EVENT NAME")
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ])),
                      Divider(
                        thickness: h / 50,
                      ),
                      Container(
                          padding: EdgeInsets.all(4),
                          height: h / 5,
                          width: w - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 8, 33, 54),
                                    Colors.blueAccent,
                                    Color.fromARGB(255, 8, 33, 54),
                                  ])),
                          child: Row(children: [
                            Container(
                              height: h / 5,
                              width: w / 4,
                              child: Image.network(
                                  "https://pict.acm.org/pulzion19/About-us/data1/PASClogo.png"),
                            ),
                            SizedBox(
                              height: h / 10,
                              width: w / 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("AMOUNT"),
                                  SizedBox(
                                    height: h / 20,
                                    width: w / 10,
                                  ),
                                  Text("EVENT NAME")
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ])),
                      Divider(
                        thickness: h / 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0.6 * h,
                height: 0.4 * h,
                width: w - 2,
                // key: A,
                child: Container(
                  height: 0.4 * h,
                  width: w - 2,
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey,
                                Colors.black26,
                              ])),
                      height: h * 0.35,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(children: [
                              Text(
                                "CART SUMMARY",
                                style: TextStyle(fontSize: h * 0.04),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text("EVENT 1"),
                                    Text("AMOUNT"),
                                    SizedBox(height: h * 0.07)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text("EVENT 2"),
                                    Text("AMOUNT"),
                                    SizedBox(height: h * 0.07)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text("EVENT 3"),
                                    Text("AMOUNT"),
                                    SizedBox(height: h * 0.07)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      Text("EVENT 4"),
                                      Text("AMOUNT"),
                                      SizedBox(height: h * 0.07)
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text("CHECKOUT"))
                        ],
                      ),
                    ),
                  ),
                ))
          ]),
        ));
  }
}
// color: Colors.amber,






