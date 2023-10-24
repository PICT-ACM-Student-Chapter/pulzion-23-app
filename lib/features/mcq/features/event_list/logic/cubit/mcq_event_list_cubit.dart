import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulzion23/constants/mcqconstants.dart';
import 'package:pulzion23/features/mcq/models/mcq_event_model.dart';

part 'mcq_event_list_state.dart';

class EventListCubit extends Cubit<EventListState> {
  EventListCubit() : super(EventPageLoading());

  Future<void> loadEventPage() async {
    const storage = FlutterSecureStorage();
    final mcqToken = await storage.read(key: 'mcqtoken');
    Map<String, String> headers = {
      'Authorization': 'Token $mcqToken',
    };
    try {
      final url = Uri.parse(Constants.GET_MCQ_EVENTS);
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        var result = await jsonDecode(response.body);
        MCQList.mcqEventList.clear();
        MCQList.fromJson(result);
        emit(EventPageCurrentEvents());
      } else {
        var result = jsonDecode(response.body);
        var error =
            result['error'] ?? 'There is some problem currently not possible!';
        emit(EventPageError(result[error].toString()));
      }
    } catch (error) {
      emit(EventPageError('There is some problem currently not possible!'));
    }
  }
}
