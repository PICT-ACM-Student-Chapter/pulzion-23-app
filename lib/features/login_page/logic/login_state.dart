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

class OTPSent extends LoginState {}

class UserNotFound extends LoginState {}

class InvalidOTP extends LoginState {}

class PasswordChangedSuccess extends LoginState {}
