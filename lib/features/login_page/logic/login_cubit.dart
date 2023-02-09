import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:pulzion23/constants/models/user_model.dart';
import 'package:pulzion23/constants/static_objects.dart';

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
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Singleton.userToken = data['token'];
        Singleton.user = User.fromJson(data['user']);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(message: 'Invalid Credentials'));
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}