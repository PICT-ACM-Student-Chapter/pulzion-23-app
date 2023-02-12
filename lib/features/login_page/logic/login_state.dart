part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}