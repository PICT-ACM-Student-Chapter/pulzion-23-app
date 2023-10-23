part of 'mcq2_login_cubit.dart';

abstract class McqLoginState {}

class McqLoginInitial extends McqLoginState {}

class McqLoginLoading extends McqLoginState {}

class McqLoginShowPass extends McqLoginState {}

class McqLoginSuccess extends McqLoginState {}

class McqLoginError extends McqLoginState {
  String error;
  McqLoginError(this.error);
}

