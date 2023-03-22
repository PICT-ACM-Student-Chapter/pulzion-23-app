import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants/models/event_model.dart';
import '../../../constants/urls.dart';

import '../../../constants/urls.dart';

part 'cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(CartPageLoading());

  Future<void> loadCart() async {
    emit(CartPageLoading());
    try {
      var response = await http.get(Uri.parse(EndPoints.events));
      var data = jsonDecode(response.body);
      EventList eventList = EventList.fromJson(data);
      print(eventList.events![0].name);
      emit(CartPageLoaded(eventList));
    } catch (e) {
      log(e.toString());
      emit(CartPageError());
    }
  }
}
