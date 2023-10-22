import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mcq_event_list_state.dart';

class McqEventListCubit extends Cubit<McqEventListState> {
  McqEventListCubit() : super(McqEventListInitial());
}
