import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/cart_page/cubit/cart_page_cubit.dart';

class AnimatedPrompt extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final Image image;
  List<String>? comboEvents;

  AnimatedPrompt({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.comboEvents,
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
    _animationController
      ..reset()
      ..forward();

    return Container(
      height: widget.comboEvents == null
          ? 160
          : widget.comboEvents!.length * 50 + 160,
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
                width: widgWidth * 0.07,
              ),
              ScaleTransition(
                scale: _containerScalingAnimation,
                child: Container(
                  height: widgWidth * 0.2,
                  width: widgWidth * 0.2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 78, 48, 21),
                  ),
                  child: ScaleTransition(
                    scale: _imageScalingAnimation,
                    child: widget.image,
                  ),
                ),
              ),
              // SizedBox(
              //   width: widgWidth * 0.05,
              // ),
              SizedBox(
                width: widgWidth * 0.48,
                height: widgWidth * 0.07,
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                // width: widgWidth * 0.08,
                child: Text(
                  "₹${widget.subtitle}",
                  textAlign: TextAlign.center,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          if (widget.comboEvents != null)
            Padding(
              padding: EdgeInsets.only(left: widgWidth / 4),
              child: ListView(
                shrinkWrap: true,
                children: widget.comboEvents!
                    .map((e) => Text(
                          '-$e',
                          style: AppStyles.NormalText().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ))
                    .toList(),
              ),
            ),
          if (widget.comboEvents != null)
            SizedBox(
              height: widgWidth / 10,
            ),
          Row(
            children: [
              SizedBox(
                width: widgWidth / 4,
              ),
              SizedBox(
                width: widgWidth / 7,
              ),
              SizedBox(
                height: widgWidth / 9,
                width: widgWidth / 4,
                child: InkWell(
                  onTap: () async {
                    if (widget.comboEvents == null) {
                      await BlocProvider.of<CartPageCubit>(context)
                          .deleteItem(widget.id);
                    } else {
                      await BlocProvider.of<CartPageCubit>(context)
                          .deleteCombo(widget.id);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange[700]!.withOpacity(0.8),
                        width: 0.7,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 2.0,
                          color: Colors.yellow[900]!.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Delete",
                        style: AppStyles.NormalText().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
