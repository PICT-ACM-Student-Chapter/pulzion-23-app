import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/mcqconstants.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/features/mcq/models/mcq_questions_model.dart';
part 'question_page_state.dart';
//import '';

class QuestionPageCubit extends Cubit<QuestionPageState> {
  QuestionPageCubit() : super(QuestionPageInitial());

  Future<void> loadQuestions(String id) async {
    log('loading questions');
    emit(QuestionPageLoadingState());
    const storage = FlutterSecureStorage();
    try {
      final url = Uri.parse(Constants.GET_MCQS_URL + id);
      final mcqToken = await storage.read(key: 'mcqtoken');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $mcqToken',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        QuestionList questionList = QuestionList.fromJson(data);
        log('THESE ARE THE QUESTIONS = ' + questionList.questions.toString());
        emit(QuestionPageLoadedSuccessState(questions: questionList));
      } else {
        emit(QuestionPageLoadingErrorState("Please try again"));
      }
    } catch (e) {
      emit(QuestionPageLoadingErrorState("Something went wrong..."));
    }
  }

  Future<bool> markAnswer(int ans, String questionID) async {
    log('marking answer');
    const storage = FlutterSecureStorage();
    final mcqToken = await storage.read(key: 'mcqtoken');
    try {
      final url = Uri.parse(Constants.MARK_ANSWER_URL);
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $mcqToken',
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'answer': ans,
          'id': questionID,
        }),
      );
      if (response.statusCode == 200) {
        log("answer marked");
        Fluttertoast.showToast(
          msg: 'Answer marked successfully',
          backgroundColor: Colors.blue.shade600,
        );

        return true;
      } else {
        Fluttertoast.showToast(
          msg: 'Could not mark your answer',
          backgroundColor: Colors.blue.shade600,
        );

        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.blue.shade600,
      );

      return false;
    }
  }

  Future<bool> toggleBookMark(String questionID, bool isBookmarked) async {
    const storage = FlutterSecureStorage();
    final mcqToken = await storage.read(key: 'mcqtoken');
    try {
      final url = Uri.parse(Constants.MARK_ANSWER_URL);
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $mcqToken',
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'review_status': isBookmarked,
          'id': questionID,
          // 'id': questions[questionIndex]['id'],
        }),
      );
      if (response.statusCode == 200) {
        log("bookmark toggled");

        return true;
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to mark',
          backgroundColor: Colors.blue.shade600,
        );

        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        backgroundColor: Colors.blue.shade600,
      );

      return false;
    }
  }

  Future autoSubmitQuiz() async {
    const storage = FlutterSecureStorage();
    final mcqToken = await storage.read(key: 'mcqtoken');
    final mcqId = await storage.read(key: 'mcqId');

    Map<String, String> headers = {
      'Authorization': 'Token $mcqToken',
    };
    try {
      final url = Uri.parse(Constants.SUBMIT_MCQ + mcqId.toString());
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
  }

  Future<bool> submitQuiz() async {
    log('submitting quiz');
    const storage = FlutterSecureStorage();
    final mcqToken = await storage.read(key: 'mcqtoken');
    final mcqId = await storage.read(key: 'mcqId');
    try {
      final url = Uri.parse(Constants.SUBMIT_MCQ + mcqId.toString());
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $mcqToken',
        },
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        Fluttertoast.showToast(
          msg: "Test submitted successfully",
          backgroundColor: Colors.blue.shade600,
        );

        return true;
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? 'There is some problem currently';
        throw error;
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.blue.shade600,
      );

      return false;
    }
  }
}
