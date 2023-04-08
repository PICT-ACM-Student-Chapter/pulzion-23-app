import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lottie/lottie.dart';

class NotBookedWindow extends StatelessWidget {
  const NotBookedWindow({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //backgroundColor: Color(),
        scaffoldBackgroundColor: const Color(0XFF000067),
      ),
      home: const ticket(),
    );
  }
}

class ticket extends StatefulWidget {
  const ticket({Key? key}) : super(key: key);

  @override
  State<ticket> createState() => _ticketState();
}

class _ticketState extends State<ticket> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://getwallpapers.com/wallpaper/full/8/f/8/317601.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GlassmorphicContainer(
          margin:
              const EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 60),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          blur: 0.2,
          borderRadius: 20,
          border: 2,
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0),
              const Color((0xFFffffff)).withOpacity(0),
            ],
          ),
          linearGradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xFFffffff).withOpacity(0.08),
                const Color(0xFFffffff).withOpacity(0.08),
              ],
              stops: const [
                0.1,
                1,
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // const Expanded(child: Text(''),
              // flex: 2,),
              Container(
                height: screenheight * 0.38,
                child: const Image(
                  image: AssetImage('assets/images/not_booked.jpeg'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    const Text(
                      'Fandom',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.02,
                    ),
                    //),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'You see your favourite fandom, we test your craziness',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: const [
                          Text(
                            'Name',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.005,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Row(
                        children: const [
                          Text(
                            'ADITI DATE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: screenwidth * 0.01,
                          ),
                          const Expanded(
                              child: Text(
                            'Date',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )),
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: screenwidth * 0.01,
                          ),
                          const Expanded(
                              child: Text(
                            'Time',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.005,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, bottom: 8),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Text(
                            '11-04-2023',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            '9:30-11:30',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: screenheight * 0.02),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Transaction ID',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: screenheight * 0.005,
                            ),
                            const Text(
                              'ADCDIOEDBVFEBIER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
