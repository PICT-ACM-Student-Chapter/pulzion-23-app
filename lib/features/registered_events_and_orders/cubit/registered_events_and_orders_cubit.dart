import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/features/login_page/logic/login_cubit.dart';

import '../../../constants/models/registered_event.dart';
import '../../../constants/urls.dart';

part 'registered_events_and_orders_state.dart';

class RegisteredEventsAndOrdersCubit
    extends Cubit<RegisteredEventsAndOrdersState> {
  RegisteredEventsAndOrdersCubit() : super(RegisteredEventsAndOrdersLoading());

  Future<void> getRegisteredEventsAndOrders() async {
    emit(RegisteredEventsAndOrdersLoading());
    //await getOrders();

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
        // print(data);
        List<RegisteredEvent> registeredOrders = data['transactions']
            .map<RegisteredEvent>((e) => RegisteredEvent.fromJson(e))
            .toList();
        log(response.body);

        response = await http.get(
          Uri.parse(EndPoints.userEvents),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        var dataEve = jsonDecode(response.body);
        // print(data);
        List<Events> registeredEvents =
            dataEve['events'].map<Events>((e) => Events.fromJson(e)).toList();
        // log(response.body);
        emit(RegisteredEventsAndOrdersLoaded(
          registeredEvents,
          registeredOrders,
        ));
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

  Future<void> getOrders() async {
    emit(OrdersLoading());
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

        List<List<dynamic>> eventsList = [];

        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> transactions = jsonData['transactions'];

        for (dynamic transaction in transactions) {
          if (transaction['status'] != 'rejected') {
            List<dynamic> events = transaction['events'];
            eventsList.add(events);
          }

          List<String> l = [];
          for (var i in eventsList) {
            for (var j in i) {
              l.add(j);
            }
          }
          print(l);
          emit(OrdersLoaded(l));
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
