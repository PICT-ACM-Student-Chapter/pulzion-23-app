import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'question_page_state.dart';

class QuestionPageCubit extends Cubit<QuestionPageState> {
  QuestionPageCubit() : super(QuestionPageInitial());
}
