import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/error_dialog.dart';
import 'package:pulzion23/constants/widgets/loader.dart';
import 'package:pulzion23/features/mcq/features/event_list/logic/cubit/mcq_event_list_cubit.dart';
import 'package:pulzion23/features/mcq/features/question_page/logic/cubit/question_page_cubit.dart';
import 'package:pulzion23/features/mcq/features/question_page/ui/questionPageBuilder.dart';

class RulePage extends StatefulWidget {
  final String id;
  final storage = FlutterSecureStorage();

  RulePage({Key? key, required this.id}) : super(key: key);

  @override
  State<RulePage> createState() => _RulePageState();
}

extension StringExtension on String {
  String capitalize() {
    final words = split(' ');
    final capitalized = words.map((word) {
      final firstLetter = word.substring(0, 1).toUpperCase();
      final remainingLetters = word.substring(1);

      return '$firstLetter$remainingLetters';
    });

    return capitalized.join(' ');
  }
}

class _RulePageState extends State<RulePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocConsumer<EventListCubit, EventListState>(
        builder: (context, state) {
          if (state is EventPageLoading) {
            return const Center(
              child: Loader(),
            );
          } else if (state is EventPageError) {
            return Center(child: ErrorDialog(state.message.capitalize()));
          } else if (state is SingleEventStatus) {
            return RuleBox(
              id: widget.id,
              isFinished: state.mcqStatus.finished as bool,
              endTime:
                  DateTime.parse(state.mcqStatus.fkEvent!.endTime as String),
            );
          } else {
            return Container();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}

class RuleBox extends StatelessWidget {
  final bool isFinished;
  final String id;
  final DateTime endTime;

  const RuleBox({
    Key? key,
    required this.id,
    required this.isFinished,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log(DateTime.parse(McqStatus.fkEvent!.endTime as String).toString());

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.black54,
            Color.fromARGB(255, 5, 41, 59),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            "Rules",
            style: AppStyles.TitleText()
                .copyWith(fontSize: 60, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "1. You cannot change apps after you begin with the quiz!",
                    style: AppStyles.NormalText()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "2. Do not switch apps during the test, or you will be disqualified! , and the test will get autosubmitted!",
                    style: AppStyles.NormalText()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "3. The duration of the quiz is for x mins and there are x questions! that are to be completed within the time limit! , if you fail to complete the quiz within the time limit , the test will record the responses submitted during the quiz and will be submitted automatically!",
                    style: AppStyles.NormalText()
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: Colors.white,
                      width: 0.5,
                    ),
                  ),
                  onPressed: () {
                    if (isFinished) {
                      Fluttertoast.showToast(
                        msg: "Sorry the event has ended!",
                        backgroundColor: Colors.blue.shade600,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Quiz begins!",
                        backgroundColor: Colors.blue.shade600,
                      );
                      log('Time left${endTime.difference(DateTime.now()).inSeconds}');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                QuestionPageCubit()..loadQuestions(id),
                            child: SingleQuestion(
                              id: id,
                              timer:
                                  endTime.difference(DateTime.now()).inSeconds,
                              questionPageCubit: QuestionPageCubit(),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Continue',
                    style: AppStyles.NormalText().copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
