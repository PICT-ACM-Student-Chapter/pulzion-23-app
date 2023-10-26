import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulzion23/features/mcq/mcqconstants.dart';
part 'mcq_login_state.dart';

class McqLoginCubit extends Cubit<McqLoginState> {
  McqLoginCubit() : super(McqLoginInitial());

  void toggleHideInput() {
    if (state is McqLoginInitial) {
      emit(McqLoginShowPass());
    } else {
      emit(McqLoginInitial());
    }
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    emit(McqLoginLoading());
    const storage = FlutterSecureStorage();
    try {
      Map<String, String> data = {"email": email, "password": password};
      final response = await http.post(
        Uri.parse(Constants.MCQ_LOGIN),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        await storage.write(key: 'mcqtoken', value: result['access']);
        emit(McqLoginSuccess());
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? "Login Failed!";
        throw error;
      }
    } catch (error) {
      emit(McqLoginError(error.toString()));
    }
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'mcqtoken');

    return Future.value();
  }
}
