// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:pulzion22_app/constants/constants.dart';

// import 'package:pulzion22_app/widgets/timer.dart';

import '../../../../../constants/mcqconstants.dart';
// import '../../../../services/mcq_user_provider.dart';
import '../../question_overview/ui/question_overview.dart';
// import '../../models/question_overview.dart';
// import '../../services/mcq_user_provider.dart';
import '../../question_grid/ui/question_grid.dart';

// ignore: must_be_immutable
class SingleQuestion extends StatefulWidget {
  String id;
  int timer;
  final storage = FlutterSecureStorage();

  SingleQuestion({Key? key, required this.id, required this.timer})
      : super(key: key);

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestion> {
  bool _isQuestionsLoading = true;
  bool _isBookmarked = false;

  // ignore: non_constant_identifier_names
  List<CustomQuestionOverview> questions_overview = [];
  List<dynamic> questions = [];
  final Color markedColour = Colors.red;

  late Duration duration;

  Future _markAnswer(int ans, String questionID, int questionIndex) async {
    final McqToken = await widget.storage.read(key: 'mcqtoken');
    try {
      final url = Uri.parse(Constants.MARK_ANSWER_URL);
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $McqToken',
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'answer': ans,
          'id': questionID,
        }),
      );
      if (response.statusCode == 200) {
        //! update the answer in the question
        setState(() {
          questions[questionIndex]['answer'] = ans;
          questions_overview[questionIndex].ans = ans;
        });
        Fluttertoast.showToast(
          msg: 'Answer marked successfully',
          backgroundColor: Colors.blue.shade600,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Could not mark your answer',
          backgroundColor: Colors.blue.shade600,
        );
      }
      // print("Answer Api : " + response.statusCode.toString());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.blue.shade600,
      );
    }
  }

  Future _toggleBookMark(int questionIndex) async {
    final McqToken = await widget.storage.read(key: 'mcqtoken');
    try {
      // final mcqUser = Provider.of<MCQUserProvider>(context, listen: false);
      final url = Uri.parse(Constants.MARK_ANSWER_URL);
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $McqToken',
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'review_status': !questions[questionIndex]['review_status'],
          'id': questions[questionIndex]['id'],
        }),
      );
      if (response.statusCode == 200) {
        // print("Bookmark Api : " + response.statusCode.toString());
        setState(() {
          _isBookmarked = !_isBookmarked;
          questions[questionIndex]['review_status'] =
              !questions[questionIndex]['review_status'];
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to mark',
          backgroundColor: Colors.blue.shade600,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.blue.shade600,
      );
    }
  }

  Future _getQuestion() async {
    try {
      //! get all questions from the server
      // final mcqUser = Provider.of<MCQUserProvider>(context, listen: false);
      final url = Uri.parse(Constants.GET_MCQS_URL + widget.id);
      final McqToken = await widget.storage.read(key: 'mcqtoken');
      final response = await http.get(url, headers: {
        'Authorization': 'Token $McqToken',
      });
      log(response.body.toString());
      if (response.statusCode == 200) {
        questions = jsonDecode(response.body);
        log('Question = $questions');
        // print(questions);
        setState(() {
          _isQuestionsLoading = false;
          questions_overview = List<CustomQuestionOverview>.generate(
            questions.length,
            (index) => CustomQuestionOverview(
              ans: questions[index]['answer'] ?? -1,
              question_no: index,
              pgController: pgController,
              // isBookmarked: _isBookmarked,
              queList: questions,
            ),
          );
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Please try again',
          backgroundColor: Colors.blue.shade600,
        );
      }
      // print(response.body);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.blue.shade600,
      );
    }
  }

  @override
  void initState() {
    _getQuestion();
    startTimer();
    super.initState();
    duration = Duration(
      minutes: 0,
      seconds: widget.timer,
    );
    // duration = Duration(hours: 0, minutes: 0, seconds: 15);
  }

  @override
  void dispose() {
    pgController.dispose();
    super.dispose();
  }

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

  Future _autoSubmitQuiz() async {
    final McqToken = await widget.storage.read(key: 'mcqtoken');
    final McqId = widget.storage.read(key: 'mcqId').toString();
    // var mcqUser = Provider.of<MCQUserProvider>(context, listen: false);

    Map<String, String> headers = {
      'Authorization': 'Token $McqToken',
    };
    try {
      final url = Uri.parse(Constants.SUBMIT_MCQ + McqId);
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Submit Successful",
          backgroundColor: Colors.blue.shade600,
        );
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? 'There is some problem currently';
        throw error;
      }
    } catch (error) {
      log("some error occurred....");
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.blue.shade600,
      );
    }

    Future.delayed(Duration.zero, () {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: _onWillPopSubmit,
            child: AlertDialog(
              backgroundColor: const Color(0xff01020a),
              title: const Text('Logout'),
              content: Text(
                'Time Over!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    child: const Text(
                      'OK',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    onPressed: () {
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  //!this
  String twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  //! handle time sync in cubit itself
  Text buildTime() {
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours.remainder(24));
    if (minutes == '00' && seconds == '00' && hours == '00') {
      //TODO
      Future.delayed(
        Duration.zero,
        (() => {
              setState(
                () {
                  _isOver = true;
                  _autoSubmitQuiz();
                  _isFinallyOver = true;
                  timer!.cancel();
                },
              ),
            }),
      );
    }

    return Text(
      '$hours:$minutes:$seconds', //TODO
      style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.025),
    );
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

  PageController pgController = PageController();

  @override
  Widget build(BuildContext context) {
    log("rebuilding ");
    var totalQue = questions.length;

    return Scaffold(
      backgroundColor: Color(0xffe0e0e6),
      appBar: AppBar(
        backgroundColor: Color(0xff1b3357),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    var obj = QuestionGrid(
                      question_overview: questions_overview,
                    );

                    return obj;
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
          ),
        ],
      ),
      body: _isQuestionsLoading
          ? Center(child: CircularProgressIndicator())
          : WillPopScope(
              onWillPop: _onWillPop,
              //! pageview builder will create a separate page for each question (like listview builder and gridview builder)
              child: PageView.builder(
                itemBuilder: (context, index) {
                  _isBookmarked = questions[index]['review_status'];
                  log(questions[index].toString());

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
                                      top: MediaQuery.of(context).size.height *
                                          0.06,
                                    ),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            if (index > 0) {
                                              index -= 1;
                                              pgController.animateToPage(
                                                index,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeIn,
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'This is the first question',
                                                backgroundColor: Colors.blue,
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.arrow_back_ios),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isBookmarked = questions[index]
                                                  ['review_status'];
                                            });
                                            _toggleBookMark(index);
                                          },
                                          icon: _isBookmarked
                                              ? Icon(Icons.bookmark_add)
                                              : Icon(
                                                  Icons.bookmark_add_outlined,
                                                ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
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
                                          totalQue.toString(),
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (index < totalQue - 1) {
                                              index += 1;
                                              pgController.animateToPage(
                                                index,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeIn,
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'This is the last question',
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
                                          title: Text(questions[index]
                                              ['fk_question']['statement']),
                                          content: questions[index]
                                                              ['fk_question']
                                                          ['image_url'] !=
                                                      null &&
                                                  questions[index]
                                                              ['fk_question']
                                                          ['image_url'] !=
                                                      ''
                                              ? FadeInImage(
                                                  placeholder: AssetImage(
                                                    'assets/images/loading.jpeg',
                                                  ),
                                                  image: NetworkImage(
                                                    questions[index]
                                                            ['fk_question']
                                                        ['image_url'],
                                                  ),
                                                )
                                              : Text('No image'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            //actual Question

                                            //! to show only 40 char on main screen
                                            "${questions[index]['fk_question']['statement'].toString().substring(
                                                  0,
                                                  questions[index]['fk_question']
                                                                  ['statement']
                                                              .toString()
                                                              .length >
                                                          40
                                                      ? 40
                                                      : questions[index][
                                                                  'fk_question']
                                                              ['statement']
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
                                            'Click to view full question and image',
                                            style: TextStyle(
                                              fontSize: 18,
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

                          //! timer on top of question
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                              ),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  value: 1,
                                  strokeWidth: 15,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            child: Container(
                              //Timer
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.11,
                              ),
                              child: _isFinallyOver
                                  ? Text(
                                      '00:00',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                    )
                                  : buildTime(),
                            ),
                          ),

                          //! 4 options of question
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
                                //Options
                                //! instead of using 4 diff widgets create a custom widget
                                //!and call it 4 times in loop and pass necessary parameters

                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextButton(
                                      onPressed: () {
                                        _markAnswer(
                                          0,
                                          questions[index]['id'],
                                          index,
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Text(
                                        questions[index]['fk_question']
                                            ['options'][0],
                                        style: TextStyle(
                                          color: (questions[index]['answer'] !=
                                                      null &&
                                                  questions[index]['answer'] ==
                                                      0)
                                              ? markedColour
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextButton(
                                      onPressed: () {
                                        _markAnswer(
                                            1, questions[index]['id'], index);
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Text(
                                        questions[index]['fk_question']
                                            ['options'][1],
                                        style: TextStyle(
                                          color: (questions[index]['answer'] !=
                                                      null &&
                                                  questions[index]['answer'] ==
                                                      1)
                                              ? markedColour
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextButton(
                                      onPressed: () {
                                        _markAnswer(
                                            2, questions[index]['id'], index);
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Text(
                                        questions[index]['fk_question']
                                            ['options'][2],
                                        style: TextStyle(
                                          color: (questions[index]['answer'] !=
                                                      null &&
                                                  questions[index]['answer'] ==
                                                      2)
                                              ? markedColour
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextButton(
                                      onPressed: () {
                                        _markAnswer(
                                            3, questions[index]['id'], index);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        questions[index]['fk_question']
                                            ['options'][3],
                                        style: TextStyle(
                                          color: (questions[index]['answer'] !=
                                                      null &&
                                                  questions[index]['answer'] ==
                                                      3)
                                              ? markedColour
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
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
                controller: pgController,
                itemCount: questions.length,
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
              ),
            ),
    );
  }
}
