import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulzion23/constants/mcqconstants.dart';
import 'package:pulzion23/features/mcq/models/mcq_event_model.dart';
import 'package:pulzion23/features/mcq/models/mcq_event_statusmodel.dart';

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
        MCQList mcqList = MCQList.fromJson(result);
        emit(EventPageCurrentEvents(mcqList: mcqList));
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

  Future getMCQEventDetails(String id) async {
    emit(EventPageLoading());
    const storage = FlutterSecureStorage();
    final mcqToken = await storage.read(key: 'mcqtoken');

    try {
      final url = Uri.parse(Constants.GET_MCQ_EVENT_DETAILS + id);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $mcqToken',
        },
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        await storage.write(key: 'mcqId', value: id);
        var result = jsonDecode(response.body);
        McqStatus mcqStatus = McqStatus.fromJson(result);
        emit(SingleEventStatus(mcqStatus: mcqStatus));
       
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? 'There is some problem currently';
        throw error;
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.blue.shade600,
      );
      emit(EventPageError(error.toString()));
    }
  }
}
