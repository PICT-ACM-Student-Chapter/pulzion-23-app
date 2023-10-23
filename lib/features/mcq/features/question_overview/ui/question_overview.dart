// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomQuestionOverview extends StatefulWidget {
  int question_no;
  PageController pgController;
  final List queList;
  int? ans;

  CustomQuestionOverview({
    Key? key,
    required this.question_no,
    required this.pgController,
    // required this.isBookmarked,
    required this.ans,
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
  void initState() {
    super.initState();
    if (widget.ans != -1) {
      isAnswered = true;
    }
    if (widget.queList[widget.question_no]['visited'] != null) {
      isVisited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isAnswered
          ? Colors.green
          : isBookmarked
              ? Colors.yellow
              : Colors.white,
      child: Center(
        child: TextButton(
          onPressed: () {
            //! on seeing in the grid, this will navigate to the question tapped upon
            Navigator.of(context).pop();
            widget.pgController.animateToPage(
              widget.question_no,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          child: Text(
            (widget.question_no + 1).toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
