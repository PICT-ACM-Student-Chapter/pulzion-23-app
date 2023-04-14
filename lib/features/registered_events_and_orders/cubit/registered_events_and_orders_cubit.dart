import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constants/models/registered_event.dart';
import '../../../constants/urls.dart';

part 'registered_events_and_orders_state.dart';

class RegisteredEventsAndOrdersCubit extends Cubit<RegisteredEventsAndOrdersState> {
  RegisteredEventsAndOrdersCubit() : super(RegisteredEventsAndOrdersLoading());

  Future<void> getRegisteredEventsAndOrders() async {
    emit(RegisteredEventsAndOrdersLoading());

    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      http.Response? response;
      try {
        response = await http.get(
          Uri.parse(EndPoints.transaction),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        var data = jsonDecode(response.body);
        List<RegisteredEvent> registeredEvents =
            data['transactions'].map<RegisteredEvent>((e) => RegisteredEvent.fromJson(e)).toList();
        log(response.body);
        emit(RegisteredEventsAndOrdersLoaded(registeredEvents));
      } catch (e) {
        if (response == null) {
          log('Registered Events Page Exception: $e');
          emit(RegisteredEventsAndOrdersError('Failed host lookup.'));
        } else {
          log('Registered Events Page Exception: $e');
          emit(RegisteredEventsAndOrdersError(e.toString()));
        }
      }
    } else {
      emit(RegisteredEventsAndOrdersError('Logout and login again.'));
    }
  }
}
