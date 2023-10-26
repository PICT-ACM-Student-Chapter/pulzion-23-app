import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulzion23/constants/widgets/loader.dart';
import 'package:pulzion23/features/mcq/features/question_page/logic/cubit/question_page_cubit.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'questionPage.dart';
import 'question_grid.dart';

// ignore: must_be_immutable
class SingleQuestion extends StatefulWidget {
  String id;
  int timer;
  QuestionPageCubit questionPageCubit;

  SingleQuestion({
    Key? key,
    required this.id,
    required this.timer,
    required this.questionPageCubit,
  }) : super(key: key);

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestion> {
  Future<bool> _onWillPop() async {
    Fluttertoast.showToast(
      msg: "Please submit the quiz to go back!",
      backgroundColor: Colors.blue.shade600,
    );

    return false;
  }

  @override
  void dispose() {
    super.dispose();
    pgController.dispose();
  }

  Future<void> _submitQuiz(BuildContext parContext) async {
    return showDialog<void>(
      context: parContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to submit?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.lightBlue,
                    ),
                    textAlign: TextAlign.center,
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
                      color: Colors.lightBlue,
                    ),
                  ),
                  onPressed: () async {
                    final nv = Navigator.of(context);
                    final nvPar = Navigator.of(parContext);

                    if (await widget.questionPageCubit.submitQuiz()) {
                      Fluttertoast.showToast(
                        msg: "Quiz submitted successfully",
                        backgroundColor: Colors.blue.shade600,
                      );

                      nv.pop();
                      nvPar.pop();
                    } else {
                      nv.pop();
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

  PageController pgController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 7, 13).withOpacity(0.9),
        actions: [
          BlocBuilder<QuestionPageCubit, QuestionPageState>(
            builder: (context, state) {
              return state is QuestionPageLoadedSuccessState
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 9, 15),
                          side: BorderSide(
                            color: Colors.blueGrey.withOpacity(0.2),
                            width: 0.7,
                          ),
                        ),
                        onPressed: () {
                          _submitQuiz(context);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          ),
          const Spacer(),
          BlocBuilder<QuestionPageCubit, QuestionPageState>(
            builder: (context, state) {
              return state is QuestionPageLoadedSuccessState
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 9, 15),
                          side: BorderSide(
                            color: Colors.blueGrey.withOpacity(0.2),
                            width: 0.7,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return QuestionGrid(
                                questions: state.questions.questions,
                                pgController: pgController,
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: BlocConsumer<QuestionPageCubit, QuestionPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is QuestionPageLoadingState) {
              return const Center(
                child: Loader(),
              );
            } else if (state is QuestionPageLoadingErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else if (state is QuestionPageLoadedSuccessState) {
              return Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    QuestionPage(
                      questions: state.questions.questions,
                      markAnswer: context.read<QuestionPageCubit>().markAnswer,
                      toggleBookMark:
                          context.read<QuestionPageCubit>().toggleBookMark,
                      pageController: pgController,
                      timer: widget.timer,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Positioned(
                        top: 0,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0,
                          ),
                          child: CircularCountDownTimer(
                            duration: widget.timer,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                            backgroundColor:
                                const Color.fromARGB(255, 1, 30, 47),
                            ringColor: const Color.fromARGB(255, 52, 166, 219)
                                .withOpacity(0.7),
                            fillColor: Colors.white.withOpacity(0.8),
                            ringGradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.8),
                                Colors.lightBlue.withOpacity(0.6),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            strokeWidth: 15,
                            strokeCap: StrokeCap.round,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            isReverse: true,
                            onComplete: () {
                              //! auto-submit logic
                              log('test over');
                              widget.questionPageCubit.autoSubmitQuiz();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
