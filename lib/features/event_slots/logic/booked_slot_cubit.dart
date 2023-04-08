import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/features/home_page/logic/event_details_cubit_cubit.dart';

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
