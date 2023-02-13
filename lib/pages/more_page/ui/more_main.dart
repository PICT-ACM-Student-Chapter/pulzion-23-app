import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pulzion23/constants/images.dart';
import 'frostedglass.dart';
import 'childWid.dart';
import 'rocket.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';

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

  List<List<FrostedTile>> f = [
    [
      FrostedTile(
        tilename: 'Login',
        tileicon: Icons.person_outlined,
      ),
      FrostedTile(
        tilename: 'Sign Up',
        tileicon: Icons.login,
      ),
      FrostedTile(
        tilename: 'Logout',
        tileicon: Icons.person_off_outlined,
      ),
    ],
    [
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
    ],
    [
      FrostedTile(
        tilename: 'Privacy Policy',
        tileicon: Icons.privacy_tip_outlined,
      ),
      FrostedTile(
        tilename: 'Visit Website',
        tileicon: Icons.web_outlined,
      ),
    ],
  ];

  Widget titleBar(String img, String name, double ht) {
    return Padding(
      padding: EdgeInsets.all(ht / 100),
      child: Card(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.transparent,
        child: Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ht / 25),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.23),
                    Colors.white.withOpacity(0.05),
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: ht / 30, left: ht / 50, right: ht / 100, bottom: ht / 50),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ht),
                  child: FadeInImage(
                    placeholder: const AssetImage(AppImages.icon),
                    image: NetworkImage(img.isEmpty
                        ? 'https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'
                        : img),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Pulzion \'23',
                      style: TextStyle(
                          fontSize: ht / 50,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white54,
                          overflow: TextOverflow.ellipsis,
                          fontSize: ht / 50,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

    return Stack(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: height / 40),
            child: Column(
              children: [
                Expanded(
                  child: titleBar('', 'Your Name', height),
                ),
                Container(
                  margin: EdgeInsets.all(height / 55),
                  padding: EdgeInsets.all(height / 120),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.white.withOpacity(0.15),
                        ],
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(left: height / 90, right: height / 90),
                    child: Container(
                      height: height / 11,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(FontAwesomeIcons.instagram),
                            color: Colors.white,
                            iconSize: height / 22,
                          ),
                          const VerticalDivider(
                            color: Colors.white54,
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: height / 22,
                            icon: const FaIcon(FontAwesomeIcons.linkedin),
                          ),
                          const VerticalDivider(
                            color: Colors.white54,
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: height / 22,
                            icon: const FaIcon(FontAwesomeIcons.facebook),
                          ),
                          const VerticalDivider(
                            color: Colors.white54,
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: height / 22,
                            icon: const FaIcon(FontAwesomeIcons.twitter),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: height / 60,
                    right: height / 60,
                    top: height / 60,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(height / 60),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.black.withOpacity(0.05),
                          ],
                        )),
                    height: 60,
                    child: Container(
                      margin: EdgeInsets.all(height / 150),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Rate us on Play Store',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height / 55,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.googlePlay,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.red,
                    margin: EdgeInsets.only(top: height / 70),
                    padding: EdgeInsets.only(left: height / 80, right: height / 80),
                    child: AnimationLimiter(
                        child: ListView.builder(
                            itemCount: f.length,
                            itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 2400),
                                  child: SlideAnimation(
                                    child: ScaleAnimation(
                                      curve: Curves.easeInOut,
                                      child: FadeInAnimation(
                                        child: FrostedGlassBox(
                                          cheight: height / 12.5,
                                          cwidth: MediaQuery.of(context).size.width,
                                          childWid: f[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                  ),
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
    );
  }
}
