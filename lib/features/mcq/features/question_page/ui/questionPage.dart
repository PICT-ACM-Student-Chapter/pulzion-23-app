import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/mcq_questions_model.dart';

class QuestionPage extends StatefulWidget {
  final List<Question> questions;
  final Function markAnswer;
  final Function toggleBookMark;
  final PageController pageController;
  final int timer;

  const QuestionPage({
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        bool isBookmarked = widget.questions[index].reviewStatus ?? false;

        return SingleChildScrollView(
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
                            Color.fromARGB(255, 3, 46, 82),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15,
                        bottom: MediaQuery.of(context).size.height * 0.15,
                      ),
                      height: (widget.questions[index].fkQuestion?.statement
                                  ?.length ??
                              0) +
                          MediaQuery.of(context).size.height * 0.25,
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
                          bottom: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.06,
                              ),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      if (index > 0) {
                                        index -= 1;
                                        widget.pageController.animateToPage(
                                          index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: 'This is the first question',
                                          backgroundColor: Colors.blue,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      handleToggleBookmark(isBookmarked, index);
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
                                    width: MediaQuery.of(context).size.width *
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
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (index < widget.questions.length - 1) {
                                        index += 1;
                                        widget.pageController.animateToPage(
                                          index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: 'This is the last question',
                                          backgroundColor: Colors.blue,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.lightBlue,
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

                                bool isCode = widget.questions[index].fkQuestion
                                            ?.code !=
                                        null &&
                                    widget.questions[index].fkQuestion?.code !=
                                        '';

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 0, 10, 19)
                                            .withOpacity(0.9),
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
                                      height: isImage && isCode
                                          ? MediaQuery.of(context).size.width
                                          : isImage || isCode
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7
                                              : 200,
                                      width: 200,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          isImage
                                              ? FadeInImage(
                                                  placeholder: const AssetImage(
                                                    'assets/images/loading.jpeg',
                                                  ),
                                                  image: NetworkImage(
                                                    widget.questions[index]
                                                        .fkQuestion!.imageUrl!,
                                                  ),
                                                )
                                              : const Text('No image'),
                                          isCode
                                              ? Text(
                                                  widget.questions[index]
                                                          .fkQuestion?.code ??
                                                      '',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                  ),
                                                )
                                              : const Text('No code'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
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
                                      "${widget.questions[index].fkQuestion?.statement.toString().substring(
                                            0,
                                            widget.questions[index].fkQuestion!
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
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4 +
                            (widget.questions[index].fkQuestion?.statement
                                        ?.length ??
                                    0) *
                                2,
                      ),
                      height: MediaQuery.of(context).size.height * 0.38,
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
