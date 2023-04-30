// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomQuestionOverview extends StatefulWidget {
  int question_no;
  PageController pgController;
  final List queList;

  CustomQuestionOverview({
    Key? key,
    required this.question_no,
    required this.pgController,
    // required this.isBookmarked,
    required this.queList,
  }) : super(key: key);

  @override
  State<CustomQuestionOverview> createState() => _CustomQuestionOverviewState();
}

class _CustomQuestionOverviewState extends State<CustomQuestionOverview> {
  late bool isBookmarked = widget.queList[widget.question_no]['review_status'];
  Color color = Colors.white;
  Color bookmarkColor = Color.fromARGB(255, 208, 126, 255);
  bool isAnswered = false;
  bool isVisited = false;

  int get getIndex {
    return widget.question_no;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.pgController.animateToPage(widget.question_no,
                  duration: Duration(milliseconds: 300), curve: Curves.easeIn);
            },
            child: Container(
              color: isBookmarked ? bookmarkColor : Colors.white,
              child: Text(
                (widget.question_no + 1).toString(),
                style: TextStyle(color: Colors.black),
              ),
            )),
      ),
      color: isBookmarked ? bookmarkColor : color,
    );
  }
}
