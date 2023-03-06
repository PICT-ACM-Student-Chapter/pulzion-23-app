part of 'check_login_cubit.dart';

@immutable
abstract class CheckLoginState {}

class CheckLoginInitial extends CheckLoginState {}

class CheckLoginLoading extends CheckLoginState {}

class CheckLoginSuccess extends CheckLoginState {}

class CheckLoginFailure extends CheckLoginState {
  final String message;

  CheckLoginFailure(this.message);
}
