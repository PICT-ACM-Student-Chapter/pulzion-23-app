import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'event_list_state.dart';

class EventListCubit extends Cubit<EventListState> {
  EventListCubit() : super(EventListInitial());
}
