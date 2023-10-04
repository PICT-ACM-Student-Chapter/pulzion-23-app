import 'package:flutter/material.dart';
import '../../../../constants/widgets/halloween_button.dart';
import 'combo_card.dart';

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subtitle;
  final Image image;

  const AnimatedPrompt({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageScalingAnimation;
  late Animation<double> _containerScalingAnimation;
  // late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // _yAnimation = Tween(begin: const Offset(0, 0), end: const Offset(0, -0.23))
    //     .animate(CurvedAnimation(
    //         parent: _animationController, curve: Curves.easeOut));

    _containerScalingAnimation = Tween(begin: 1.5, end: 0.75).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));

    _imageScalingAnimation = Tween(begin: 1.5, end: 0.75).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    final widgWidth = MediaQuery.of(context).size.width;
    // final widgHeight = MediaQuery.of(context).size.height;
    _animationController
      ..reset()
      ..forward();

    return Container(
      // width: widgWidth,
      height: 148,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/event_frame.png"),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: widgWidth / 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: widgWidth * 0.08,
              ),
              ScaleTransition(
                scale: _containerScalingAnimation,
                child: Container(
                  height: widgWidth * 0.2,
                  width: widgWidth * 0.2,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 78, 48, 21)),
                  child: ScaleTransition(
                    scale: _imageScalingAnimation,
                    child: widget.image,
                  ),
                ),
              ),
              SizedBox(
                width: widgWidth * 0.05,
              ),
              SizedBox(
                width: widgWidth * 0.55,
                height: widgWidth * 0.07,
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: widgWidth * 0.08,
                child: Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widgWidth / 8.4,
              ),
              SizedBox(
                // color: Colors.amber,
                height: widgWidth / 8,
                width: widgWidth / 2.8,
                child: HalloweenButton(
                  fontsize: 5,
                  color: const Color.fromARGB(255, 108, 56, 1),
                  buttonText: "Combo",
                  icon: Icons.local_offer_sharp,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: SingleChildScrollView(
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              backgroundColor: const Color.fromARGB(143, 90, 54, 5),
                              content: Container(
                                height: widgWidth,
                                width: widgWidth /
                                    10, // Adjust the height as needed
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            height: widgWidth / 12,
                                            width: widgWidth / 2.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: const Color.fromARGB(
                                                  255, 234, 195, 94),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Combo Offers',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 33, 17, 10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(Icons.close)),
                                        ),
                                      ],
                                    ),
                                    Combo_List(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: widgWidth / 30,
              ),
              SizedBox(
                height: widgWidth / 8,
                width: widgWidth / 2.8,
                child: HalloweenButton(
                    color: const Color.fromARGB(255, 108, 56, 1),
                    icon: Icons.delete,
                    buttonText: "Delete",
                    onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
