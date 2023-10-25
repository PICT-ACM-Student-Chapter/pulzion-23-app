// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/features/mcq/features/question_page/logic/cubit/question_page_cubit.dart';
import 'package:pulzion23/features/mcq/models/mcq_questions_model.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// import 'package:provider/provider.dart';
// import 'package:pulzion22_app/constants/constants.dart';

// import 'package:pulzion22_app/widgets/timer.dart';

import '../../../../../constants/mcqconstants.dart';
// import '../../../../services/mcq_user_provider.dart';
import 'question_overview.dart';
// import '../../models/question_overview.dart';
// import '../../services/mcq_user_provider.dart';
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
  late Duration duration;

// //!
//   Future _markAnswer(int ans, String questionID, int questionIndex) async {
//     final McqToken = await widget.storage.read(key: 'mcqtoken');
//     try {
//       final url = Uri.parse(Constants.MARK_ANSWER_URL);
//       final response = await http.patch(
//         url,
//         headers: {
//           'Authorization': 'Token $McqToken',
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           'answer': ans,
//           'id': questionID,
//         }),
//       );
//       if (response.statusCode == 200) {
//         //! update the answer in the question
//         setState(() {
//           questions[questionIndex]['answer'] = ans;
//           questions_overview[questionIndex].ans = ans;
//         });
//         Fluttertoast.showToast(
//           msg: 'Answer marked successfully',
//           backgroundColor: Colors.blue.shade600,
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Could not mark your answer',
//           backgroundColor: Colors.blue.shade600,
//         );
//       }
//       // print("Answer Api : " + response.statusCode.toString());
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: 'Something went wrong',
//         backgroundColor: Colors.blue.shade600,
//       );
//     }
//   }

// //!
//   Future _toggleBookMark(int questionIndex) async {
//     final McqToken = await widget.storage.read(key: 'mcqtoken');
//     try {
//       // final mcqUser = Provider.of<MCQUserProvider>(context, listen: false);
//       final url = Uri.parse(Constants.MARK_ANSWER_URL);
//       final response = await http.patch(
//         url,
//         headers: {
//           'Authorization': 'Token $McqToken',
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           'review_status': !questions[questionIndex]['review_status'],
//           'id': questions[questionIndex]['id'],
//         }),
//       );
//       if (response.statusCode == 200) {
//         // print("Bookmark Api : " + response.statusCode.toString());
//         setState(() {
//           _isBookmarked = !_isBookmarked;
//           questions[questionIndex]['review_status'] =
//               !questions[questionIndex]['review_status'];
//         });
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Failed to mark',
//           backgroundColor: Colors.blue.shade600,
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: 'Something went wrong',
//         backgroundColor: Colors.blue.shade600,
//       );
//     }
//   }

// //!
//   Future _getQuestion() async {
//     try {
//       //! get all questions from the server
//       // final mcqUser = Provider.of<MCQUserProvider>(context, listen: false);
//       final url = Uri.parse(Constants.GET_MCQS_URL + widget.id);
//       final McqToken = await widget.storage.read(key: 'mcqtoken');
//       final response = await http.get(url, headers: {
//         'Authorization': 'Token $McqToken',
//       });
//       log(response.body.toString());
//       if (response.statusCode == 200) {
//         questions = jsonDecode(response.body);
//         log('Question = $questions');
//         // print(questions);
//         setState(() {
//           _isQuestionsLoading = false;
//           questions_overview = List<CustomQuestionOverview>.generate(
//             questions.length,
//             (index) => CustomQuestionOverview(
//               ans: questions[index]['answer'] ?? -1,
//               question_no: index,
//               pgController: pgController,
//               // isBookmarked: _isBookmarked,
//               queList: questions,
//             ),
//           );
//         });
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Please try again',
//           backgroundColor: Colors.blue.shade600,
//         );
//       }
//       // print(response.body);
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: 'Something went wrong',
//         backgroundColor: Colors.blue.shade600,
//       );
//     }
//   }

  // @override
  // void initState() {
  //   _getQuestion();
  //   startTimer();
  //   super.initState();
  //   duration = Duration(
  //     minutes: 0,
  //     seconds: widget.timer,
  //   );
  //   // duration = Duration(hours: 0, minutes: 0, seconds: 15);
  // }

  // @override
  // void dispose() {
  //   pgController.dispose();
  //   if (timer != null) {
  //     timer!.cancel();
  //   }
  //   super.dispose();
  // }

  // Future _autoSubmitQuiz() async {
  //   final McqToken = await widget.storage.read(key: 'mcqtoken');
  //   final McqId = widget.storage.read(key: 'mcqId').toString();
  //   // var mcqUser = Provider.of<MCQUserProvider>(context, listen: false);

  //   Map<String, String> headers = {
  //     'Authorization': 'Token $McqToken',
  //   };
  //   try {
  //     final url = Uri.parse(Constants.SUBMIT_MCQ + McqId);
  //     final response = await http.get(
  //       url,
  //       headers: headers,
  //     );
  //     if (response.statusCode == 200) {
  //       Fluttertoast.showToast(
  //         msg: "Submit Successful",
  //         backgroundColor: Colors.blue.shade600,
  //       );
  //     } else {
  //       var result = jsonDecode(response.body);
  //       var error = result['error'] ?? 'There is some problem currently';
  //       throw error;
  //     }
  //   } catch (error) {
  //     log("some error occurred....");
  //     Fluttertoast.showToast(
  //       msg: error.toString(),
  //       backgroundColor: Colors.blue.shade600,
  //     );
  //   }

  //   Future.delayed(Duration.zero, () {
  //     return showDialog<void>(
  //       context: context,
  //       barrierDismissible: false, // user must tap button!
  //       builder: (BuildContext context) {
  //         return WillPopScope(
  //           onWillPop: _onWillPopSubmit,
  //           child: AlertDialog(
  //             backgroundColor: const Color(0xff01020a),
  //             title: const Text('Logout'),
  //             content: Text(
  //               'Time Over!',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontFamily: 'Montserrat',
  //                 color: Colors.white,
  //               ),
  //             ),
  //             actions: <Widget>[
  //               Center(
  //                 child: ElevatedButton(
  //                   child: const Text(
  //                     'OK',
  //                     textAlign: TextAlign.right,
  //                     style: TextStyle(
  //                       fontSize: 17.0,
  //                       fontFamily: 'Montserrat',
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     while (Navigator.canPop(context)) {
  //                       Navigator.pop(context);
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  // //!this
  // String twoDigits(int n) {
  //   return n.toString().padLeft(2, '0');
  // }

  // //! handle time sync in cubit itself
  // Text buildTime() {
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   final hours = twoDigits(duration.inHours.remainder(24));
  //   if (minutes == '00' && seconds == '00' && hours == '00') {
  //     //TODO
  //     Future.delayed(
  //       Duration.zero,
  //       (() => {
  //             setState(
  //               () {
  //                 _isOver = true;
  //                 _autoSubmitQuiz();
  //                 _isFinallyOver = true;
  //                 timer!.cancel();
  //               },
  //             ),
  //           }),
  //     );
  //   }

  //   return Text(
  //     '$hours:$minutes:$seconds', //TODO
  //     style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.025),
  //   );
  // }

  bool _isOver = false; // used to keep track of timer

  Timer? timer;
  bool _isFinallyOver = false; // used to check is quiz is over

  // int seconds = 0;
  //! try to find automatic widget to simulate this timer mechanism
  void addTimer() {
    //! this is done to show that the timer is ticking....reducing by 1 per sec
    const addSeconds = -1;
    if (!_isOver) {
      setState(() {
        int seconds = duration.inSeconds + addSeconds;
        duration = Duration(seconds: seconds);
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      addTimer();
    });
  }

  Future<bool> _onWillPop() async {
    Fluttertoast.showToast(
      msg: "Please submit the quiz to go back!",
      backgroundColor: Colors.blue.shade600,
    );

    return false;
  }

  Future<bool> _onWillPopSubmit() async {
    Fluttertoast.showToast(
      msg: "Press Ok!",
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

                      Navigator.of(context).pop();
                      Navigator.of(parContext).pop();

                      // while (Navigator.of(context).canPop()) {
                      // Navigator.of(context).pop();
                      // }

                      // while (Navigator.of(widget.parentContext).canPop()) {
                      // Navigator.of(parentContext).pop();
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

  PageController pgController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe0e0e6),
      appBar: AppBar(
        actions: [
          BlocBuilder<QuestionPageCubit, QuestionPageState>(
            builder: (context, state) {
              return state is QuestionPageLoadedSuccessState
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: () {
                          _submitQuiz(context);
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff1b3357),
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          ),
          Spacer(),
          BlocBuilder<QuestionPageCubit, QuestionPageState>(
            builder: (context, state) {
              return state is QuestionPageLoadedSuccessState
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Material(
                                color: Colors.transparent,
                                child: Container(
                                  color: Colors.transparent.withOpacity(0.7),
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 20,
                                          ),
                                          child: GridView(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 20,
                                            ),
                                            children: state.questions.questions
                                                .map((e) {
                                              bool isAnswered = e.answer == null
                                                  ? false
                                                  : e.answer != -1
                                                      ? true
                                                      : false;
                                              bool isVisited = false;
                                              bool isBookmarked =
                                                  e.reviewStatus ?? false;

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  pgController.animateToPage(
                                                    state.questions.questions
                                                        .indexOf(e),
                                                    duration: Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    curve: Curves.easeIn,
                                                  );
                                                },
                                                child: Card(
                                                  color: !isAnswered &&
                                                          !isBookmarked
                                                      ? Colors.grey
                                                      : isAnswered &&
                                                              !isBookmarked
                                                          ? Colors.green
                                                          : isBookmarked
                                                              ? Colors.yellow
                                                              : Colors.white,
                                                  child: Center(
                                                    child: Text(
                                                      '${state.questions.questions.indexOf(e) + 1}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              // return QuestionGrid(
                              //   question_overview: state.questions.questions
                              //       .map(
                              //         (e) => CustomQuestionOverview(
                              //           ans: e.answer ?? -1,
                              //           question_no: state.questions.questions
                              //               .indexOf(e),
                              //           pgController: pgController,
                              //           queList: state.questions.questions,
                              //         ),
                              //       )
                              //       .toList(),
                              //   questionPageCubit: widget.questionPageCubit,
                              //   parentContext: context,
                              // );

                              // return obj;
                            },
                          );
                        },
                        child: Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff1b3357),
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
              return Center(
                child: CircularProgressIndicator(),
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
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.3,
                            ringColor: Colors.blue,
                            fillColor: Colors.white,
                            backgroundColor: Colors.white,
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
              return Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  final List<Question> questions;
  final Function markAnswer;
  final Function toggleBookMark;
  final PageController pageController;
  final int timer;

  QuestionPage({
    Key? key,
    required this.questions,
    required this.markAnswer,
    required this.toggleBookMark,
    required this.pageController,
    required this.timer,
  }) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Color markedColour = Colors.red;

  void handleMarkAnswer(int option, String questionId, int index) async {
    bool marked = await widget.markAnswer(option, questionId);
    if (marked) {
      setState(() {
        widget.questions[index].answer = option;
      });
    }
  }

  void handleToggleBookmark(bool isBookmarked, int index) async {
    bool bookmarkToggle = await widget.toggleBookMark(
      widget.questions[index].id,
      !isBookmarked,
    );
    if (bookmarkToggle) {
      setState(() {
        widget.questions[index].reviewStatus = !isBookmarked;
      });
    }
  }

  Widget answerTile(int index, int option) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextButton(
        onPressed: () {
          handleMarkAnswer(option, widget.questions[index].id!, index);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        child: Text(
          widget.questions[index].fkQuestion?.options?[option] ?? '',
          style: TextStyle(
            color: (widget.questions[index].answer != null &&
                    widget.questions[index].answer == option)
                ? markedColour
                : Colors.blue,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        bool _isBookmarked = widget.questions[index].reviewStatus ?? false;

        return Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Color(0xff1b3357),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          MediaQuery.of(context).size.width * 0.3,
                        ),
                        bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.width * 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15,
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.06,
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  if (index > 0) {
                                    index -= 1;
                                    widget.pageController.animateToPage(
                                      index,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'This is the first question',
                                      backgroundColor: Colors.blue,
                                    );
                                  }
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              IconButton(
                                onPressed: () {
                                  handleToggleBookmark(_isBookmarked, index);
                                },
                                icon: _isBookmarked
                                    ? Icon(Icons.bookmark_add)
                                    : Icon(
                                        Icons.bookmark_add_outlined,
                                      ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                'Question ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),

                              //! shows number of q / total questions
                              Text(
                                //Question number
                                '${index + 1}/',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                //Total questions
                                widget.questions.length.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (index < widget.questions.length - 1) {
                                    index += 1;
                                    widget.pageController.animateToPage(
                                      index,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'This is the last question',
                                      backgroundColor: Colors.blue,
                                    );
                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        //! end of top row

                        //! on clicking question statement it shows further details
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(widget.questions[index].fkQuestion
                                        ?.statement ??
                                    ''),
                                content: widget.questions[index].fkQuestion
                                                ?.imageUrl !=
                                            null &&
                                        widget.questions[index].fkQuestion
                                                ?.imageUrl !=
                                            ''
                                    ? FadeInImage(
                                        placeholder: AssetImage(
                                          'assets/images/loading.jpeg',
                                        ),
                                        image: NetworkImage(
                                          widget.questions[index].fkQuestion!
                                              .imageUrl!,
                                        ),
                                      )
                                    : Text('No image'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  //actual Question

                                  //! to show only 40 char on main screen
                                  "${widget.questions[index].fkQuestion?.statement.toString().substring(
                                        0,
                                        widget.questions[index].fkQuestion!
                                                    .statement
                                                    .toString()
                                                    .length >
                                                40
                                            ? 40
                                            : widget.questions[index]
                                                .fkQuestion!.statement
                                                .toString()
                                                .length,
                                      )}...",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff73859d),
                                  ),
                                ),
                                Text(
                                  //actual Question
                                  '\nClick to view full question and image',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.48,
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        ),
                    child: Column(
                      children: [
                        answerTile(index, 0),
                        Spacer(),
                        answerTile(index, 1),
                        Spacer(),
                        answerTile(index, 2),
                        Spacer(),
                        answerTile(index, 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      onPageChanged: (x) {},
      controller: widget.pageController,
      itemCount: widget.questions.length,
      scrollDirection: Axis.horizontal,
      physics: ScrollPhysics(),
    );
  }
}
