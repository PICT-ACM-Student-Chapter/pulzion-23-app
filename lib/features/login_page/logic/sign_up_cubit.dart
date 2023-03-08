import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constants/models/user_model.dart';
import '../../../constants/static_objects.dart';
import '../../../constants/urls.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String college,
    required String year,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      Map<String, dynamic> data = {};
      var response = await http.post(
        Uri.parse(EndPoints.signup),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'mobile_number': phone,
          'college': college,
          'year': year,
          'password': password,
        }),
      );
      data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Save token in secure storage
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: data['token']);

        Singleton.userToken = data['token'];
        Singleton.user = User.fromJson(data['user']);
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(message: data['error'] ?? 'Something went wrong'));
      }
    } catch (e) {
      emit(SignUpError(message: e.toString()));
    }
  }
}
