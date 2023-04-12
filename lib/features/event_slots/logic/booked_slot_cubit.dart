import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'booked_slot_state.dart';

class EventSlotsCubit extends Cubit<EventSlotStateCubit> {
  EventSlotsCubit() : super(EventSlotInitialState());

  Future<void> getBookingDetails() async {
    emit(BookedSlotState());
    // emit(EventSlotLoadingState());
    // try {
    //   var response = await http.get(Uri.parse(''));
    //   if (jsonDecode(response.body)['bookstatus'] == 'True') {
    //     emit(BookedSlotState());
    //   } else {
    //     emit(NotBookedSlotState());
    //   }
    // } catch (error) {
    //   log(error.toString());
    //   emit(EventSlotErrorState(error.toString()));
    // }
  }
}
