part of 'mcq_login_cubit.dart';

abstract class Mcq_LoginState {}

class Mcq_LoginInitial extends Mcq_LoginState {}

class Mcq_LoginLoading extends Mcq_LoginState {}

class Mcq_LoginShowPass extends Mcq_LoginState {}

class Mcq_LoginError extends Mcq_LoginState {
  String error;
  Mcq_LoginError(this.error);
}

class Mcq_LoginSuccess extends Mcq_LoginState {}
