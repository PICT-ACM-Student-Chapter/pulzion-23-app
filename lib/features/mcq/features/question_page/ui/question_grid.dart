// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulzion23/features/mcq/features/event_list/ui/event_list.dart';
import 'package:pulzion23/features/mcq/features/question_page/logic/cubit/question_page_cubit.dart';
import 'package:pulzion23/features/mcq/features/question_page/ui/question_overview.dart';

class QuestionGrid extends StatefulWidget {
  List<CustomQuestionOverview> question_overview;
  QuestionPageCubit questionPageCubit;
  BuildContext parentContext;

  QuestionGrid({
    Key? key,
    required this.question_overview,
    required this.questionPageCubit,
    required this.parentContext,
  }) : super(key: key);

  @override
  _QuestionGridState createState() => _QuestionGridState();
}

class _QuestionGridState extends State<QuestionGrid> {
  late List<CustomQuestionOverview> question_overview;

  Future _submitQuiz() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff01020a),
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Are you sure you want to submit?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                TextButton(
                  child: const Text(
                    'Yes',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onPressed: () async {
                    if (await widget.questionPageCubit.submitQuiz()) {
                      Fluttertoast.showToast(
                        msg: "Quiz submitted successfully",
                        backgroundColor: Colors.blue.shade600,
                      );

                      while (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }

                      // while (Navigator.of(widget.parentContext).canPop()) {
                      Navigator.of(widget.parentContext).pop();
                      // }
                    } else {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Something went wrong",
                        backgroundColor: Colors.blue.shade600,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Dialog(
        backgroundColor: Color(0xff1b3357),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.41,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        _submitQuiz();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 228, 29, 95),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (2 / 100),
                    ),
                    //! gives error
                    // GridView(
                    //   shrinkWrap: true,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 5,
                    //     mainAxisSpacing: 20,
                    //     crossAxisSpacing: 20,
                    //   ),
                    //   children: widget.question_overview,
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
