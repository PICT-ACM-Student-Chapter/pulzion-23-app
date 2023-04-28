import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/constants/models/slot_model.dart';
import '../../../constants/models/booked_slot_model.dart';
part 'booked_slot_state.dart';

class EventSlotsCubit extends Cubit<EventSlotStateCubit> {
  EventSlotsCubit() : super(EventSlotLoadingState());

  Future<void> getAvailableSlots(int event_id) async {
    emit(EventSlotLoadingState());
    try {
      var response = await http.get(
        Uri.parse(
          'https://ems-test-server.onrender.com/slots?event_id=$event_id',
        ),
      );
      var data = jsonDecode(response.body);

      if (data == null) {
        emit(EventSlotErrorState('Some Error Occured'));
      }
      EventSlot slotList = EventSlot.fromJson(data);
      // (slotList.slots!.forEach((element) {
      //   log(element.capacity.toString());
      // }));
      emit(NotBookedSlotState(slotList));
    } catch (e) {
      log('error occured');
      log(e.toString());
      emit(EventSlotErrorState(e.toString()));
    }
  }

  Future<void> getBookedSlots(int event_id) async {
    emit(EventSlotLoadingState());
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');

      var response = await http.get(
        Uri.parse(
          'https://ems-test-server.onrender.com/user_slots?event_id=1',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      var data = jsonDecode(response.body);

      log(data);
      EventSlot slotList = EventSlot.fromJson(data);
      emit(NotBookedSlotState(slotList));
    } catch (e) {
      log(e.toString());
      emit(EventSlotErrorState(e.toString()));
    }
  }

  Future<void> bookSlot(String event_id, String slot_id) async {
    log('event_id: $event_id, slot_id: $slot_id');
    emit(EventSlotLoadingState());
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      try {
        var response = await http.post(
          Uri.parse(
            'https://ems-test-server.onrender.com/user_slots',
          ),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(
            {
              "event_id": int.parse(event_id),
              "slot_id": int.parse(slot_id),
            },
          ),
        );
        var data = jsonDecode(response.body);
        log(data.toString());

        if (data['error'] != null) {
          emit(EventSlotErrorState(data['error'].toString()));

          return;
        }
        emit(BookingSuccessful(
          BookedSlotModel.fromJson(data),
        ));
      } catch (e) {
        log(e.toString());
        emit(EventSlotErrorState(e.toString()));
      }
    } else {
      emit(EventSlotErrorState('User not logged in'));
    }
  }
}
