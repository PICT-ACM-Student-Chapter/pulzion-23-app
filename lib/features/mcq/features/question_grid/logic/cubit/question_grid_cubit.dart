import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'question_grid_state.dart';

class QuestionGridCubit extends Cubit<QuestionGridState> {
  QuestionGridCubit() : super(QuestionGridInitial());
}
