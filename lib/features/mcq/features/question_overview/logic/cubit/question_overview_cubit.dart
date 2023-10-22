import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'question_overview_state.dart';

class QuestionOverviewCubit extends Cubit<QuestionOverviewState> {
  QuestionOverviewCubit() : super(QuestionOverviewInitial());
}
