part of 'mcq_login_cubit.dart';

abstract class McqLoginState {}

class McqLoginInitial extends McqLoginState {}

class McqLoginLoading extends McqLoginState {}

class McqLoginShowPass extends McqLoginState {}

class McqLoginError extends McqLoginState {
  String error;
  McqLoginError(this.error);
}

class McqLoginSuccess extends McqLoginState {}
