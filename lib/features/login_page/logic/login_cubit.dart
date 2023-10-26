import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../constants/models/user_model.dart';
import '../../../constants/static_objects.dart';

import '../../../constants/urls.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(
    String email,
    String password,
  ) async {
    emit(LoginLoading());
    try {
      var response = await http.post(
        Uri.parse(EndPoints.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Save token in secure storage
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: data['token']);

        Singleton.userToken = data['token'];
        Singleton.user = User.fromJson(data['user']);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(message: data['error'] ?? 'Invalid Credentials'));
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> sendOTP(String email) async {
    emit(LoginLoading());
    try {
      var response = await http.post(
        Uri.parse(EndPoints.otp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }),
      );
      var data = jsonDecode(response.body);
      if (data['error'] == 'User Not Found') {
        emit(UserNotFound());
      } else if (data['error'] != null) {
        emit(LoginFailure(message: data['error']));
      } else {
        // OTP sent successfully
        emit(OTPSent());
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> resetPassword(String otp, String newPwd, String email) async {
    emit(LoginLoading());
    try {
      var response = await http.post(
        Uri.parse(EndPoints.forget),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': newPwd,
          'otp': int.parse(otp),
        }),
      );
      var data = jsonDecode(response.body);
      if (data['error'] == 'User Not Found') {
        emit(UserNotFound());
      } else if (data['error'] == 'Invalid Otp') {
        emit(InvalidOTP());
      } else if (data['error'] != null) {
        emit(LoginFailure(message: data['error']));
      } else {
        // Password changed successfully
        emit(PasswordChangedSuccess());
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
