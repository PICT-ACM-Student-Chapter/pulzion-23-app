import 'package:flutter/material.dart';
import '../logic/event.dart';
import 'event_card.dart';

class StackedCards extends StatefulWidget {
  final List<Event> events;
  const StackedCards(this.events, {super.key});

  @override
  State<StackedCards> createState() => _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards>
    with TickerProviderStateMixin {
  int animationTime = 400;
  late List<Event> eventList;
  bool autoScroll = true;
  late final AnimationController _opacityController = AnimationController(
      vsync: this, duration: Duration(milliseconds: animationTime));
  late final Animation<double> _opacityAnimation = Tween(
    begin: 1.0,
    end: 0.0,
  ).animate(_opacityController);

  late final AnimationController _controllerUp = AnimationController(
    duration: Duration(milliseconds: animationTime),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimationUp = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.3),
  ).animate(
    CurvedAnimation(
      parent: _controllerUp,
      curve: Curves.easeOutBack,
    ),
  );

  late final AnimationController _controllerDown = AnimationController(
    duration: Duration(milliseconds: animationTime),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimationDown = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 0.3),
  ).animate(
    CurvedAnimation(
      parent: _controllerDown,
      curve: Curves.easeOutBack,
    ),
  );

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _controllerDown.dispose();
    _controllerUp.dispose();
    super.dispose();
  }

  void startAutoScroll() async {
    while (autoScroll) {
      await Future.delayed(Duration(milliseconds: animationTime * 10));
      if (autoScroll) {
        swipeUpEvent();
      }
    }
  }

  void swipeUpEvent() async {
    try {
      _controllerUp.forward();
      _opacityController.forward();
      await Future.delayed(Duration(milliseconds: animationTime));
      setState(() {
        Event temp = eventList.last;
        eventList.removeLast();
        eventList.insert(0, temp);
    _controllerUp.reset();
    _opacityController.reset();
      });
    } catch (e) {}
  }

  void swipeDownEvent() async {
    try {
      _controllerDown.forward();
      _opacityController.forward();
      await Future.delayed(Duration(milliseconds: animationTime));
      setState(() {
        Event temp = eventList[0];
        eventList.removeAt(0);
        eventList.add(temp);
    _controllerDown.reset();
    _opacityController.reset();
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    eventList = widget.events;
    buildMockList(BuildContext context) {
      var list = <Widget>[];

      list = List.generate(
        eventList.length,
        (index) => index == eventList.length - 1
            ? Positioned(
                top: 6.0 * (eventList.length - index),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _offsetAnimationDown,
                    child: SlideTransition(
                      position: _offsetAnimationUp,
                      child: EventCard(
                        eventList[index],
                        eventList.length,
                        eventList.length - index,
                      ),
                    ),
                  ),
                ),
              )
            : Positioned(
                top: 6.0 * (eventList.length - index),
                child: EventCard(
                  eventList[index],
                  eventList.length,
                  eventList.length - index,
                ),
              ),
      );
      return list;
    }

    final cardList = buildMockList(context);

    return GestureDetector(
      onVerticalDragEnd: (details) {
        autoScroll = false;
        if (details.primaryVelocity! > 0.0) {
          swipeDownEvent();
        } else if (details.primaryVelocity! < 0) {
          swipeUpEvent();
        }
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: cardList,
      ),
    );
  }
}
