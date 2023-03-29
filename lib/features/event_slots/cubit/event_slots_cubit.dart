import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../../constants/urls.dart';
// import '../../../constants/urls.dart';
// import '../../../models/event_slots_model.dart';

part 'event_slots_state.dart';

class EventSlotsCubit extends Cubit<EventSlotsState> {
  EventSlotsCubit() : super(EventSlotsInitial());

  Future<void> loadEvent() async{
    emit(EventSlotsLoading());
    
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if(token != null){
      Response? response;
      try{
        response = await http.get(
          Uri.parse(EndPoints.eventslots),
          headers:{
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        if(response.statusCode == 200){
          var data = jsonDecode(response.body);
          emit(EventSlotsLoaded(data));
      }
      else if(response.statusCode == 404){
        emit(EventSlotsError('No events found'));
      }
      else{
        emit(EventSlotsError('Something went wrong'));
      }
      } catch(e){
        if(response == null){
           log('Load cart exception: $e');
          emit(EventSlotsError('Failed host lookup.'));
        }else{
          log('Load cart exception: $e');
          emit(EventSlotsError(e.toString()));
        }
      }
    }else{
      emit(EventSlotsError('logout and login again'));
    }
  }
}
