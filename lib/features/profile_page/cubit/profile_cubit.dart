import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../constants/static_objects.dart';

import '../../../constants/models/user_model.dart';
import '../../../constants/urls.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  Future<void> getUser() async {
    emit(ProfileLoading());
    if (Singleton.user != null) {
      emit(ProfileLoaded(Singleton.user!));

      return;
    } else {
      try {
        const storage = FlutterSecureStorage();
        final token = await storage.read(key: 'token');
        if (token == null) {
          emit(ProfileError('Logout and login again'));

          return;
        }
        Map<String, String> header = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var response =
            await http.get(Uri.parse(EndPoints.user), headers: header);
        var data = jsonDecode(response.body);
        log(data.toString());
        User user = User.fromJson(data['user']);
        Singleton.user = user;
        log(user.firstName! + user.lastName!);
        emit(ProfileLoaded(user));

        return;
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }
}
