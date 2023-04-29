import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../constants/urls.dart';
import 'package:pulzion23/constants/models/slot_model.dart';
import '../../../constants/models/booked_slot_model.dart';
part 'booked_slot_state.dart';

class EventSlotsCubit extends Cubit<EventSlotStateCubit> {
  EventSlotsCubit() : super(EventSlotLoadingState());

  Future<void> getAvailableSlots(int event_id) async {
    emit(EventSlotLoadingState());
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');

      var response = await http.get(
        Uri.parse(
          "${EndPoints.getSlots}$event_id",
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var data = jsonDecode(response.body);

      if (data == null) {
        emit(EventSlotErrorState('Some Error Occured'));

        return;
      }

      if (data['error'] != null) {
        emit(EventSlotErrorState(data['error'].toString()));

        return;
      }

      EventSlot slotList = EventSlot.fromJson(data);

      if (slotList.slots!.length == 0) {
        emit(NoAvailableSlots());

        return;
      }
      // log(data.toString());

      emit(NotBookedSlotState(slotList));
    } catch (e) {
      log('error occured');
      log(e.toString());
      emit(EventSlotErrorState(e.toString()));
    }
  }

  // Future<void> getBookedSlots(int event_id) async {
  //   emit(EventSlotLoadingState());
  //   try {
  //     const storage = FlutterSecureStorage();
  //     var token = await storage.read(key: 'token');

  //     var response = await http.get(
  //       Uri.parse(
  //         '${EndPoints.getSlots}$event_id',
  //       ),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token",
  //       },
  //     );
  //     var data = jsonDecode(response.body);

  //     log(data);
  //     EventSlot slotList = EventSlot.fromJson(data);
  //     // log(slotList.toString());
  //     emit(NotBookedSlotState(slotList));
  //   } catch (e) {
  //     log(e.toString());
  //     emit(EventSlotErrorState(e.toString()));
  //   }
  // }

  Future<void> bookSlot(String event_id, String slot_id) async {
    log('event_id: $event_id, slot_id: $slot_id');
    emit(EventSlotLoadingState());
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      try {
        var response = await http.post(
          Uri.parse(
            EndPoints.bookSlots,
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
