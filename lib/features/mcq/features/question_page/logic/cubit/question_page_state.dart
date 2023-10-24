part of 'question_page_cubit.dart';

abstract class QuestionPageState {}
// abstract class QuestionPageActionState{}

class QuestionPageInitial extends QuestionPageState {}

class QuestionPageLoadingState extends QuestionPageState {}

class QuestionPageLoadedSuccessState extends QuestionPageState {
  // add questions list
  //List<Object?> get questions=>[];
}

class QuestionPageLoadingErrorState extends QuestionPageState {
  // error string to be added
  String errorMessage = "";
  QuestionPageLoadingErrorState(this.errorMessage);
}
// class AnswerSelectedState extends QuestionPageState{

// }
// class AnswerSelectedandNavigateState extends QuestionPageActionState{

// }
//class AnswerSkippedState extends QuestionPageActionState{}
class ReviewStatusLoadingState extends QuestionPageState {}

class ReviewStatusLoadedSuccessState extends QuestionPageState {}

class ReviewStatusErrorState extends QuestionPageState {}

class TimerAddedInitialState extends QuestionPageState {}

//class TimerCompletedState extends QuestionPageActionState{}
class TimerLoadingErrorState extends QuestionPageState {}
// class QuestionBookmarkedState extends QuestionPageState{}
// class QuestionBookmarkedErrorState extends QuestionPageState{
//   final String message ="";

// }