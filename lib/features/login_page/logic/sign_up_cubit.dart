import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../constants/models/user_model.dart';
import '../../../constants/static_objects.dart';
import '../../../constants/urls.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String phone,
    String college,
    String year,
    String password,
  ) async {
    emit(SignUpLoading());
    try {
      Map<String, dynamic> data = {};
      var response = await http.post(
        Uri.parse(EndPoints.signup),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone,
          'college': college,
          'year': year,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        Singleton.userToken = data['token'];
        Singleton.user = User.fromJson(data['user']);
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(message: data['message'] ?? 'Something went wrong'));
      }
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(message: e.toString()));
    }
  }
}
