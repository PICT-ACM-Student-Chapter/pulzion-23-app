import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/mcq_questions_model.dart';

class QuestionPage extends StatefulWidget with WidgetsBindingObserver {
  final List<Question> questions;
  final Function markAnswer;
  final Function toggleBookMark;
  final Function submitQuiz;
  final PageController pageController;
  final int timer;

  static late AppLifecycleState app;

  const QuestionPage({
    Key? key,
    required this.questions,
    required this.markAnswer,
    required this.toggleBookMark,
    required this.submitQuiz,
    required this.pageController,
    required this.timer,
  }) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    app = state;
  }
}

class _QuestionPageState extends State<QuestionPage> {
  Color markedColour = Colors.green;

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
    String optionText =
        widget.questions[index].fkQuestion?.options?[option] ?? '';

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height:
          optionText.length * 0.3 + MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 2.0,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          handleMarkAnswer(option, widget.questions[index].id!, index);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          optionText,
          style: TextStyle(
            color: (widget.questions[index].answer != null &&
                    widget.questions[index].answer == option)
                ? markedColour
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> checkTestStatus(BuildContext context) async {
    final sc = ScaffoldMessenger.of(context);
    final nv = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    int? val = prefs.getInt('qID');

    if (val == null) {
      return;
    }

    log("Val = $val");

    if (val == 0) {
      // do nothing
      return;
    } else if (val == 1) {
      // stop the quiz
      sc.showSnackBar(const SnackBar(
        content: Text(
          "You have left the app while the test was running. Doing so again will end the test.",
        ),
      ));
      await prefs.setInt('qID', 2);
    } else if (val == 3) {
      // stop the quiz
      widget.submitQuiz();
      sc.showSnackBar(const SnackBar(
        content: Text(
          "You have left the app while the test was running. Your test has been auto-submitted.",
        ),
      ));
      await prefs.setInt('qID', 0);
      nv.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        // checkTestStatus(context);
        bool isBookmarked = widget.questions[index].reviewStatus ?? false;

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Color.fromARGB(255, 2, 32, 57),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15,
                            bottom: MediaQuery.of(context).size.height * 0.05,
                          ),
                          width: MediaQuery.of(context).size.width * 0.85,
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
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.8),
                              width: 0.7,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.0,
                                spreadRadius: 2.0,
                                color: const Color.fromARGB(255, 52, 166, 219)
                                    .withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.07,
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
                                      const Spacer(),
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.2),
                                        child: IconButton(
                                          onPressed: () {
                                            if (index > 0) {
                                              index -= 1;
                                              widget.pageController
                                                  .animateToPage(
                                                index,
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
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
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          handleToggleBookmark(
                                            isBookmarked,
                                            index,
                                          );
                                        },
                                        icon: isBookmarked
                                            ? const Icon(
                                                Icons.bookmark_add,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.bookmark_add_outlined,
                                                color: Colors.white,
                                              ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      const Text(
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
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        //Total questions
                                        '/${widget.questions.length.toString()}',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.2),
                                        child: IconButton(
                                          onPressed: () {
                                            if (index <
                                                widget.questions.length - 1) {
                                              index += 1;
                                              widget.pageController
                                                  .animateToPage(
                                                index,
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
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
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bool isImage = widget.questions[index]
                                                .fkQuestion?.imageUrl !=
                                            null &&
                                        widget.questions[index].fkQuestion
                                                ?.imageUrl !=
                                            '';

                                    bool isCode = widget.questions[index]
                                                .fkQuestion?.code !=
                                            null &&
                                        widget.questions[index].fkQuestion
                                                ?.code !=
                                            '';

                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                            color: Colors.white,
                                            width: 0.7,
                                          ),
                                        ),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.95),
                                        title: Text(
                                          widget.questions[index].fkQuestion
                                                  ?.statement ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        content: SizedBox(
                                          width: 200,
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              if (isImage)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.lightBlue,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: FadeInImage(
                                                    placeholder:
                                                        const AssetImage(
                                                      'assets/images/loading.jpeg',
                                                    ),
                                                    image: NetworkImage(
                                                      widget
                                                          .questions[index]
                                                          .fkQuestion!
                                                          .imageUrl!,
                                                    ),
                                                  ),
                                                ),
                                              if (isCode)
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  child: Text(
                                                    widget.questions[index]
                                                            .fkQuestion?.code ??
                                                        '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Close'),
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
                                          "${widget.questions[index].fkQuestion?.statement.toString().substring(
                                                0,
                                                widget
                                                            .questions[index]
                                                            .fkQuestion!
                                                            .statement
                                                            .toString()
                                                            .length >
                                                        100
                                                    ? 100
                                                    : widget.questions[index]
                                                        .fkQuestion!.statement
                                                        .toString()
                                                        .length,
                                              )}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Text(
                                          //actual Question
                                          '\nClick to view full question, image and code (if any)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.lightBlue,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                answerTile(index, 0),
                                const SizedBox(
                                  height: 10,
                                ), // Adjust spacing as needed
                                answerTile(index, 1),
                                const SizedBox(
                                  height: 10,
                                ), // Adjust spacing as needed
                                answerTile(index, 2),
                                const SizedBox(
                                  height: 10,
                                ), // Adjust spacing as needed
                                answerTile(index, 3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onPageChanged: (x) {},
      controller: widget.pageController,
      itemCount: widget.questions.length,
      scrollDirection: Axis.horizontal,
      physics: const ScrollPhysics(),
    );
  }
}
