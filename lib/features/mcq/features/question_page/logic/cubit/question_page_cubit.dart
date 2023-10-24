import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/mcqconstants.dart';
import 'package:pulzion23/constants/urls.dart';
import 'package:pulzion23/features/mcq/features/question_overview/ui/question_overview.dart';
import 'package:pulzion23/features/mcq/features/question_page/ui/questionPageBuilder.dart';
import 'package:http/http.dart' as http;
part 'question_page_state.dart';
//import '';

class QuestionPageCubit extends Cubit<QuestionPageState> {
  List<CustomQuestionOverview> questions_overview = [];
  List<dynamic> questions = [];
  bool _isQuestionsLoading = true;
  bool _isBookmarked = false;
  PageController pgController = PageController();
  //late SingleQuestion _singleQuestion;
  QuestionPageCubit() : super(QuestionPageInitial());

  Future _getQuestion(Widget) async {
    emit(QuestionPageLoadingState());
    const storage = FlutterSecureStorage();
    try {
      final url = Uri.parse(Constants.GET_MCQS_URL + Widget.id);
      final McqToken = await storage.read(key: 'mcqtoken');
      final response = await http.get(url, headers: {
        'Authorization': 'Token $McqToken',
      });
      log(response.body.toString());
      if (response.statusCode == 200) {
        emit(QuestionPageLoadedSuccessState());
        questions = jsonDecode(response.body);
        log('Question = $questions');
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
      } else {
        emit(QuestionPageLoadingErrorState("Please try again"));
        print("Please try again");
      }
    } catch (e) {
      emit(QuestionPageLoadingErrorState("Something went wrong"));
      print("something went wrong");
    }
  }

  Future _markAnswer(
      int ans, String questionID, int questionIndex, Widget) async {
    // emit(state)
    const storage = FlutterSecureStorage();
    final McqToken = await storage.read(key: 'mcqtoken');
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
        questions[questionIndex]['answer'] = ans;
        questions_overview[questionIndex].ans = ans;

        Fluttertoast.showToast(
          msg: 'Answer marked successfully',
          backgroundColor: Colors.blue.shade600,
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: 'Could not mark your answer',
        //   backgroundColor: Colors.blue.shade600,
        // );
        // emit(ReviewStatusErrorState());
      }
      // print("Answer Api : " + response.statusCode.toString());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.blue.shade600,
      );
    }
  }

  Future _toggleBookMark(int questionIndex, Widget) async {
    const storage = FlutterSecureStorage();
    final McqToken = await storage.read(key: 'mcqtoken');
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

        _isBookmarked = !_isBookmarked;
        questions[questionIndex]['review_status'] =
            !questions[questionIndex]['review_status'];
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
}
