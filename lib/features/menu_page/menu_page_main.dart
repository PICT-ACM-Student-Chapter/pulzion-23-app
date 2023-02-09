import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import './frostedglass.dart';
import './childWid.dart';
import './rocket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FrostedGlassTile(),
    );
  }
}

class FrostedGlassTile extends StatefulWidget {
  @override
  State<FrostedGlassTile> createState() => _FrostedGlassTileState();
}

class _FrostedGlassTileState extends State<FrostedGlassTile> {
  bool isRocket = true;
  bool _op = true;

  void setRocket() {
    setState(() {
      isRocket = false;
      _op = false;
    });
  }

  List<FrostedTile> fl = [
    FrostedTile(
      tilename: 'Login',
      tileicon: Icons.person_outlined,
    ),
    FrostedTile(
      tilename: 'Sign Up',
      tileicon: Icons.login,
    ),
    FrostedTile(
      tilename: 'Sponsors',
      tileicon: Icons.monetization_on_outlined,
    ),
    FrostedTile(
      tilename: 'About Us',
      tileicon: Icons.info_outline,
    ),
    FrostedTile(
      tilename: 'Developers',
      tileicon: Icons.laptop,
    ),
    FrostedTile(
      tilename: 'Privacy Policy',
      tileicon: Icons.privacy_tip_outlined,
    ),
    FrostedTile(
      tilename: 'Visit Website',
      tileicon: Icons.web_outlined,
    ),
    FrostedTile(
      tilename: 'Logout',
      tileicon: Icons.person_off_outlined,
    ),
  ];

  Widget titleBar(String img, String name, double ht) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 15.0, bottom: 10.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(ht),
            child: FadeInImage(
              placeholder: const AssetImage('assets/placeholder.jpg'),
              image: NetworkImage(img.isEmpty
                  ? 'https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'
                  : img),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ht / 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Pulzion \'23',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: ht / 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff1e2757), Color(0xff551560)],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: height / 40),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.white,
                  ),
                  Text(
                    'MORE...',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height / 25,
                        color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Expanded(
                    child: titleBar('', 'Your Name', height),
                  ),
                  Expanded(
                    flex: 4,
                    child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: fl.length,
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 2400),
                                  child: SlideAnimation(
                                    child: ScaleAnimation(
                                      curve: Curves.easeInOut,
                                      child: FadeInAnimation(
                                        child: FrostedGlassBox(
                                          cheight: height / 12.5,
                                          cwidth: double.infinity,
                                          childWid: fl[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                  ),
                ],
              ),
            ),
          ),
          if (isRocket)
            AnimatedOpacity(
              opacity: _op ? 1.0 : 0.0,
              duration: const Duration(
                milliseconds: 500,
              ),
              child: Rocket(
                setRocket: setRocket,
              ),
            )
        ],
      ),
    );
  }
}
