part of 'question_page_cubit.dart';

abstract class QuestionPageState {}

class QuestionPageInitial extends QuestionPageState {}

class QuestionPageLoadingState extends QuestionPageState {}

class QuestionPageLoadedSuccessState extends QuestionPageState {
  final QuestionList questions;
  QuestionPageLoadedSuccessState({required this.questions});
}

class QuestionPageLoadingErrorState extends QuestionPageState {
  String errorMessage = "";
  QuestionPageLoadingErrorState(this.errorMessage);
}

class SubmitLoadingState extends QuestionPageState {}

class SubmitSuccessState extends QuestionPageState {}

class SubmitErrorState extends QuestionPageState {
  String errorMessage = "";
  SubmitErrorState(this.errorMessage);
}
