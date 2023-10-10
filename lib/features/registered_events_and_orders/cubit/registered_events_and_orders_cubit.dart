import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/constants/models/booked_slot_model.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/features/home_page/logic/event_details_cubit_cubit.dart';

import '../../../constants/models/registered_event.dart';
import '../../../constants/urls.dart';

part 'registered_events_and_orders_state.dart';

class RegisteredEventsAndOrdersCubit
    extends Cubit<RegisteredEventsAndOrdersState> {
  RegisteredEventsAndOrdersCubit() : super(RegisteredEventsAndOrdersLoading());

  Future<void> getRegisteredEventsAndOrders(EventList events) async {
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
        var dataEve = jsonDecode(response.body)['transactions'];

        List<Events> registeredEvents = [];
        List<String> registeredCombos = [];

        dataEve.forEach((element) {
          element['events'].forEach((ev) {
            registeredEvents.add(
              events.events!.firstWhere(
                (event) => event.name == ev,
              ),
            );
          });
          element['combo']?.forEach((ev) {
            registeredCombos.add(ev);
          });
        });

        log(registeredCombos.toString());
        emit(RegisteredEventsAndOrdersLoaded(
          registeredEvents,
          registeredOrders,
          registeredCombos,
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

  Future<void> getUpdatedEvents(BuildContext context) async {
    emit(RegisteredOrdersandEventsUpdates());
    await getRegisteredEventsAndOrders((context
            .read<EventDetailsCubitCubit>()
            .state as EventDetailsCubitLoaded)
        .events);
  }

  Future<void> getOnlyRegisteredEvents() async {
    emit(RegisteredEventsAndOrdersLoading());

    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      http.Response? response;
      try {
        response = await http.get(
          Uri.parse(EndPoints.userEvents),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );

        var dataEve = jsonDecode(response.body);
        List<BookedSlotModel> eventList = dataEve['events']
            .map<BookedSlotModel>((e) => BookedSlotModel.fromJson(e))
            .toList();
        log(response.body);
        emit(RegisteredEvents(
          eventList,
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
}
