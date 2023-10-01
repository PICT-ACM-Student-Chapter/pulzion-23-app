import 'package:flutter/material.dart';

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subtitle;
  final Image image;

  const AnimatedPrompt(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

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
        width: widgWidth,
        height: 100,
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("event_frame.png"), fit: BoxFit.fill),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: widgWidth * 0.03,
            ),
            ScaleTransition(
              scale: _containerScalingAnimation,
              child: Container(
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
              width: 100,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: widgWidth * 0.4,
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
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  size: 30.0,
                  color: Colors.black,
                )),
            SizedBox(
              width: widgWidth * 0.06,
            )
          ],
        ));
  }
}
