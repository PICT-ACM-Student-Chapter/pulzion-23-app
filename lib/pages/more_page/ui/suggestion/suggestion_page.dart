import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../features/home_page/ui/wigets/event_card.dart';


class SuggestionPage extends StatefulWidget {
  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  String swipetext = "Swipe here -->";
  final List<EventCard> texts = [
    // "Codelicious",
    // "Hire Hustle",
    // "Codex",
    // "Dextrous",
    // "Insight",
    // "Fandom",
    // "Dataquest",
    // "Freeze the second",
    // "Web and App",
    // "Electroquest",
  ];

  bool isButtonDisabled = false;
  List<String> selectedTexts = [];
  bool isSwipingHintVisible = true;
  double swipeIndicatorPosition = 0.0;
  Timer? swipeTimer;

  void selectRandomTexts() {
    if (!isButtonDisabled) {
      final random = Random();
      final List<String> tempList = List.from(texts);

      tempList.shuffle();
      selectedTexts = tempList.sublist(0, random.nextInt(2) + 3);

      setState(() {});
      isButtonDisabled = true; // Disable the button after clicking
      // startSwipeIndicatorAnimation();
      stopSwipeIndicatorAnimation();
      swipetext = "";
    }
  }

  void startSwipeIndicatorAnimation() {
    if(isSwipingHintVisible != false)
      swipeTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          swipeIndicatorPosition += 5; // Adjust the speed as needed
          if (swipeIndicatorPosition >= 400) {
            swipeIndicatorPosition = 0;
          }
        });
      });
  }
  void stopSwipeIndicatorAnimation() {
    swipeTimer?.cancel();
  }
  @override

  void initState() {
    super.initState();
    startSwipeIndicatorAnimation();

  }
  @override
  void dispose() {
    swipeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    height: 400,
                    child: WebView(
                      initialUrl: 'https://app.vectary.com/p/5iw03uFSKS1OazHEbkCuS6',
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 200,
                    child: GestureDetector(
                      onVerticalDragEnd: (_) {
                        selectRandomTexts();
                        isSwipingHintVisible = true;
                      },
                      child: Container(
                        width: 150,
                        height: 25,
                        color: Colors.transparent,
                        // alignment: Alignment.center,
                        // child: Text(
                        //   'Swipe here',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     color: isSwipingHintVisible
                        //         ? Colors.blue
                        //         : Colors.transparent,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 165,
                    left: swipeIndicatorPosition,
                    child: Container(
                      width:200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                      child: Text(swipetext),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      color: Colors.transparent,
                      height: 150,
                      width: 400,
                    ),
                  ),
                  Positioned(
                    top: 190,
                    child: Container(
                      color: Colors.transparent,
                      height: 140,
                      width: 400,
                    ),
                  ),
                ],
              ),
              Text(
                'Swipe right to display random texts.',
                style: TextStyle(fontSize: 18),
              ),
              if (selectedTexts.isNotEmpty)
                Column(
                  children: selectedTexts
                      .map((text) => Text(
                    text,
                    style: TextStyle(fontSize: 24),
                  ))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}