import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulzion23/constants/mcqconstants.dart';
part 'mcq2_login_state.dart';

class Mcq2_LoginCubit extends Cubit<Mcq2_LoginState> {
  Mcq2_LoginCubit() : super(Mcq2_LoginInitial());

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  void toggleHideInput() {
    if (state is Mcq2_LoginInitial) {
      emit(Mcq2_LoginShowPass());
    } else {
      emit(Mcq2_LoginInitial());
    }
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    emit(Mcq2_LoginLoading());
    const storage = FlutterSecureStorage();
    try {
      Map data = {"email": email, "password": password};
      final response = await http.post(
        Uri.parse(Constants.MCQ_LOGIN),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        await storage.write(key: 'mcqtoken', value: result['access']);
        // final value = Provider.of<MCQUserProvider>(context, listen: false);
        // value.setToken(result['access']);

        emit(Mcq2_LoginSuccess());
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? "Login Failed!";
        throw error;
      }
    } catch (error) {
      emit(Mcq2_LoginError(error.toString()));
    }
  }
}
