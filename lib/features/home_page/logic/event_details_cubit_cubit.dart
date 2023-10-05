import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants/models/event_model.dart';
import '../../../constants/urls.dart';

part 'event_details_cubit_state.dart';

class EventDetailsCubitCubit extends Cubit<EventDetailsCubitState> {
  EventDetailsCubitCubit() : super(EventDetailsCubitInitial());

  Future<void> getEventsDetails() async {
    emit(EventDetailsCubitLoading());
    try {
      var response = await http.get(Uri.parse(EndPoints.events));
      var data = jsonDecode(response.body);
      // log(data.toString());
      EventList eventList = EventList.fromJson(data);
      eventList.events?.forEach((e) {
        log(e.offers?.length.toString() ?? e.name!);
      });

      emit(EventDetailsCubitLoaded(eventList));
    } catch (e) {
      log(e.toString());
      emit(EventDetailsCubitError('Error'));
    }
  }
}
